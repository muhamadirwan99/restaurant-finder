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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: controller.onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey[600],
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
            items: [
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(controller.currentIndex == 0 ? 8 : 6),
                  decoration: controller.currentIndex == 0
                      ? BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        )
                      : null,
                  child: Icon(
                    controller.currentIndex == 0 ? Icons.home : Icons.home_outlined,
                    size: controller.currentIndex == 0 ? 26 : 24,
                  ),
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(controller.currentIndex == 1 ? 8 : 6),
                  decoration: controller.currentIndex == 1
                      ? BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        )
                      : null,
                  child: Icon(
                    controller.currentIndex == 1 ? Icons.favorite : Icons.favorite_outline,
                    size: controller.currentIndex == 1 ? 26 : 24,
                  ),
                ),
                label: 'Favorit',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(controller.currentIndex == 2 ? 8 : 6),
                  decoration: controller.currentIndex == 2
                      ? BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        )
                      : null,
                  child: Icon(
                    controller.currentIndex == 2 ? Icons.person : Icons.person_outline,
                    size: controller.currentIndex == 2 ? 26 : 24,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<MainLayoutView> createState() => MainLayoutController();
}
