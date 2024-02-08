import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/utils/space_adder.dart';

class CurrentLocationStepContant extends StatelessWidget {
  CurrentLocationStepContant({super.key});
  String? _currentAddress;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      addVerticalSpace(5),
      _currentAddress == null
          ? Column(
              children: [
                Text(
                  "لم يتم اصافة الموقع ",
                  style: getRegularStyle(
                      fontSize: FontSize.s16, color: Colors.red),
                ),
                addVerticalSpace(8),
                Text(
                  "اضغط على ايقونة لتحديد الموقع ",
                  style: getLightStyle(fontSize: FontSize.s10),
                ),
              ],
            )
          : Text(
              _currentAddress!,
              style: getRegularStyle(),
            ),
      addVerticalSpace(16),
      IconButton(
        onPressed: () {
          print('Current Location - LNG: ${""}, LAT: ${""}, ADDRESS: ${""}');
        },
        icon: Icon(
          Icons.add_location,
          size: 64.sp,
          color: ColorManager.primary,
        ),
      ),
    ]);
  }
}

// class CurrentLocation extends StatelessWidget {
//    CurrentLocation({super.key});

//   String? _currentAddress;
// }

// @override
//   Widget build(BuildContext context) {
   
      
//     return Column(
//       children: [
//         TextButton(
//           onPressed: () {
            
//             print(
//                 'Current Location - LNG: ${""}, LAT: ${""}, ADDRESS: ${ ""}');
//           },
//           child: Column(
//             children: [
//               Text("تحديد موقعك"),
//               addVerticalSpace(50),
//               if (_currentAddress != null)
//                 Text("Current Address: $_currentAddress"),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
