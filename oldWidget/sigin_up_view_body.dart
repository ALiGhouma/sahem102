// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sahem/Core/resources/app_strings.dart';
// import 'package:sahem/Core/resources/color_manager.dart';
// import 'package:sahem/Core/resources/font_manger.dart';
// import 'package:sahem/Core/resources/style_manager.dart';
// import 'package:sahem/Core/utils/space_adder.dart';
// import 'package:sahem/Features/auth/presentation/componants/sigin_up_form.dart';

// class SiginUPViewBody extends StatefulWidget {
//   const SiginUPViewBody({super.key});

//   @override
//   State<SiginUPViewBody> createState() => _SiginUPViewBodyState();
// }

// class _SiginUPViewBodyState extends State<SiginUPViewBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               addVerticalSpace(64.h),
//               Text(
//                 AppStrings.register,
//                 style: getBoldStyle(fontSize: FontSize.s36),
//               ),
//               addVerticalSpace(64),
//               SiginUpForm(),
//               addVerticalSpace(32),
//               TextButton(
//                   onPressed: () {},
//                   style: TextButton.styleFrom(
//                     minimumSize: Size(MediaQuery.of(context).size.width.w, 50),
//                     backgroundColor: ColorManager.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(
//                           10.0), // Adjust the radius as needed
//                     ),
//                   ),
//                   child: Text(
//                     AppStrings.login,
//                     style: getRegularStyle(color: ColorManager.white),
//                   )),
//               addVerticalSpace(16.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     AppStrings.haveAccount,
//                     style: getRegularStyle(fontSize: FontSize.s12),
//                   ),
//                   //addHorizontalSpace(3),
//                   TextButton(
//                       onPressed: () {},
//                       style:
//                           //TODO: need to edit this Color
//                           TextButton.styleFrom(
//                               foregroundColor: Color.fromARGB(255, 10, 8, 184)),
//                       child: Text(
//                         AppStrings.logininNow,
//                         style: getRegularStyle(
//                             color: ColorManager.primary,
//                             fontSize: FontSize.s14),
//                       ))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
