import 'package:base/beranda/view/beranda_view.dart';
import 'package:flutter/material.dart';

class BerandaController extends State<BerandaView> {
  static late BerandaController instance;
  late BerandaView view;

  List items = [
    {
      "id": 1,
      "photo":
          "https://plus.unsplash.com/premium_photo-1674106347866-8282d8c19f84?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "title": "Sunset Grill & Bar",
    },
    {
      "id": 2,
      "photo":
          "https://images.unsplash.com/photo-1651440204296-a79fa9988007?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "title": "Urban Bites Cafe",
    },
    {
      "id": 3,
      "photo":
          "https://images.unsplash.com/photo-1543992321-cefacfc2322e?q=80&w=1450&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "title": "Green Leaf Restaurant",
    }
  ];

  @override
  void initState() {
    instance = this;

    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
