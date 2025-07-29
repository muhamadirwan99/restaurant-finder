import 'package:base/favorit/view/favorit_view.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class FavoritController extends State<FavoritView> {
  static late FavoritController instance;
  late FavoritView view;

  List favoriteItems = [];

  void addFavorite(Map<String, dynamic> item) {
    setState(() {
      // Check if item is already in favorites
      bool exists = favoriteItems.any((favorite) => favorite["id"] == item["id"]);
      if (!exists) {
        favoriteItems.add(item);
        showInfoDialog("Restaurant ditambahkan ke favorit!");
      } else {
        showInfoDialog("Restaurant sudah ada di favorit!");
      }
    });
  }

  void removeFavorite(int id) {
    setState(() {
      favoriteItems.removeWhere((item) => item["id"] == id);
      showInfoDialog("Restaurant dihapus dari favorit!");
    });
  }

  bool isFavorite(int id) {
    return favoriteItems.any((item) => item["id"] == id);
  }

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
