import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/app_strings.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/resources/values_manager.dart';
import 'package:sahem/Core/utils/space_adder.dart';

class ReportCompleted extends StatelessWidget {
  const ReportCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "شكرا !",
              style: getRegularStyle(),
            ),
          ),
          Text(
            AppStrings.reportConfirmed,
            style: getRegularStyle(),
          ),
          addVerticalSpace(50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: SizedBox(
                    height: 50,
                    width: 120,
                    child: Text(
                      textAlign: TextAlign.center,
                      AppStrings.backToHomeView,
                      style: getRegularStyle(
                          color: ColorManager.primary, fontSize: FontSize.s12),
                    ),
                  ),
                ),
                addHorizontalSpace(20),
                TextButton(
                  onPressed: () {},
                  child: SizedBox(
                    height: 50,
                    width: 120,
                    child: Text(
                      textAlign: TextAlign.center,
                      AppStrings.goMyReports,
                      style: getRegularStyle(
                          color: ColorManager.primary, fontSize: FontSize.s12),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: null,
    );
  }
}
