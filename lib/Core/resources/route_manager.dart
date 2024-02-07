import 'package:flutter/material.dart';
import 'package:sahem/Core/resources/app_strings.dart';
import 'package:sahem/Features/auth/data/user_model.dart';
import 'package:sahem/Features/home/componants/bottomnav.dart';
import 'package:sahem/Features/home/presentation/home_screen.dart';
import 'package:sahem/Features/nav_bar/view/BottomNav.dart';

class Routes {
  static const String login = "";
  static const String siginup = "";
  static const String home = "/";
}

class RouteGenerator {
  Route<dynamic> getAppRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
            builder: (_) => CustomBottomNav(
                  userModel: UserModel(
                      id: "id",
                      phoneNumber: "phoneNumber",
                      username: "username"),
                ));
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
