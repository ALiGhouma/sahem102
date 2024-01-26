import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/route_manager.dart';
import 'package:sahem/Core/utils/constants.dart';
import 'package:sahem/Core/utils/locale_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RouteGenerator _routeGenerator = RouteGenerator();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            localizationsDelegates: LocaleManager.localizationsDelegates,
            supportedLocales: LocaleManager.supportedLocales,
            locale: LocaleManager.supportedLocales.first,
            onGenerateRoute: _routeGenerator.getAppRoutes,
          );
        });
  }
}
