import 'package:base/models/detail_restaurant_model.dart';
import 'package:base/service/api_service_base.dart';
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

  @override
  void initState() {
    instance = this;
    super.initState();
    getDetailRestaurant();
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
