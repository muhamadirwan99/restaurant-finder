import 'package:base/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  Widget build(BuildContext context, ProfileController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Profile Picture
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // User Name
            const Text(
              'Restaurant Finder User',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'user@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            // Menu Items
            _buildMenuItem(
              icon: Icons.favorite,
              title: 'Daftar Favorit',
              onTap: () {
                // Navigate to favorites tab
                controller.navigateToFavorites();
              },
            ),
            _buildMenuItem(
              icon: Icons.settings,
              title: 'Pengaturan',
              onTap: () {
                controller.showSettingsDialog();
              },
            ),
            _buildMenuItem(
              icon: Icons.info,
              title: 'Tentang Aplikasi',
              onTap: () {
                controller.showAboutDialog();
              },
            ),
            _buildMenuItem(
              icon: Icons.logout,
              title: 'Keluar',
              onTap: () {
                controller.logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  @override
  State<ProfileView> createState() => ProfileController();
}
