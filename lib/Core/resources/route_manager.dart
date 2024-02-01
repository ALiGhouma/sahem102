import 'package:flutter/material.dart';
import 'package:sahem/Core/resources/app_strings.dart';
import 'package:sahem/Features/auth/presentation/sigin_in_view.dart';
import 'package:sahem/Features/home/componants/bottomnav.dart';
import 'package:sahem/Features/home/presentation/home_screen.dart';

class Routes {
  static const String login = "";
  static const String siginup = "";
  static const String home = "/";
}

class RouteGenerator {
  Route<dynamic> getAppRoutes(RouteSettings settings) {
    switch (settings.name) {

        case Routes.home:
        return MaterialPageRoute(builder: (_) => const BottomNav());
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
