import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/route_manager.dart';
import 'package:sahem/Core/utils/constants.dart';
import 'package:sahem/Core/utils/locale_manager.dart';
import 'package:sahem/Features/auth/data/user_model.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_cubit.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_state.dart';
import 'package:sahem/Features/auth/presentation/view/sigin_in_view.dart';
import 'package:sahem/Features/home/componants/bottomnav.dart';
import 'package:sahem/Features/home/presentation/home_view.dart';
import 'package:sahem/Features/nav_bar/view/BottomNav.dart';

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
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: LocaleManager.localizationsDelegates,
              supportedLocales: LocaleManager.supportedLocales,
              locale: LocaleManager.supportedLocales.first,
              onGenerateRoute: _routeGenerator.getAppRoutes,
              home: BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) {
                  return previous is AuthInitianState;
                },
                builder: (context, state) {
                  return CustomBottomNav(
                      userModel: UserModel(
                    id: "id",
                    phoneNumber: "phoneNumber",
                    username: "username",
                  ));
                  HomeView(
                      userModel: UserModel(
                    id: "id",
                    phoneNumber: "phoneNumber",
                    username: "username",
                  ));
                  // if (state is AuthLoggedInState) {
                  //   return HomeView(userModel: state.userModel);
                  // } else if (state is AuthLoggedOutState) {
                  //   return const SiginInView();
                  // } else {
                  //   return const SiginInView();
                  // }
                },
              ),
            ),
          );
        });
  }
}
