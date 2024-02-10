import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/utils/space_adder.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_cubit.dart';
import 'package:sahem/Features/auth/presentation/view/sigin_in_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myprofile extends StatelessWidget {
  Myprofile({super.key});
  final String? firebaseAuth =
      FirebaseAuth.instance.currentUser?.phoneNumber.toString();
  final AuthCubit _authCubit = AuthCubit();

  //User username = _firebaseAuth.currentUser!.phoneNumber as User;
//   //   if (currentUser != null) {
//   //     return UserInformation(
//   //       uid: currentUser.uid,
//   //       phoneNumber: currentUser.phoneNumber,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: ColorManager.primary),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.01,
              child: IconButton(
                icon: Column(
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      textDirection: TextDirection.rtl,
                      color: ColorManager.white,
                      size: 32.sp,
                    ),
                    addVerticalSpace(2.h),
                    Text(
                      "الخروج",
                      style: getRegularStyle(
                          color: ColorManager.white, fontSize: FontSize.s12),
                    )
                  ],
                ),
                onPressed: () {
                  _showLogoutConfirmationDialog(context);
                },
              ),
            ),
            Positioned(
              top: 62.h,
              bottom: 0.h,
              left: 50.h,
              right: 60.h,
              child: Container(
                width: 120.h,
                height: 190.h,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(2, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: ColorManager.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: Icon(
                              Icons.person_2_outlined,
                              size: 32,
                            ),
                          ),
                          addHorizontalSpace(16),
                          Column(
                            children: [
                              addVerticalSpace(32),
                              Text(
                                "مرحبا$firebaseAuth",
                                style: getRegularStyle(color: Colors.grey[400]),
                              ),
                              addVerticalSpace(12),
                              // Text(
                              //   "أيمن",
                              //   style: getRegularStyle(),
                              // )
                              FutureBuilder<String>(
                                future: getUsernameFromSharedPreferences(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // While waiting for the data to be fetched, show a loading indicator
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // If there's an error fetching the data, display an error message
                                    return Text('Error fetching username');
                                  } else {
                                    // If the data is fetched successfully, display the username
                                    final username = snapshot.data;
                                    return Column(
                                      children: [
                                        Text(
                                          'مرحبا $username',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Hello $username',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
          // Text(
          //   'مرحبا  Mohammad Sharif',
          //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 20),
          // Text(
          //   'Hello Mohammad Sharif',
          //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // ),
          // ClipPath(
          //   clipper: new CustomHalfCircleClipper(),
          //   child: new Container(
          //     height: 200.0,
          //     width: 120.0,
          //     decoration: new BoxDecoration(
          //         color: ColorManager.primary,
          //         borderRadius: BorderRadius.circular(150.0)),
          //   ),
          // ),
          addVerticalSpace(16),
          SizedBox(
              height: 320,
              width: 300,
              child: Center(child: Image.asset('assets/images/Group33.jpg'))),
          addVerticalSpace(0),
          Container(
              width: 205.h,
              height: 65.h,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: ColorManager.white),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Image.asset('assets/images/GoldMedal3.png')),
                  ),
                  Text(
                    "يمنح الوسام عند تقيدم مبلاغ ",
                    style: getRegularStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              )),
          addVerticalSpace(8),
          Container(
              width: 205.h,
              height: 65.h,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: ColorManager.white),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Image.asset('assets/images/GoldMedal.png')),
                  ),
                  Text(
                    "يمنح الوسام عند تقيدم مبلاغ سليم",
                    style: getRegularStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ))
        ]),
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

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

Future<String> getUsernameFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('username') ?? '';
}
