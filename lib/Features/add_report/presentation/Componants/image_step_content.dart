import 'dart:io';

import 'package:flutter/material.dart';

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
                    TextButton(
                      onPressed: getImage,
                      child: Text('Add pic'),
                    ),
                    Text("من فضلك اضغط على الزر أعلاه لاتقاط صورة"),
                  ],
                ),
        ],
      ),
    );
  }
}
