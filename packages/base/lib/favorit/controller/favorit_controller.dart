import 'dart:developer';

import 'package:base/favorit/view/favorit_view.dart';
import 'package:base/notifier/favorite_notifier.dart';
import 'package:flutter/material.dart';

class FavoritController extends State<FavoritView> {
  static late FavoritController instance;
  late FavoritView view;

  @override
  void initState() {
    instance = this;
    super.initState();
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

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
