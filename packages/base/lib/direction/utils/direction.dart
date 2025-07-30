import 'dart:developer';

import 'package:core/core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../models/direction_model.dart';

class Direction {
  final LatLngBounds bounds;

  final List<LatLng> polylinePoints;

  const Direction._({
    required this.bounds,
    required this.polylinePoints,
  });

  static Future<Direction?> getDirections({
    required String directionMapsApiKey,
    required LatLng origin,
    required LatLng destination,
  }) async {
    final dio = Dio();

    // OpenRouteService API endpoint
    const String baseUrl = 'https://api.openrouteservice.org/v2/directions/driving-car';

    // Request body for OpenRouteService
    final requestBody = {
      'coordinates': [
        [origin.longitude, origin.latitude],
        [destination.longitude, destination.latitude],
      ],
    };

    final response = await dio.post(
      baseUrl,
      data: requestBody,
      options: Options(
        headers: {
          'Authorization': directionMapsApiKey, // OpenRouteService typically uses this format
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      final mapData = response.data;

      // Parse response using DirectionModel
      final directionModel = DirectionModel.fromJson(mapData);

      if (directionModel.routes == null || directionModel.routes!.isEmpty) {
        return null;
      } else {
        return Direction._fromDirectionModel(directionModel);
      }
    } else {
      return null;
    }
  }

  factory Direction._fromDirectionModel(DirectionModel model) {
    try {
      final route = model.routes!.first;

      // Get bbox (bounding box) from DirectionModel
      final bbox = route.bbox ?? model.bbox ?? [];
      final bounds = LatLngBounds(
        southwest: LatLng(bbox[1], bbox[0]), // [minLon, minLat, maxLon, maxLat]
        northeast: LatLng(bbox[3], bbox[2]),
      );

      // Get geometry coordinates from DirectionModel
      List<LatLng> polylinePoints = [];

      if (route.geometry != null) {
        // Encoded polyline format (default dari OpenRouteService)
        polylinePoints = _decodePolyline(route.geometry!);
      }

      return Direction._(
        bounds: bounds,
        polylinePoints: polylinePoints,
      );
    } catch (e) {
      log('Error parsing DirectionModel: $e');
      rethrow;
    }
  }

  static List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyLines = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dLat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dLng;
      final p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      polyLines.add(p);
    }
    return polyLines;
  }
}
