import 'package:flutter/foundation.dart';
import 'package:base/database/favorit_database.dart';
import 'package:base/models/list_restaurant_model.dart';

class FavoriteNotifier extends ChangeNotifier {
  static final FavoriteNotifier _instance = FavoriteNotifier._internal();
  factory FavoriteNotifier() => _instance;
  FavoriteNotifier._internal();

  List<Restaurants> _favorites = [];
  bool _isLoaded = false;

  List<Restaurants> get favorites => List.unmodifiable(_favorites);
  bool get isLoaded => _isLoaded;

  /// Initialize and load favorites from database
  Future<void> initialize() async {
    try {
      await FavoritDatabase.load();
      _favorites = FavoritDatabase.getAllFavorites();
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      print('Error initializing favorites: $e');
      _favorites = [];
      _isLoaded = true;
      notifyListeners();
    }
  }

  /// Check if a restaurant is in favorites
  bool isFavorite(String restaurantId) {
    return _favorites.any((restaurant) => restaurant.id == restaurantId);
  }

  /// Add a restaurant to favorites
  Future<void> addToFavorites(Restaurants restaurant) async {
    try {
      if (!isFavorite(restaurant.id ?? '')) {
        await FavoritDatabase.addToFavorites(restaurant);
        _favorites = FavoritDatabase.getAllFavorites();
        notifyListeners();
      }
    } catch (e) {
      print('Error adding to favorites: $e');
      rethrow;
    }
  }

  /// Remove a restaurant from favorites
  Future<void> removeFromFavorites(String restaurantId) async {
    try {
      if (isFavorite(restaurantId)) {
        await FavoritDatabase.removeFromFavorites(restaurantId);
        _favorites = FavoritDatabase.getAllFavorites();
        notifyListeners();
      }
    } catch (e) {
      print('Error removing from favorites: $e');
      rethrow;
    }
  }

  /// Toggle favorite status
  Future<bool> toggleFavorite(Restaurants restaurant) async {
    try {
      final wasRemovedInitially = isFavorite(restaurant.id ?? '');

      await FavoritDatabase.toggleFavorite(restaurant);
      _favorites = FavoritDatabase.getAllFavorites();
      notifyListeners();

      return !wasRemovedInitially; // Return true if added, false if removed
    } catch (e) {
      print('Error toggling favorite: $e');
      rethrow;
    }
  }

  /// Refresh favorites from database
  Future<void> refresh() async {
    try {
      await FavoritDatabase.load();
      _favorites = FavoritDatabase.getAllFavorites();
      notifyListeners();
    } catch (e) {
      print('Error refreshing favorites: $e');
    }
  }

  /// Clear all favorites
  Future<void> clearAllFavorites() async {
    try {
      await FavoritDatabase.clear();
      _favorites = [];
      notifyListeners();
    } catch (e) {
      print('Error clearing favorites: $e');
      rethrow;
    }
  }
}
