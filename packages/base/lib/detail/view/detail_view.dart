import 'package:base/models/detail_restaurant_model.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart' as fd;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import '../controller/detail_controller.dart';

class DetailView extends StatefulWidget {
  final String id;

  const DetailView({
    super.key,
    required this.id,
  });

  Widget build(context, DetailController controller) {
    controller.view = this;

    return Scaffold(
      body: controller.isLoading
          ? _buildLoadingSkeleton()
          : controller.errorMessage != null
              ? _buildErrorState(context, controller)
              : _buildDetailContent(context, controller),
      floatingActionButton: !controller.isLoading && controller.errorMessage == null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Direction button - always visible when not loading and no error
                FloatingActionButton.extended(
                  onPressed: () => _navigateToDirection(context, controller),
                  icon: const Icon(Icons.directions),
                  label: const Text('Get Directions'),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  heroTag: "direction_fab",
                ),
                const SizedBox(height: 16),
                // Review button - only visible when user is logged in
                if (FirebaseAuth.instance.currentUser != null)
                  FloatingActionButton.extended(
                    onPressed: () => _showAddReviewDialog(context, controller),
                    icon: const Icon(Icons.add_comment),
                    label: const Text('Add Review'),
                    backgroundColor: Theme.of(context).primaryColor,
                    heroTag: "review_fab",
                  ),
              ],
            )
          : null,
    );
  }

  Widget _buildLoadingSkeleton() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          backgroundColor: Colors.grey[300],
          flexibleSpace: Container(
            color: Colors.grey[300],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 24, color: Colors.grey[300]),
                const SizedBox(height: 8),
                Container(height: 16, width: 200, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Container(height: 100, color: Colors.grey[300]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, DetailController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Failed to load restaurant details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              controller.errorMessage ?? 'Unknown error',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.getDetailRestaurant,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailContent(BuildContext context, DetailController controller) {
    final restaurant = controller.detailData?.restaurant;
    if (restaurant == null) {
      return const Scaffold(
        body: Center(child: Text('No restaurant data available')),
      );
    }

    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(context, restaurant),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRestaurantInfo(context, restaurant),
              _buildMaps(context, controller, restaurant),
              _buildDescription(context, restaurant),
              _buildCategories(context, restaurant),
              _buildMenuSection(context, restaurant),
              _buildReviewsSection(context, restaurant),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar(BuildContext context, Restaurant restaurant) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          restaurant.name ?? 'Unknown Restaurant',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 3,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              IpDatabase.host + Endpoints.largeImage + StringUtils.trimString(restaurant.pictureId),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.restaurant, size: 64, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('Image not available', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantInfo(BuildContext context, Restaurant restaurant) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name ?? 'Unknown Restaurant',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.city ?? 'Unknown City',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.rating?.toStringAsFixed(1) ?? '0.0',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.place,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  restaurant.address ?? 'Address not available',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMaps(BuildContext context, DetailController controller, Restaurant restaurant) {
    gmaps.LatLng position = gmaps.LatLng(controller.latitude, controller.longitude);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 200,
              child: gmaps.GoogleMap(
                initialCameraPosition: gmaps.CameraPosition(target: position, zoom: 14),
                markers: {
                  gmaps.Marker(markerId: gmaps.MarkerId(restaurant.id ?? '0'), position: position)
                },
                gestureRecognizers: <fd.Factory<OneSequenceGestureRecognizer>>{
                  fd.Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
                mapType: gmaps.MapType.normal,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context, Restaurant restaurant) {
    final description = restaurant.description ?? 'No description available';
    const int maxLines = 3;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          StatefulBuilder(
            builder: (context, setState) {
              // Get controller instance
              final controller = context.findAncestorStateOfType<DetailController>();
              final isExpanded = controller?.isDescriptionExpanded ?? false;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.6,
                          ),
                      children: [
                        TextSpan(
                          text: isExpanded
                              ? description
                              : _getTruncatedText(context, description, maxLines),
                        ),
                        if (!isExpanded && _shouldShowSeeMore(context, description, maxLines))
                          TextSpan(
                            text: '... ',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  height: 1.6,
                                ),
                          ),
                        if (_shouldShowSeeMore(context, description, maxLines))
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                controller?.toggleDescriptionExpansion();
                                setState(() {});
                              },
                              child: Text(
                                isExpanded ? ' See Less' : 'See More',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                      height: 1.6,
                                    ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _getTruncatedText(BuildContext context, String text, int maxLines) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
      ),
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 32);

    if (textPainter.didExceedMaxLines) {
      final endIndex = textPainter
          .getPositionForOffset(
            Offset(textPainter.size.width, textPainter.size.height),
          )
          .offset;

      // Find the last complete word before the cutoff
      String truncated = text.substring(0, endIndex);
      int lastSpace = truncated.lastIndexOf(' ');
      if (lastSpace > 0) {
        truncated = truncated.substring(0, lastSpace);
      }

      return truncated;
    }

    return text;
  }

  bool _shouldShowSeeMore(BuildContext context, String text, int maxLines) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
      ),
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 32);
    return textPainter.didExceedMaxLines;
  }

  Widget _buildCategories(BuildContext context, Restaurant restaurant) {
    if (restaurant.categories == null || restaurant.categories!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: restaurant.categories!.map((category) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  category.name ?? 'Unknown',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, Restaurant restaurant) {
    if (restaurant.menus == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Menu',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),

          // Foods Section
          if (restaurant.menus!.foods != null && restaurant.menus!.foods!.isNotEmpty) ...[
            _buildMenuCategory(context, 'Foods', restaurant.menus!.foods!, Icons.restaurant),
            const SizedBox(height: 16),
          ],

          // Drinks Section
          if (restaurant.menus!.drinks != null && restaurant.menus!.drinks!.isNotEmpty) ...[
            _buildMenuCategory(context, 'Drinks', restaurant.menus!.drinks!, Icons.local_drink),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuCategory(
      BuildContext context, String title, List<Category> items, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  item.name ?? 'Unknown',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection(BuildContext context, Restaurant restaurant) {
    if (restaurant.customerReviews == null || restaurant.customerReviews!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Customer Reviews',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${restaurant.customerReviews!.length}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: restaurant.customerReviews!.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final review = restaurant.customerReviews![index];
              return _buildReviewCard(context, review);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, CustomerReview review) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  (review.name?.isNotEmpty == true)
                      ? review.name!.substring(0, 1).toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name ?? 'Anonymous',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      review.date ?? 'Unknown date',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.review ?? 'No review content',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }

  void _showAddReviewDialog(BuildContext context, DetailController controller) {
    final TextEditingController reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Share your experience about this restaurant:',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: reviewController,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your review here...',
                  labelText: 'Review',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (reviewController.text.trim().isNotEmpty) {
                  Get.back();
                  await controller.submitReviewRestaurant(
                    review: reviewController.text.trim(),
                  );
                } else {
                  showInfoDialog(
                    "Please write a review before submitting",
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToDirection(BuildContext context, DetailController controller) {
    // Navigate to direction page with coordinates as list [lat, lng]
    final coordinates = [
      controller.latitude,
      controller.longitude,
      controller.detailData?.restaurant
    ];

    newRouter.push(
      RouterUtils.direction,
      extra: coordinates,
    );
  }

  @override
  State<DetailView> createState() => DetailController();
}
