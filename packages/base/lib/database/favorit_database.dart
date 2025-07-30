import 'dart:developer';

import 'package:base/base.dart';
import 'package:core/core.dart';

class FavoritDatabase {
  static List<Restaurants> restaurants = [];

  static Future<void> load() async {
    try {
      final data = mainStorage.get("favorite_restaurants");
      if (data != null && data is List) {
        restaurants = data.map((e) {
          // Convert dynamic map to Map<String, dynamic>
          if (e is Map) {
            return Restaurants.fromJson(Map<String, dynamic>.from(e));
          }
          return Restaurants.fromJson(e);
        }).toList();
      } else {
        restaurants = [];
      }
    } catch (e) {
      // If there's an error loading favorites, start with empty list
      restaurants = [];
      log('Error loading favorites: $e');
    }
  }

  static Future<void> save(List<Restaurants> restaurants) async {
    try {
      final data = restaurants.map((e) => e.toJson()).toList();
      await mainStorage.put("favorite_restaurants", data);
      FavoritDatabase.restaurants = List.from(restaurants);
    } catch (e) {
      log('Error saving favorites: $e');
    }
  }

  static Future<void> clear() async {
    await mainStorage.delete("favorite_restaurants");
    restaurants = [];
  }

  // Add a restaurant to favorites
  static Future<void> addToFavorites(Restaurants restaurant) async {
    if (!isFavorite(restaurant.id ?? '')) {
      restaurants.add(restaurant);
      await save(restaurants);
    }
  }

  // Remove a restaurant from favorites
  static Future<void> removeFromFavorites(String restaurantId) async {
    restaurants.removeWhere((restaurant) => restaurant.id == restaurantId);
    await save(restaurants);
  }

  // Check if a restaurant is in favorites
  static bool isFavorite(String restaurantId) {
    return restaurants.any((restaurant) => restaurant.id == restaurantId);
  }

  // Toggle favorite status
  static Future<void> toggleFavorite(Restaurants restaurant) async {
    if (isFavorite(restaurant.id ?? '')) {
      await removeFromFavorites(restaurant.id ?? '');
    } else {
      await addToFavorites(restaurant);
    }
  }

  // Get all favorite restaurants
  static List<Restaurants> getAllFavorites() {
    return List.from(restaurants);
  }
}
