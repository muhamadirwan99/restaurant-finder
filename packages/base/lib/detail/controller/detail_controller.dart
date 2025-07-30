// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:base/database/favorit_database.dart';
import 'package:base/models/detail_restaurant_model.dart';
import 'package:base/models/list_restaurant_model.dart';
import 'package:base/service/api_service_base.dart';
import 'package:base/notifier/favorite_notifier.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../view/detail_view.dart';

class DetailController extends State<DetailView> {
  static late DetailController instance;
  late DetailView view;

  ApiServiceBase api = ApiServiceBase();
  DetailRestaurantModel? detailData;
  bool isLoading = true;
  String? errorMessage;
  bool isDescriptionExpanded = false;
  double latitude = 0;
  double longitude = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    instance = this;
    super.initState();
    getDetailRestaurant();
    // Initialize favorite notifier
    _initializeFavorites();
  }

  Future<void> _initializeFavorites() async {
    try {
      await FavoriteNotifier().initialize();
    } catch (e) {
      log('Error initializing favorites: $e');
    }
  }

  // Favorite functionality
  Future<void> toggleFavorite(Restaurants restaurant) async {
    try {
      await FavoritDatabase.toggleFavorite(restaurant);
      setState(() {}); // Update UI to reflect favorite status change
    } catch (e) {
      // Show error message to user
      if (mounted) {
        showInfoDialog('Error updating favorites: $e');
      }
    }
  }

  bool isFavorite(String restaurantId) {
    return FavoritDatabase.isFavorite(restaurantId);
  }

  getLatLongFromAddress(String address) async {
    List<Location> listData = await locationFromAddress(address);
    Location data = listData.first;

    setState(() {
      latitude = data.latitude;
      longitude = data.longitude;
    });
  }

  getDetailRestaurant() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      DetailRestaurantModel result = await api.detailRestaurant(id: widget.id);

      await getLatLongFromAddress('${result.restaurant?.address}, ${result.restaurant?.city}');

      setState(() {
        detailData = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
      await showInfoDialog(e.toString());
    }
  }

  submitReviewRestaurant({required String review}) async {
    showCircleDialogLoading();
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        throw Exception('User not logged in');
      }

      CollectionReference users = _firestore.collection('users');
      DocumentSnapshot userDoc = await users.doc(userId).get();

      if (!userDoc.exists) {
        throw Exception('User data not found');
      }

      await api.reviewRestaurant(
        id: widget.id,
        name: userDoc['name'],
        review: review,
      );

      getDetailRestaurant();

      Get.back(); // Close the loading dialog

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Review submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      Get.back();
      await showInfoDialog(e.toString());
    }
  }

  void toggleDescriptionExpansion() {
    setState(() {
      isDescriptionExpanded = !isDescriptionExpanded;
    });
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
