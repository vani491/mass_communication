import 'package:flutter/material.dart';
import 'package:mass_communication/features/auth/presentation/pages/registration_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/splash_page.dart';


class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/registration':
        return MaterialPageRoute(builder: (_) => RegistrationPage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen()); // Default Route
    }
  }
}
