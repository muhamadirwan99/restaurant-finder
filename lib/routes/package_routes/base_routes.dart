import 'package:base/base.dart';
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
];
