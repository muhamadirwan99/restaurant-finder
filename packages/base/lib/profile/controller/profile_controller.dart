import 'package:base/layout/controller/main_layout_controller.dart';
import 'package:base/profile/view/profile_view.dart';
import 'package:flutter/material.dart';

class ProfileController extends State<ProfileView> {
  static late ProfileController instance;
  late ProfileView view;

  void navigateToFavorites() {
    // Navigate to favorites tab in main layout
    MainLayoutController.instance.onTap(1);
  }

  void showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pengaturan'),
        content: const Text('Fitur pengaturan akan segera tersedia.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tentang Aplikasi'),
        content: const Text(
          'Restaurant Finder v1.0\n\n'
          'Aplikasi untuk mencari dan menyimpan restaurant favorit Anda.\n\n'
          'Developed with Flutter',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Implement logout logic here
              // Logout.logout();
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
