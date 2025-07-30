import 'package:base/beranda/view/beranda_view.dart';
import 'package:base/models/list_restaurant_model.dart';
import 'package:base/service/api_service_base.dart';
import 'package:base/notifier/favorite_notifier.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class BerandaController extends State<BerandaView> {
  static late BerandaController instance;
  late BerandaView view;

  ApiServiceBase api = ApiServiceBase();
  dynamic dataFuture;

  // Search functionality
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  List<Restaurants?>? allRestaurants;
  List<Restaurants?>? filteredRestaurants;
  List<Restaurants?>? featuredRestaurants; // Store featured restaurants once
  bool isSearchFocused = false;

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

  // Skeleton loading for featured restaurants carousel
  Widget buildFeaturedRestaurantsSkeleton() {
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        itemBuilder: (context, index) {
          return Container(
            height: 150.0,
            width: MediaQuery.of(context).size.width * 0.7,
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: Stack(
              children: [
                // Main skeleton container
                Container(
                  height: 150.0,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey[300]!,
                        Colors.grey[200]!,
                        Colors.grey[300]!,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                // Bottom overlay skeleton
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            height: 12,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 12,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Skeleton loading for restaurant list
  Widget buildRestaurantListSkeleton() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(
              color: Colors.grey[300]!,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image skeleton
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title skeleton
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    // City skeleton
                    Container(
                      height: 12,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    // Description skeleton
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      height: 12,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        // Rating skeleton
                        Container(
                          height: 20,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        const Spacer(),
                        // Arrow skeleton
                        Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
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

    // Sort so that 'Bandung' is always at the top if present, then by count
    var sortedCities = cityCount.entries.toList()
      ..sort((a, b) {
        if (a.key.toLowerCase() == 'bandung') return -1;
        if (b.key.toLowerCase() == 'bandung') return 1;
        return b.value.compareTo(a.value);
      });

    return sortedCities.take(5).map((e) => e.key).toList();
  }

  goToDetailRestaurant(String id) {
    newRouter.push(
      RouterUtils.detail,
      extra: id,
    );
  }

  // Favorite functionality
  Future<void> toggleFavorite(Restaurants restaurant) async {
    try {
      final favoriteNotifier = FavoriteNotifier();
      await favoriteNotifier.toggleFavorite(restaurant);
      // No need for setState as ListenableBuilder will handle UI updates
    } catch (e) {
      // Show error message to user
      if (mounted) {
        showInfoDialog('Error updating favorites: $e');
      }
    }
  }

  bool isFavorite(String restaurantId) {
    return FavoriteNotifier().isFavorite(restaurantId);
  }

  getLatLongUser() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Layanan lokasi tidak aktif, bisa tampilkan pesan ke user
      return null;
    }

    // Cek dan minta izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Izin ditolak
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Izin ditolak permanen
      return null;
    }

    // Ambil posisi saat ini
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    UserDataDatabase.save(position.latitude, position.longitude);
  }

  @override
  void initState() {
    instance = this;
    getLatLongUser();
    dataFuture = getListRestaurant();

    searchController.addListener(() {
      searchRestaurants(searchController.text);
    });

    // Listen to search focus changes
    searchFocusNode.addListener(() {
      if (isSearchFocused != searchFocusNode.hasFocus) {
        isSearchFocused = searchFocusNode.hasFocus;
        setState(() {});
      }
    });

    super.initState();
    // Initialize favorite notifier
    _initializeFavorites();
  }

  Future<void> _initializeFavorites() async {
    try {
      await FavoriteNotifier().initialize();
    } catch (e) {
      print('Error initializing favorites: $e');
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
