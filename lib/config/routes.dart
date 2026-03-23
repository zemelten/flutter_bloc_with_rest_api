import 'package:flutter/material.dart';

import '../features/authentication/presentation/pages/home_page.dart';
import '../features/authentication/presentation/pages/login_page.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case login:
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
