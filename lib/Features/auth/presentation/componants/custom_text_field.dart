import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.prefixIcon,
      this.validator,
      this.focusNode,
      this.errorMsg,
      this.onChanged});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      onTap: widget.onTap,
      textInputAction: TextInputAction.next,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        // helperStyle:
        //     getLightStyle(fontSize: FontSize.s20, color: Color(0XFF00000070)),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.sp),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: widget.hintText,
        hintStyle: getLightStyle(
          fontSize: FontSize.s14,
          color: Colors.grey[400],
        ),
        errorText: widget.errorMsg,
      ),
    );
  }
}
