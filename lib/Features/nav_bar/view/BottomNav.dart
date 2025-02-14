import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/utils/constants.dart';
import 'package:sahem/Features/auth/data/user_model.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_cubit.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_state.dart';
import 'package:sahem/Features/auth/presentation/view/sigin_in_view.dart';
import 'package:sahem/Features/emergencyContact/emergency_contact.dart';
import 'package:sahem/Features/home/presentation/home_view.dart';
import 'package:sahem/Features/my_profile/myprofile.dart';
import 'package:sahem/Features/myreport/my_reports.dart';
import 'package:sahem/Features/nav_bar/manger/cubit/nav_cubit.dart';

class CustomBottomNav extends StatelessWidget {
  final UserModel userModel;

  final NavigationCubit _navigationCubit = NavigationCubit();
  final AuthCubit _authCubit = AuthCubit();

  CustomBottomNav({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    List<String> viewTitle = [
      "جهات الطواريئ"
          "الرئيسية"
          "سجل البلاغات"
    ];
    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,

      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return BlocProvider.value(
          value: _navigationCubit,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _navigationCubit),
              BlocProvider.value(value: _authCubit),
            ],
            child: BlocBuilder<NavigationCubit, int>(
              builder: (context, state) {
                return Scaffold(
                  body: _buildPage(state, context),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: state,

                    onTap: (index) {
                      _navigationCubit.navigateToPage(
                          _navigationCubit.mapIndexToEvent(index));
                    },
                    selectedItemColor: ColorManager.primary,
                    unselectedItemColor: ColorManager.primary.withOpacity(0.3),
                    //unselectedItemColor: Color,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.emergency,
                        ),
                        label: 'جهات الطوارئ',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home,
                          ),
                          label: 'الرئيسية',
                          backgroundColor: ColorManager.white),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.sticky_note_2_outlined,
                        ),
                        label: 'البلاغات',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person_outline,
                        ),
                        label: 'نقاطي',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildPage(int currentIndex, BuildContext context) {
    switch (currentIndex) {
      case 0:
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            // Retrieve the user's data from AuthCubit
            //final userModel = (state as AuthLoggedInState).userModel;
            return EmergencyContact();
          },
        );
      case 1:
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            // Retrieve the user's data from AuthCubit
            //final userModel = (state as AuthLoggedInState).userModel;
            return HomeView(
              userModel: userModel,
            );
          },
        );
      case 2:
        return UserReportsPage();
      case 3:
        return Myprofile();
      // case 4:
      //   return Scaffold(
      //     body: Center(
      //       child: Text("Empty page"),
      //     ),
      //   );
      default:
        return Container();
    }
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تأكيد الخروج"),
          content: Text("هل أنت متأكد أنك تريد تسجيل الخروج؟"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("لا"),
            ),
            TextButton(
              onPressed: () {
                _logout(context);
              },
              child: Text("نعم"),
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    // Delete username from SharedPreferences
    _authCubit.saveUsername('');
    // Postpone any process that requires the username
    // Here you can add any additional cleanup tasks before logging out
    // For example, you might want to clear the current user session, etc.
    // Then navigate to the home page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SiginInView()),
      (route) => false,
    );
  }
}







// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sahem/Core/resources/color_manager.dart';
// import 'package:sahem/Core/utils/constants.dart';
// import 'package:sahem/Features/add_report/presentation/view/add_report_view.dart';
// import 'package:sahem/Features/auth/data/user_model.dart';
// import 'package:sahem/Features/auth/manger/cubit/auth_cubit.dart';
// import 'package:sahem/Features/auth/manger/cubit/auth_state.dart';
// import 'package:sahem/Features/emergencyContact/emergency_contact.dart';
// import 'package:sahem/Features/home/presentation/home_view.dart';
// import 'package:sahem/Features/my_profile/myprofile.dart';
// import 'package:sahem/Features/myreport/my_reports.dart';
// import 'package:sahem/Features/nav_bar/manger/cubit/nav_cubit.dart';

// class CustomBottomNav extends StatelessWidget {
//   final UserModel userModel;
//   List<String> viewTitle = [
//     "جهات الطواريئ"
//         "الرئيسية"
//         "سجل البلاغات"
//   ];
//   final NavigationCubit _navigationCubit = NavigationCubit();
//   final AuthCubit _authCubit = AuthCubit();

//   CustomBottomNav({super.key, required this.userModel});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         designSize: designSize,
//         minTextAdapt: true,
//         splitScreenMode: true,

//         // Use builder only if you need to use library outside ScreenUtilInit context
//         builder: (_, child) {
//           return BlocProvider.value(
//             value: _navigationCubit,
//             child: MultiBlocProvider(
//               providers: [
//                 BlocProvider.value(value: _navigationCubit),
//                 BlocProvider.value(value: _authCubit),
//               ],
//               child: BlocBuilder<NavigationCubit, int>(
//                 builder: (context, state) {
//                   return Scaffold(
//                     body: _buildPage(state, context),
//                     bottomNavigationBar: BottomNavigationBar(
//                       currentIndex: state,
//                       onTap: (index) {
//                         _navigationCubit.navigateToPage(
//                             _navigationCubit.mapIndexToEvent(index));
//                       },
//                       selectedItemColor: ColorManager.primary,
//                       unselectedItemColor:
//                           ColorManager.primary.withOpacity(0.3),
//                       //unselectedItemColor: Color,
//                       items: <BottomNavigationBarItem>[
//                         BottomNavigationBarItem(
//                           icon: Icon(
//                             Icons.emergency,
//                           ),
//                           label: 'جهات الطوارئ',
//                         ),
//                         BottomNavigationBarItem(
//                             icon: Icon(
//                               Icons.home,
//                             ),
//                             label: 'الرئيسية',
//                             backgroundColor: ColorManager.white),
//                         BottomNavigationBarItem(
//                           icon: Icon(
//                             Icons.sticky_note_2_outlined,
//                           ),
//                           label: 'البلاغات',
//                         ),
//                         BottomNavigationBarItem(
//                           icon: Icon(
//                             Icons.person_outline,
//                           ),
//                           label: 'نقاطي',
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         });
//   }

//   Widget _buildPage(int currentIndex, BuildContext context) {
//     switch (currentIndex) {
//       case 0:
//         return BlocBuilder<AuthCubit, AuthState>(
//           // listener: (context, state) {
//           //   if (state is AuthLoggedOutState) {
//           //     // Handle logout event here
//           //   }
//           // },
//           builder: (context, state) {
//             return EmergencyContact();
//           },
//           //   builder: (context, state) {
//           //   if (state is AuthLoggedInState) {
//           //     UserModel userModel = state.userModel;
//           //     return HomeView(
//           //       userModel: userModel,
//           //     );
//           //   } else {
//           //     return Scaffold(
//           //       body: Center(
//           //         child: Text("Log in to access this page"),
//           //       ),
//           //     );
//           //   }
//           // },
//         );
//       case 1:
//         return BlocBuilder<AuthCubit, AuthState>(
//           builder: (context, state) {
//             return HomeView(
//               userModel: UserModel(
//                   id: "id", phoneNumber: "090000000", username: "أيمن"),
//             );
//           },
//         );
//       case 2:
//         return ReportHistory();
//       case 3:
//         return Myprofile();
//       case 4:
//         return Scaffold(
//           body: Center(
//             child: Text(" empty page"),
//           ),
//         );
//       default:
//         return Container();
//     }
//   }
// }

