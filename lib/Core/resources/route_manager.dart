import 'package:flutter/material.dart';
import 'package:sahem/Core/resources/app_strings.dart';
import 'package:sahem/Features/auth/presentation/view/sigin_in_view.dart';

class Routes {
  static const String login = "/";
  static const String siginup = "/siginup";
}

class RouteGenerator {
  Route<dynamic> getAppRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const SiginInView());
      case Routes.siginup:
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
