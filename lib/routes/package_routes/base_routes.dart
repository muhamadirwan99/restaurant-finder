import 'package:base/base.dart';
import 'package:base/models/detail_restaurant_model.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

final List<GoRoute> baseRoutes = [
  GoRoute(
    path: RouterUtils.root,
    builder: (BuildContext context, GoRouterState state) {
      return const SplashScreenView();
    },
  ),
  GoRoute(
    path: RouterUtils.beranda,
    builder: (BuildContext context, GoRouterState state) {
      return const MainLayoutView(initialIndex: 0);
    },
  ),
  GoRoute(
    path: RouterUtils.mainLayout,
    builder: (BuildContext context, GoRouterState state) {
      // Get the tab index from query parameter, default to 0
      final String? tab = state.uri.queryParameters['tab'];
      final int initialIndex = int.tryParse(tab ?? '0') ?? 0;
      return MainLayoutView(initialIndex: initialIndex);
    },
  ),
  GoRoute(
    path: RouterUtils.detail,
    builder: (BuildContext context, GoRouterState state) {
      final String? id = state.extra as String?;

      return DetailView(id: StringUtils.trimString(id));
    },
  ),
  GoRoute(
    path: RouterUtils.direction,
    builder: (BuildContext context, GoRouterState state) {
      final List<dynamic> extraData = state.extra as List<dynamic>;

      double lat = extraData[0] ?? 0.0;
      double lng = extraData[1] ?? 0.0;
      Restaurant? restaurant = extraData[2] as Restaurant?;

      return DirectionView(
        lat: lat,
        lng: lng,
        restaurant: restaurant,
      );
    },
  ),
];
