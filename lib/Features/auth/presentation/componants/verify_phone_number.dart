// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pinput/pinput.dart';
// import 'package:sahem/Core/resources/color_manager.dart';
// import 'package:sahem/Features/auth/manger/cubit/auth_cubit.dart';
// import 'package:sahem/Features/auth/manger/cubit/auth_state.dart';
// import 'package:sahem/Features/home/presentation/home_view.dart';

// class VerifyPhoneNumber extends StatelessWidget {
//   const VerifyPhoneNumber({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController optController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Verify Number'),
//       ),
//       body: SafeArea(
//           child: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // TextField(
//                 //   controller: optController,
//                 //   maxLength: 6,
//                 //   keyboardType: TextInputType.number,
//                 //   decoration: const InputDecoration(
//                 //     border: OutlineInputBorder(),
//                 //     hintText: '6 رمز التحقق',
//                 //     counterText: "",
//                 //   ),
//                 // ),
//                 Pinput(
//                   controller: optController,
//                   length: 6,
//                   keyboardType: TextInputType.number,
//                   onCompleted: (otp) {
//                     BlocProvider.of<AuthCubit>(context).verifyOTP(otp);
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 BlocConsumer<AuthCubit, AuthState>(
//                   listener: (context, state) {
//                     if (state is AuthLoggedInState) {
//                       Navigator.popUntil(context, (route) => route.isFirst);

//                       Navigator.pushReplacement(
//                         context,
//                         CupertinoPageRoute(
//                           builder: (context) => const homeView(),
//                         ),
//                       );
//                     } else if (state is AuthErrorState) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(state.error),
//                           duration: const Duration(milliseconds: 600),
//                           backgroundColor: Colors.red,
//                         ),
//                       );
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is AuthLoadingState) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                     return SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: CupertinoButton(
//                         color: ColorManager.primary,
//                         child: const Text('Verify'),
//                         onPressed: () {
//                           BlocProvider.of<AuthCubit>(context)
//                               .verifyOTP(optController.text);
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:sahem/Core/resources/app_strings.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/resources/values_manager.dart';
import 'package:sahem/Core/utils/space_adder.dart';
import 'package:sahem/Features/add_report/presentation/view/add_report_view.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_cubit.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_state.dart';
import 'package:sahem/Features/auth/presentation/view/sigin_in_view.dart';
import 'package:sahem/Features/home/presentation/home_view.dart';
import 'package:sahem/Features/home/presentation/home_screen.dart';
import 'package:sahem/Features/home/presentation/reports.dart';
import 'package:sahem/Features/nav_bar/view/BottomNav.dart';

class VerifyPhoneNumber extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController nameController;

  VerifyPhoneNumber(
      {super.key, required this.phoneController, required this.nameController});

  @override
  State<VerifyPhoneNumber> createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

    const focusedBorderColor = Color.fromRGBO(97, 230, 205, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: getRegularStyle(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    TextEditingController optController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.verifyNumber,
          style: getBoldStyle(fontSize: FontSize.s18),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              ColorManager.white,
              Colors.white,
              ColorManager.primary,
            ])),
        child: SafeArea(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextField(
                  //   controller: optController,
                  //   maxLength: 6,
                  //   keyboardType: TextInputType.number,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: '6 رمز التحقق',
                  //     counterText: "",
                  //   ),
                  // ),
                  Center(
                    child: Text(
                      AppStrings.verifyBody,
                      style: getMediumStyle(fontSize: FontSize.s14),
                    ),
                  ),
                  Text(widget.phoneController.text),
                  addVerticalSpace(50),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      focusNode: focusNode,
                      controller: optController,
                      length: 6,
                      // this important to save number and and pass it to
                      // to finsh aut
                      onCompleted: (otpNumber) {
                        BlocProvider.of<AuthCubit>(context)
                            .verifyOTP(otpNumber);
                      },
                      keyboardType: TextInputType.number,
                      animationCurve: Curves.bounceIn,
                      errorText: "wrong code",
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(AppRadius.r16.sp),
                          border: Border.all(color: ColorManager.primary),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoggedInState) {
                        Navigator.popUntil(context, (route) => route.isFirst);

                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => CustomBottomNav(
                                    userModel: state.userModel,
                                  )
                              // homeView(
                              //   userModel: state.userModel,
                              // ),
                              ),
                        );
                      } else if (state is AuthErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return Center(
                          child: LoadingAnimationWidget.discreteCircle(
                              color: Colors.white,
                              size: AppSize.s40,
                              thirdRingColor: Colors.blue),
                        );
                      }
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CupertinoButton(
                          color: ColorManager.primary,
                          child: Text(
                            AppStrings.sendVerify,
                            style: getRegularStyle(color: ColorManager.white),
                          ),
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context)
                                .verifyOTP(optController.text);
                          },
                        ),
                      );
                    },
                  ),
                  // addVerticalSpace(50),
                  // Text(
                  //   AppStrings.dontReciveCode,
                  //   style: getLightStyle(),
                  // ),
                  // addVerticalSpace(5),

                  // Text(
                  //   "هذا الزر لا يعمل بعد",
                  //   style: getLightStyle(fontSize: 14, color: Colors.red),
                  // ),
                  //TODO: dosent work yet
                  // TextButton(
                  //     onPressed: () {
                  //       // (+218)  the country code.
                  //       String phoneNumber = "+218${phoneController.text}";
                  //       BlocProvider.of<AuthCubit>(context)
                  //           .sendOTP(phoneNumber, nameController.text);
                  //     },
                  //     child: Text(
                  //       AppStrings.reSendVerify,
                  //       style: getRegularStyle(color: ColorManager.primary),
                  //     ))
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
