import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahem/Core/resources/app_strings.dart';
import 'package:sahem/Core/resources/assets_manager.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //addVerticalSpace(60),
                SvgPicture.asset(
                  // we have other sequr Square libyan flag
                  ImageAssets.logo,
                ),
                // Text(
                //   " مرحبا بكم في تطبيق ساهم واجهتك  مع الجهات الخدمية ",
                //   textAlign: TextAlign.center,
                //   style: getBoldStyle(fontSize: FontSize.s16),
                // ),

                Text(
                  AppStrings.loginTitle,
                  textAlign: TextAlign.center,
                  style: getBoldStyle(fontSize: FontSize.s20),
                ),
                addVerticalSpace(50),
                SignInForm(),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              " جميع الحقوق محفوظة فريق ",
              style: getLightStyle(),
            ),
            Text(
              " اصدار رقم 1 ",
              style: getLightStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
