
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/utils/space_adder.dart';

class CurrentLocationStepContant extends StatefulWidget {
  final double Lan;
  final double Lat;
  final Function() getcurrent;
 final String currentAddress;

  CurrentLocationStepContant({super.key, required this.Lan, required this.Lat, required this.currentAddress, required this.getcurrent});

  @override
  State<CurrentLocationStepContant> createState() => _CurrentLocationStepContantState();
}

class _CurrentLocationStepContantState extends State<CurrentLocationStepContant> {
  @override
  Widget build(BuildContext context) {
    bool isshowtext = false;

    return Column(children: [
      Text(
        "اضغط على ايقونة لتحديد الموقع ",
        style: getLightStyle(fontSize: FontSize.s10),
      ),
      addVerticalSpace(16),
      IconButton(
        onPressed: () {
          widget.getcurrent;
          setState(() {
            isshowtext = !isshowtext;
          });},
        icon: Icon(
          Icons.add_location,
          size: 64.sp,
          color: ColorManager.primary,
        ),
      ),
      Visibility(
          visible: !isshowtext,
          child: Column(
            children: [
              Text('LNG: ${widget.Lan}'),
              Text('LAT: ${widget.Lat}'),
              Text('ADDRESS: ${widget.currentAddress}'),
            ],
          ))
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
