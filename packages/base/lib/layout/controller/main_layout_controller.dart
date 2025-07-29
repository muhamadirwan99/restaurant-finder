import 'package:base/beranda/view/beranda_view.dart';
import 'package:base/favorit/view/favorit_view.dart';
import 'package:base/layout/view/main_layout_view.dart';
import 'package:base/profile/view/profile_view.dart';
import 'package:flutter/material.dart';

class MainLayoutController extends State<MainLayoutView> {
  static late MainLayoutController instance;
  late MainLayoutView view;

  int currentIndex = 0;

  List<Widget> pages = [
    const BerandaView(),
    const FavoritView(),
    const ProfileView(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    instance = this;
    currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
