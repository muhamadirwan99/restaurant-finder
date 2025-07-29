import 'package:base/beranda/view/beranda_view.dart';
import 'package:base/models/list_restaurant_model.dart';
import 'package:base/service/api_service_base.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BerandaController extends State<BerandaView> {
  static late BerandaController instance;
  late BerandaView view;

  ApiServiceBase api = ApiServiceBase();
  dynamic dataFuture;

  // Search functionality
  TextEditingController searchController = TextEditingController();
  List<Restaurants?>? allRestaurants;
  List<Restaurants?>? filteredRestaurants;
  List<Restaurants?>? featuredRestaurants; // Store featured restaurants once

  getListRestaurant() async {
    try {
      ListRestaurantModel result = await api.listRestaurant();
      allRestaurants = result.restaurants;
      filteredRestaurants = allRestaurants;

      // Set featured restaurants once when data is loaded
      _setFeaturedRestaurants();

      return result;
    } catch (e) {
      await showInfoDialog(e.toString());
    }
  }

  void _setFeaturedRestaurants() {
    if (allRestaurants == null || allRestaurants!.isEmpty) {
      featuredRestaurants = [];
      return;
    }

    // Create a copy and shuffle it once
    List<Restaurants?> shuffled = List.from(allRestaurants!);
    shuffled.shuffle();

    // Set 3-4 random restaurants that won't change until next app restart
    featuredRestaurants = shuffled.take(4).toList();
  }

  void searchRestaurants(String query) {
    if (query.isEmpty) {
      filteredRestaurants = allRestaurants;
    } else {
      filteredRestaurants = allRestaurants?.where((restaurant) {
        final name = restaurant?.name?.toLowerCase() ?? '';
        final city = restaurant?.city?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();

        return name.contains(searchQuery) || city.contains(searchQuery);
      }).toList();
    }
    setState(() {});
  }

  void clearSearch() {
    searchController.clear();
    filteredRestaurants = allRestaurants;
    setState(() {});
  }

  void searchByCity(String city) {
    searchController.text = city;
    searchRestaurants(city);
  }

  // Remove the old getFeaturedRestaurants method since we now store it in featuredRestaurants variable

  List<String> getPopularCities() {
    if (allRestaurants == null) return [];

    Map<String, int> cityCount = {};
    for (var restaurant in allRestaurants!) {
      if (restaurant?.city != null) {
        cityCount[restaurant!.city!] = (cityCount[restaurant.city!] ?? 0) + 1;
      }
    }

    // Get top 5 cities sorted by count
    var sortedCities = cityCount.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return sortedCities.take(5).map((e) => e.key).toList();
  }

  goToDetailRestaurant(String id) {
    // Navigate to restaurant detail page
    // Get.toNamed("/restaurant/detail", arguments: {"id": id});
  }

  @override
  void initState() {
    instance = this;
    dataFuture = getListRestaurant();
    searchController.addListener(() {
      searchRestaurants(searchController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
