import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/utils/space_adder.dart';

class ImageStepContent extends StatelessWidget {
  final File? selectedImage;
  final Function()? getImage;

  const ImageStepContent({
    Key? key,
    required this.selectedImage,
    required this.getImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      child: Column(
        children: [
          (selectedImage != null)
              ? Column(
                  children: [
                    Image.file(
                      selectedImage!,
                      height: 160,
                      width: 440,
                      fit: BoxFit.fill,
                    ),
                    TextButton(
                      onPressed: getImage,
                      child: Text('اعادة الإلتقاط'),
                    ),
                  ],
                )
              : Column(
                  children: [
                    IconButton(
                      onPressed: getImage,
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        size: FontSize.s60.sp,
                      ),
                      color: ColorManager.primary,
                    ),
                    addVerticalSpace(5),
                    Text(
                      "من فضلك اضغط على الزر أعلاه للإلتقاط صورة",
                      style: getRegularStyle(fontSize: FontSize.s14),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
