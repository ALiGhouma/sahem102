// import 'package:flutter/material.dart';
// class EmergencyContact extends StatefulWidget {
//   const EmergencyContact({super.key});

//   @override
//   State<EmergencyContact> createState() => _EmergencyContactState();
// }

// class _EmergencyContactState extends State<EmergencyContact> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text("emergency contact"),),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/utils/space_adder.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_cubit.dart';
import 'package:sahem/Features/auth/presentation/view/sigin_in_view.dart';
import 'package:sahem/Features/emergencyContact/componantes/rowscontnat.dart';

//import 'numbers_Page.dart';

class EmergencyContact extends StatelessWidget {
  final AuthCubit _authCubit = AuthCubit();

  EmergencyContact({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Column(
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        textDirection: TextDirection.rtl,
                        color: ColorManager.primary,
                        size: 32.sp,
                      ),
                      addVerticalSpace(2.h),
                      Text(
                        "الخروج",
                        style: getRegularStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s12),
                      )
                    ],
                  ),
                  onPressed: () {
                    _showLogoutConfirmationDialog(context);
                  },
                ),
              ],
            ),
            const Text(
              "الوصول السريع",
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              "للاستفادة منها في حال الطوارئ",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: rowCard(),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
    );
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
