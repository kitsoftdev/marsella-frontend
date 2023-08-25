import 'package:flutter/material.dart';

import '../../presentation/nav/bloc/nav_state.dart';
import '../../presentation/router/pages/router_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name?.toLowerCase().contains('/p/') ?? false) {
      return MaterialPageRoute(
        builder: (context) => RouterPage(
            naveItem: NavItem.pageUsers,
            args: <String, dynamic>{
              'id': settings.name?.replaceFirst('/p/', '')
            }),
      );
    }
    switch (settings.name?.toLowerCase()) {
      case '/user':
        return MaterialPageRoute(
          builder: (context) => const RouterPage(naveItem: NavItem.pageUsers),
        );
      default:
        return null;
    }
  }
}
