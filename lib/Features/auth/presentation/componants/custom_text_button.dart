import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/app_strings.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/resources/values_manager.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          // (+218)  the country code.
          // String phoneNumber = "+218${phoneController.text}";
          // BlocProvider.of<AuthCubit>(context)
          //     .sendOTP(phoneNumber, nameController.text);
        },
        style: TextButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width.w, 50),
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.r12.sp),
          ),
        ),
        child: Text(
          AppStrings.login,
          style: getRegularStyle(fontSize: 16, color: ColorManager.white),
        ));
  }
}
