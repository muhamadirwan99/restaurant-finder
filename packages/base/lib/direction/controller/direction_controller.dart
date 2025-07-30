import 'dart:math';
import 'package:base/direction/utils/direction.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import '../view/direction_view.dart';

class DirectionController extends State<DirectionView> {
  static late DirectionController instance;
  late DirectionView view;

  late gmaps.GoogleMapController mapController;
  late final Set<gmaps.Marker> markers = {};
  gmaps.LatLng targetLatLng = const gmaps.LatLng(0.0, 0.0);
  bool isLoadingLocation = true;
  String? locationError;
  final Set<gmaps.Polyline> polylines = <gmaps.Polyline>{};

  // New properties for route information
  String? estimatedTime;
  String? estimatedDistance;

  Future<void> setPolylines(gmaps.LatLng source, gmaps.LatLng destination) async {
    final result = await Direction.getDirections(
      directionMapsApiKey: dotenv.env['DIRECTION_API_KEY'] ?? '',
      origin: source,
      destination: destination,
    );

    final polylineCoordinates = <gmaps.LatLng>[];
    if (result != null && result.polylinePoints.isNotEmpty) {
      polylineCoordinates.addAll(result.polylinePoints);

      // Extract route information if available
      // Note: You might want to modify Direction class to return more info
      _updateRouteInfo(result);
    }

    final polyline = gmaps.Polyline(
      polylineId: const gmaps.PolylineId('default-polyline'),
      color: primaryColor,
      width: 3,
      points: polylineCoordinates,
    );

    setState(() {
      polylines.add(polyline);
    });

    if (result != null) {
      mapController.animateCamera(
        gmaps.CameraUpdate.newLatLngBounds(result.bounds, 100),
      );
    }
  }

  void _updateRouteInfo(Direction result) {
    // Calculate approximate distance from polyline points
    double totalDistance = 0;
    final points = result.polylinePoints;

    if (points.length > 1) {
      for (int i = 0; i < points.length - 1; i++) {
        totalDistance += _calculateDistance(points[i], points[i + 1]);
      }
    }

    // Estimate time based on average speed (assuming 30 km/h in city)
    double estimatedTimeInMinutes = (totalDistance / 1000) * (60 / 30);

    setState(() {
      estimatedDistance = '${(totalDistance / 1000).toStringAsFixed(1)} km';
      estimatedTime = '${estimatedTimeInMinutes.round()} menit';
    });
  }

  double _calculateDistance(gmaps.LatLng point1, gmaps.LatLng point2) {
    // Simple distance calculation (Haversine formula approximation)
    const double earthRadius = 6371000; // meters
    double dLat = (point2.latitude - point1.latitude) * (pi / 180);
    double dLng = (point2.longitude - point1.longitude) * (pi / 180);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLng / 2) *
            sin(dLng / 2) *
            cos(point1.latitude * pi / 180) *
            cos(point2.latitude * pi / 180);

    double c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }

  void centerMap() {
    if (polylines.isNotEmpty) {
      // Center map to show the route
      final polyline = polylines.first;
      if (polyline.points.isNotEmpty) {
        final bounds = _calculateBounds(polyline.points);
        mapController.animateCamera(
          gmaps.CameraUpdate.newLatLngBounds(bounds, 100),
        );
      }
    }
  }

  gmaps.LatLngBounds _calculateBounds(List<gmaps.LatLng> points) {
    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final point in points) {
      minLat = minLat < point.latitude ? minLat : point.latitude;
      maxLat = maxLat > point.latitude ? maxLat : point.latitude;
      minLng = minLng < point.longitude ? minLng : point.longitude;
      maxLng = maxLng > point.longitude ? maxLng : point.longitude;
    }

    return gmaps.LatLngBounds(
      southwest: gmaps.LatLng(minLat, minLng),
      northeast: gmaps.LatLng(maxLat, maxLng),
    );
  }

  void update() {
    if (mounted) setState(() {});
  }

  Future<void> openGoogleMapsNavigation() async {
    // Show loading feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: 12),
            Text('Membuka Google Maps...'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );

    final String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1'
        '&origin=${UserDataDatabase.lat},${UserDataDatabase.lng}'
        '&destination=${targetLatLng.latitude},${targetLatLng.longitude}'
        '&travelmode=driving';

    try {
      final Uri uri = Uri.parse(googleMapsUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback: try to open with intent on Android
        final String fallbackUrl =
            'google.navigation:q=${targetLatLng.latitude},${targetLatLng.longitude}&mode=d';
        final Uri fallbackUri = Uri.parse(fallbackUrl);

        if (await canLaunchUrl(fallbackUri)) {
          await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
        } else {
          // Show error if can't open
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tidak dapat membuka Google Maps. Pastikan aplikasi terinstall.'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terjadi kesalahan saat membuka Google Maps.'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    instance = this;

    targetLatLng = gmaps.LatLng(widget.lat, widget.lng);

    // Initialize with default values
    estimatedTime = 'Menghitung...';
    estimatedDistance = 'Menghitung...';

    setPolylines(
      gmaps.LatLng(UserDataDatabase.lat, UserDataDatabase.lng),
      targetLatLng,
    );

    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
