import 'package:base/layout/controller/main_layout_controller.dart';
import 'package:flutter/material.dart';

class MainLayoutView extends StatefulWidget {
  final int initialIndex;

  const MainLayoutView({
    super.key,
    this.initialIndex = 0,
  });

  Widget build(BuildContext context, MainLayoutController controller) {
    return Scaffold(
      body: IndexedStack(
        index: controller.currentIndex,
        children: controller.pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex,
        onTap: controller.onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  @override
  State<MainLayoutView> createState() => MainLayoutController();
}
