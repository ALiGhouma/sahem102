import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/app_strings.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/utils/space_adder.dart';
import 'package:sahem/Features/auth/presentation/componants/sigin_in_form.dart';

class SiginInViewBody extends StatefulWidget {
  const SiginInViewBody({super.key});

  @override
  State<SiginInViewBody> createState() => _SiginInViewBodyState();
}

class _SiginInViewBodyState extends State<SiginInViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              addVerticalSpace(15),
              // Center(
              //   child: Container(
              //     padding: EdgeInsets.all(16),
              //     height: 270.h,
              //     width: 270.w,
              //     decoration: BoxDecoration(
              //         //color: ColorManager.primary,
              //         shape: BoxShape.circle,
              //         gradient: LinearGradient(
              //             begin: Alignment.topCenter,
              //             end: Alignment.bottomCenter,
              //             colors: [
              //               ColorManager.primary,
              //               Color.fromARGB(255, 17, 150, 116)
              //             ])),
              //     child: Center(
              //       child: Text(
              //         AppStrings.loginbody,
              //         style: getRegularStyle(
              //             color: ColorManager.white, fontSize: FontSize.s18),
              //       ),
              //     ),
              //   ),
              // ),
              addVerticalSpace(50.h),
              Text(
                "مرحبا بكم في تطبيق ساهم الذي يربطك مع الجهات",
                textAlign: TextAlign.center,
                style: getBoldStyle(fontSize: FontSize.s18),
              ),
              addVerticalSpace(50),
              SignInForm(),
              addVerticalSpace(32.h),

              addVerticalSpace(50.h),
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            " جميع الحقوق محفوظة فريق ",
            style: getLightStyle(),
          ),
          Text(
            " اصدار رقم 2 ",
            style: getLightStyle(),
          ),
        ],
      ),
    );
  }
}
