import 'package:auto_route/annotations.dart';
import 'package:auto_route/src/route/route_config.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: ProductRoute.page, path: '/product'),
    AutoRoute(page: CartRoute.page, path: '/cart'),
    AutoRoute(page: RegisterRoute.page, path: '/register'),
  ];
}
