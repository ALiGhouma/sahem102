import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahem/Core/utils/space_adder.dart';
import 'package:sahem/Features/auth/presentation/componants/custom_text_field.dart';

class SiginInForm extends StatelessWidget {
  SiginInForm({super.key});
  String? _errorMsg;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Key _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            child: CustomTextField(
              controller: emailController,
              hintText: "username",
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(Icons.email_outlined),
              errorMsg: _errorMsg,
            ),
          ),
          addVerticalSpace(15),
          SizedBox(
            child: CustomTextField(
              controller: passwordController,
              hintText: "الرقم السري",
              obscureText: true,
              prefixIcon: Icon(Icons.lock),
              keyboardType: TextInputType.visiblePassword,
              // validator: () {

              // },
              suffixIcon: IconButton(
                onPressed: () {
                  obscurePassword = !obscurePassword;
                  if (obscurePassword) {
                    iconPassword = CupertinoIcons.eye_fill;
                  } else {
                    iconPassword = CupertinoIcons.eye_slash;
                  }
                },
                icon: Icon(iconPassword),
              ),
            ),
          )
        ],
      ),
    );
  }
}
