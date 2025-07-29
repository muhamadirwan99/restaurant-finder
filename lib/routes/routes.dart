import 'package:core/core.dart';
import 'package:restaurant_finder/routes/package_routes/auth_routes.dart';
import 'package:restaurant_finder/routes/package_routes/base_routes.dart';
import 'package:restaurant_finder/routes/route_configs.dart';

final GoRouter router = GoRouter(
  navigatorKey: Get.navigatorKey,
  initialLocation: RouterUtils.root,
  errorBuilder: RouteConfigs.errorBuilder,
  routes: <RouteBase>[
    ...baseRoutes,
    ...authRoutes,
  ],
);
