import 'package:flutter/material.dart';
import 'package:mass_communication/features/auth/presentation/pages/login_page.dart';
import 'package:mass_communication/features/auth/presentation/pages/registration_page.dart';
import 'package:mass_communication/features/auth/presentation/widgets/login_form.dart';
import 'package:mass_communication/navigation/organiser_bottom_navigation.dart';
import '../features/auth/presentation/pages/splash_page.dart';
import 'bottom_navigation.dart';


class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/registration':
        return MaterialPageRoute(builder: (_) => const RegistrationPage());
      case '/attendeeHome':
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      case '/organizerHome':
        return MaterialPageRoute(builder: (_) => const OrganiserBottomNavigation());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen()); // Default Route
    }
  }
}
