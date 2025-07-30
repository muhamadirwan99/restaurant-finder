import 'package:base/beranda/controller/beranda_controller.dart';
import 'package:base/models/list_restaurant_model.dart';
import 'package:base/notifier/favorite_notifier.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  Widget build(BuildContext context, BerandaController controller) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Restaurant Finder",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Featured restaurants carousel
              FutureBuilder(
                future: controller.dataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return controller.buildFeaturedRestaurantsSkeleton();
                  } else if (snapshot.hasError) {
                    return Container(
                      height: 150.0,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: const Center(child: Text('Error loading featured restaurants')),
                    );
                  } else if (!snapshot.hasData || controller.allRestaurants == null) {
                    return Container(
                      height: 150.0,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: const Center(child: Text('No featured restaurants')),
                    );
                  }

                  List<Restaurants?> featuredRestaurants = controller.featuredRestaurants ?? [];

                  if (featuredRestaurants.isEmpty) {
                    return Container(
                      height: 150.0,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: const Center(child: Text('No featured restaurants available')),
                    );
                  }

                  return SizedBox(
                    height: 150.0,
                    child: ListView.builder(
                      itemCount: featuredRestaurants.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      itemBuilder: (context, index) {
                        var restaurant = featuredRestaurants[index];
                        return GestureDetector(
                          onTap: () {
                            controller.goToDetailRestaurant(StringUtils.trimString(restaurant?.id));
                          },
                          child: Container(
                            height: 150.0,
                            width: MediaQuery.of(context).size.width * 0.7,
                            margin: const EdgeInsets.only(right: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    IpDatabase.host +
                                        Endpoints.mediumImage +
                                        StringUtils.trimString(restaurant?.pictureId),
                                    height: 150.0,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 150.0,
                                        width: MediaQuery.of(context).size.width * 0.7,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.restaurant,
                                                color: Colors.grey,
                                                size: 40,
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'Image not available',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  // Gradient overlay for better text readability
                                  Container(
                                    height: 150.0,
                                    width: MediaQuery.of(context).size.width * 0.7,
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
                                  // Restaurant info overlay
                                  Positioned(
                                    bottom: 12,
                                    left: 12,
                                    right: 12,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          restaurant?.name ?? 'Unknown Restaurant',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.white70,
                                              size: 12,
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                restaurant?.city ?? 'Unknown City',
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 6,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.amber.withOpacity(0.9),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                    size: 10,
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    restaurant?.rating?.toString() ?? '0.0',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Clickable indicator and favorite button
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Favorite button
                                        GestureDetector(
                                          onTap: () async {
                                            if (restaurant != null) {
                                              controller.toggleFavorite(restaurant);
                                            }
                                          },
                                          child: ListenableBuilder(
                                            listenable: FavoriteNotifier(),
                                            builder: (context, child) {
                                              final isFavorite = FavoriteNotifier()
                                                  .isFavorite(restaurant?.id ?? '');
                                              return AnimatedContainer(
                                                duration: const Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: isFavorite
                                                      ? Colors.red.withOpacity(0.15)
                                                      : Colors.black.withOpacity(0.3),
                                                  shape: BoxShape.circle,
                                                  boxShadow: isFavorite
                                                      ? [
                                                          BoxShadow(
                                                            color: Colors.red.withOpacity(0.3),
                                                            blurRadius: 8,
                                                            spreadRadius: 2,
                                                          ),
                                                        ]
                                                      : [],
                                                ),
                                                child: AnimatedSwitcher(
                                                  duration: const Duration(milliseconds: 300),
                                                  transitionBuilder:
                                                      (Widget child, Animation<double> animation) {
                                                    return ScaleTransition(
                                                      scale: animation,
                                                      child: child,
                                                    );
                                                  },
                                                  child: Icon(
                                                    isFavorite
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    key: ValueKey(isFavorite),
                                                    color: isFavorite ? Colors.red : Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),

                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.black26,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.touch_app,
                                            color: Colors.white70,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24.0,
                    ),
                    StatefulBuilder(builder: (context, setSearchState) {
                      return BaseForm(
                        textEditingController: controller.searchController,
                        focusNode: controller.searchFocusNode,
                        hintText: "Search Restaurant by name or city...",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: controller.searchController.text.isNotEmpty
                            ? const Icon(Icons.clear)
                            : null,
                        onTapSuffix: controller.searchController.text.isNotEmpty
                            ? () {
                                controller.clearSearch();
                                setSearchState(() {});
                              }
                            : null,
                        onChanged: (value) {
                          setSearchState(() {});
                        },
                      );
                    }),
                    const SizedBox(height: 12.0),
                    // Popular cities chips - only show when search is focused and empty
                    if (controller.allRestaurants != null &&
                        controller.isSearchFocused &&
                        controller.searchController.text.isEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Popular Cities:',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: 8.0),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: controller.getPopularCities().map((city) {
                              return ActionChip(
                                label: Text(
                                  city,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                onPressed: () {
                                  controller.searchByCity(city);
                                },
                                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 12.0),
                        ],
                      ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      'Explore Restaurant',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            controller.searchController.text.isNotEmpty
                                ? 'Search results for "${controller.searchController.text}"'
                                : 'Check your city Near by Restaurant',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        if (controller.searchController.text.isNotEmpty &&
                            controller.filteredRestaurants != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${controller.filteredRestaurants!.length} found',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder(
                      future: controller.dataFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return controller.buildRestaurantListSkeleton();
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(child: Text('No data available'));
                        }
                        ListRestaurantModel? data = snapshot.data as ListRestaurantModel?;
                        List<Restaurants?>? listRestaurants =
                            controller.filteredRestaurants ?? data?.restaurants;
                        if (listRestaurants == null || listRestaurants.isEmpty) {
                          // Check if it's empty due to search or no data
                          if (controller.searchController.text.isNotEmpty &&
                              (controller.allRestaurants?.isNotEmpty ?? false)) {
                            return const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.search_off, size: 48, color: Colors.grey),
                                  SizedBox(height: 16),
                                  Text('No restaurants found matching your search'),
                                ],
                              ),
                            );
                          }
                          return const Center(child: Text('No restaurants found'));
                        }

                        // Sort: all Bandung city restaurants at the top
                        final bandungList = <Restaurants?>[];
                        final otherList = <Restaurants?>[];
                        for (final r in listRestaurants) {
                          if ((r?.city ?? '').toLowerCase() == 'bandung') {
                            bandungList.add(r);
                          } else {
                            otherList.add(r);
                          }
                        }
                        final sortedList = [...bandungList, ...otherList];

                        return ListView.builder(
                          itemCount: sortedList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            var restaurant = sortedList[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    12.0,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                onTap: () {
                                  controller
                                      .goToDetailRestaurant(StringUtils.trimString(restaurant?.id));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Image.network(
                                          IpDatabase.host +
                                              Endpoints.smallImage +
                                              StringUtils.trimString(restaurant?.pictureId),
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Container(
                                              color: Colors.grey[200],
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                          (loadingProgress.expectedTotalBytes ?? 1)
                                                      : null,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[200],
                                              child: const Icon(
                                                Icons.image_not_supported,
                                                color: Colors.grey,
                                                size: 24,
                                              ),
                                            );
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            restaurant?.name ?? 'Unknown Restaurant',
                                            style:
                                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4.0),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 14,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Expanded(
                                                child: Text(
                                                  restaurant?.city ?? 'Unknown City',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color:
                                                            Theme.of(context).colorScheme.primary,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6.0),
                                          Text(
                                            restaurant?.description ?? 'No description available',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: Colors.grey[600],
                                                ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 4.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primaryContainer,
                                                  borderRadius: BorderRadius.circular(12.0),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: 14,
                                                      color: Colors.amber[600],
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    Text(
                                                      restaurant?.rating?.toString() ?? '0.0',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            fontWeight: FontWeight.w600,
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .onPrimaryContainer,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              // Favorite button
                                              GestureDetector(
                                                onTap: () {
                                                  if (restaurant != null) {
                                                    controller.toggleFavorite(restaurant);
                                                  }
                                                },
                                                child: ListenableBuilder(
                                                  listenable: FavoriteNotifier(),
                                                  builder: (context, child) {
                                                    final isFavorite = FavoriteNotifier()
                                                        .isFavorite(restaurant?.id ?? '');
                                                    return AnimatedContainer(
                                                      duration: const Duration(milliseconds: 300),
                                                      padding: const EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                        color: isFavorite
                                                            ? Colors.red.withOpacity(0.1)
                                                            : Colors.grey.withOpacity(0.1),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        isFavorite
                                                            ? Icons.favorite
                                                            : Icons.favorite_border,
                                                        color: isFavorite
                                                            ? Colors.red
                                                            : Colors.grey[600],
                                                        size: 18,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 16,
                                                color: Colors.grey[400],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<BerandaView> createState() => BerandaController();
}
