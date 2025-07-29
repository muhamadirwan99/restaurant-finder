import 'package:base/base.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

final List<GoRoute> authRoutes = [
  GoRoute(
    path: RouterUtils.login,
    builder: (BuildContext context, GoRouterState state) {
      return const LoginView();
    },
  ),
  GoRoute(
    path: RouterUtils.register,
    builder: (BuildContext context, GoRouterState state) {
      return const RegisterView();
    },
  ),
];
