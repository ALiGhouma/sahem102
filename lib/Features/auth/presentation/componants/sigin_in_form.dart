import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahem/Core/resources/app_strings.dart';
import 'package:sahem/Core/resources/assets_manager.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/resources/values_manager.dart';
import 'package:sahem/Core/utils/space_adder.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_cubit.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_state.dart';
import 'package:sahem/Features/auth/presentation/componants/custom_text_field.dart';
import 'package:sahem/Features/auth/presentation/componants/verify_phone_number.dart';

class SignInForm extends StatefulWidget {
  SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _signInFormKey = GlobalKey<FormState>();

  //String? _errorMsg;
  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
            controller: nameController,
            hintText: "اسم المستخدم",
            obscureText: false,
            keyboardType: TextInputType.name,
            prefixIcon: Icon(Icons.email_outlined),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.nameRequired;
              }
              return null;
            },
            //errorMsg: _errorMsg,
          ),
          addVerticalSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50.h,
                child: CustomTextField(
                  controller: phoneController,
                  hintText: "رقم الهاتف",
                  obscureText: false,
                  prefixIcon: Icon(Icons.lock),
                  keyboardType: TextInputType.number,
                  // validator: () {

                  // },
                ),
              ),
              addHorizontalSpace(15),
              Text(
                "+218",
                style: getRegularStyle(fontSize: FontSize.s14),
              ),
              addHorizontalSpace(15),

              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SvgPicture.asset(
                  ImapeAssets.libyaFlag,
                  height: 20,
                  width: 20,
                ),
              )
              // SvgPicture.asset(
              //   ImapeAssets.libyaFlag,
              //   height: 20,
              //   width: 20,
              // )
            ],
          ),
          addVerticalSpace(15),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthCodeSentState) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => VerifyPhoneNumber(
                        phoneController: phoneController,
                        nameController: nameController),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return TextButton(
                  onPressed: () async {
                    if (_signInFormKey.currentState!.validate()) {
                      // (+218)  the country code.
                      String phoneNumber = "+218${phoneController.text}";
                      BlocProvider.of<AuthCubit>(context)
                          .sendOTP(phoneNumber, nameController.text);
                    }
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
                    style: getRegularStyle(
                        fontSize: 16, color: ColorManager.white),
                  ));

              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   child: TextButton(

              //     child: const Text('Sign In'),
              //     onPressed: () {
              //       // Replace (+92) with the country code for your country.
              //       String phoneNumber = "+218${phoneController.text}";
              //       BlocProvider.of<AuthCubit>(context)
              //           .sendOTP(phoneNumber, nameController.text);
              //     },
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
