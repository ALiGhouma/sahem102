import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width.w,
  );
}

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height.h,
  );
}
