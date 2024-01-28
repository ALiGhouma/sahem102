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
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Text(
          AppStrings.loginTitle,
          style:
              getBoldStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            addVerticalSpace(15),
            Center(
              child: Container(
                padding: EdgeInsets.all(16),
                height: 270.h,
                width: 270.w,
                decoration: BoxDecoration(
                    //color: ColorManager.primary,
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorManager.primary,
                          Color.fromARGB(255, 17, 150, 116)
                        ])),
                child: Center(
                  child: Text(
                    AppStrings.loginbody,
                    style: getRegularStyle(
                        color: ColorManager.white, fontSize: FontSize.s18),
                  ),
                ),
              ),
            ),
            addVerticalSpace(20),
            SiginInForm(),
            addVerticalSpace(32.h),
            TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width.w, 50),
                  backgroundColor: ColorManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                ),
                child: Text(
                  AppStrings.login,
                  style: getRegularStyle(color: ColorManager.white),
                )),
            addVerticalSpace(16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.dontHaveAccount,
                  style: getRegularStyle(fontSize: FontSize.s12),
                ),
                // addHorizontalSpace(1.w),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.register,
                      style: getRegularStyle(
                          color: ColorManager.primary, fontSize: FontSize.s14),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
