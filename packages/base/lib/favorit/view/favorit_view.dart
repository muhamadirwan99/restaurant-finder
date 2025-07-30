import 'package:base/favorit/controller/favorit_controller.dart';
import 'package:base/notifier/favorite_notifier.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class FavoritView extends StatefulWidget {
  const FavoritView({super.key});

  Widget build(BuildContext context, FavoritController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Favorit",
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListenableBuilder(
        listenable: FavoriteNotifier(),
        builder: (context, child) {
          final favorites = FavoriteNotifier().favorites;

          if (favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada restaurant favorit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                var restaurant = favorites[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        IpDatabase.host +
                            Endpoints.mediumImage +
                            StringUtils.trimString(restaurant.pictureId),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.restaurant,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    title: Text(
                      restaurant.name ?? 'Unknown Restaurant',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.city ?? 'Unknown City',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.rating ?? '0.0',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        try {
                          await FavoriteNotifier().removeFromFavorites(restaurant.id ?? '');
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Restaurant dihapus dari favorit!'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                    ),
                    onTap: () {
                      // Navigate to detail view
                      newRouter.push(
                        RouterUtils.detail,
                        extra: restaurant.id,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  State<FavoritView> createState() => FavoritController();
}
