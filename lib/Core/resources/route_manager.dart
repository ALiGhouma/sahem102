import 'package:flutter/material.dart';
import 'package:sahem/Core/resources/app_strings.dart';

class Routes {
  static const String logIn = "/logIn";
  static const String sigInUP = "/sigInUP";
}

class RouteGenerator {
  Route<dynamic> getAppRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.logIn:
        return MaterialPageRoute(builder: (_) => const Center());
      case Routes.sigInUP:
        return MaterialPageRoute(builder: (_) => const Center());
      default:
        return _undefinedRoute();
    }
  }

  _undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(child: Text(AppStrings.noRoutFound)),
            ));
  }
}
