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
  bool locationpermaion = false;
  bool isshowtext = false;

  CurrentLocationStepContant(
      {super.key,
      required this.Lan,
      required this.Lat,
      required this.currentAddress,
      required this.getcurrent});

  @override
  State<CurrentLocationStepContant> createState() =>
      _CurrentLocationStepContantState();
}

class _CurrentLocationStepContantState
    extends State<CurrentLocationStepContant> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      !widget.isshowtext
          ? Text(
              "اضغط على ايقونة لتحديد الموقع ",
              style: getLightStyle(fontSize: FontSize.s10),
            )
          : Text(
              "اضغط مرة اخرى لحذف الموقع ",
              style: getLightStyle(color: Colors.red, fontSize: FontSize.s14),
            ),
      addVerticalSpace(16),
      IconButton(
        onPressed: () {
          widget.getcurrent;
          setState(() {
            widget.isshowtext = !widget.isshowtext;
            print(widget.isshowtext);
          });
        },
        icon: widget.isshowtext
            ? Icon(
                Icons.location_off_outlined,
                size: 64.sp,
                color: ColorManager.primary,
              )
            : Icon(
                Icons.add_location_alt_outlined,
                size: 64.sp,
                color: ColorManager.primary,
              ),
      ),
      Visibility(
          visible: widget.isshowtext,
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
