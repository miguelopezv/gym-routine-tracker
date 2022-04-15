import 'package:flutter/material.dart';
import 'package:gym_routine/pages/pages.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case 'login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case 'loading':
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
      case 'error':
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
