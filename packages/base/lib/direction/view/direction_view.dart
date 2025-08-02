import 'package:base/models/detail_restaurant_model.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import '../controller/direction_controller.dart';

class DirectionView extends StatefulWidget {
  final double lat, lng;
  final Restaurant? restaurant;

  const DirectionView({
    super.key,
    required this.lat,
    required this.lng,
    required this.restaurant,
  });

  Widget build(context, DirectionController controller) {
    controller.view = this;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color getCardColor() => isDark ? Colors.grey[900]! : Colors.white;
    Color getShadowColor() =>
        isDark ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.15);
    Color getPrimaryTextColor() => isDark ? Colors.white : Colors.black87;
    Color getSecondaryTextColor() => isDark ? Colors.white70 : Colors.grey[700]!;
    Color getAppBarGradientStart() =>
        isDark ? Colors.grey[900]!.withOpacity(0.98) : Colors.white.withOpacity(0.95);
    Color getAppBarGradientEnd() =>
        isDark ? Colors.grey[900]!.withOpacity(0.8) : Colors.white.withOpacity(0.8);

    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          gmaps.GoogleMap(
            initialCameraPosition: gmaps.CameraPosition(
              zoom: 18,
              target: gmaps.LatLng(UserDataDatabase.lat, UserDataDatabase.lng),
            ),
            polylines: controller.polylines,
            markers: controller.markers,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: (controllerMap) async {
              final userMarker = gmaps.Marker(
                markerId: const gmaps.MarkerId("source"),
                position: gmaps.LatLng(UserDataDatabase.lat, UserDataDatabase.lng),
                icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(
                  gmaps.BitmapDescriptor.hueBlue,
                ),
                infoWindow: const gmaps.InfoWindow(
                  title: "Lokasi Anda",
                  snippet: "Titik awal perjalanan",
                ),
              );
              final targetMarker = gmaps.Marker(
                markerId: const gmaps.MarkerId("destination"),
                position: controller.targetLatLng,
                icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(
                  gmaps.BitmapDescriptor.hueRed,
                ),
                infoWindow: gmaps.InfoWindow(
                  title: restaurant?.name ?? "Tujuan",
                  snippet: restaurant?.address ?? "Destinasi perjalanan",
                ),
              );

              controller.mapController = controllerMap;
              controller.markers.addAll([userMarker, targetMarker]);
              controller.update();
            },
          ),

          // Top App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    getAppBarGradientStart(),
                    getAppBarGradientEnd(),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: getCardColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back, color: getPrimaryTextColor()),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryColor.withOpacity(0.8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(isDark ? 0.08 : 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.restaurant,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant?.name ?? 'Restaurant',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      restaurant?.rating?.toStringAsFixed(1) ?? '0.0',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '• ${restaurant?.city ?? 'Unknown'}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Restaurant Information Card
          Positioned(
            bottom: 120,
            left: 16,
            right: 16,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: getCardColor(),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: getShadowColor(),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Restaurant Header

                  // Route Information
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.route,
                              color: primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Informasi Rute',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: getPrimaryTextColor(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoItem(
                                icon: Icons.access_time,
                                label: 'Estimasi Waktu',
                                value: controller.estimatedTime ?? 'Menghitung...',
                                color: Colors.orange,
                                isDark: isDark,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildInfoItem(
                                icon: Icons.straighten,
                                label: 'Jarak',
                                value: controller.estimatedDistance ?? 'Menghitung...',
                                color: Colors.green,
                                isDark: isDark,
                              ),
                            ),
                          ],
                        ),
                        if (restaurant?.address != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(isDark ? 0.18 : 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    restaurant!.address!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: getSecondaryTextColor(),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Action Buttons
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withOpacity(0.8)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(isDark ? 0.5 : 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.openGoogleMapsNavigation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow, color: Colors.white, size: 24),
                          SizedBox(width: 8),
                          Text(
                            'Buka Google Maps',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: getCardColor(),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: getShadowColor(),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      controller.centerMap();
                    },
                    icon: Icon(Icons.my_location, color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white70 : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  @override
  State<DirectionView> createState() => DirectionController();
}
