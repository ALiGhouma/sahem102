// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sahem/Core/resources/app_strings.dart';
// import 'package:sahem/Core/resources/font_manger.dart';
// import 'package:sahem/Core/resources/style_manager.dart';
// import 'package:sahem/Core/utils/space_adder.dart';
// import 'package:sahem/Features/auth/presentation/componants/custom_text_field.dart';

// class SiginUpForm extends StatefulWidget {
//   SiginUpForm({super.key});

//   @override
//   State<SiginUpForm> createState() => _SiginUpFormState();
// }

// class _SiginUpFormState extends State<SiginUpForm> {
//   final Key _formKey = GlobalKey<FormState>();
//       TextEditingController phoneController = TextEditingController();
//     TextEditingController nameController = TextEditingController();
//    final emailControler = TextEditingController();
//    final passWordControler = TextEditingController();
//    final nameControler = TextEditingController();
//    IconData passWordIcon = CupertinoIcons.eye_fill;
//    bool obscureText = true;
//    bool containsUpperCase = false;
//    bool containsLowerCase = false;
//    bool containsNumber = false;
//    bool contains8Length = false;

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CustomTextField(
//               controller: emailControler,
//               hintText: 'email',
//               obscureText: false,
//               keyboardType: TextInputType.emailAddress,
//               prefixIcon: Icon(Icons.alternate_email),
//               validator: (val) {
//                 if (val!.isEmpty) {
//                   return 'ادخل الإيميل';
//                 } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
//                     .hasMatch(val)) {
//                   return "أدخل بريد الكتروني صالح";
//                 }
//                 return null;
//               },
//             ),
//             addVerticalSpace(16),
//             CustomTextField(
//               controller: passWordControler,
//               hintText: 'كلمة المرور',
//               obscureText: obscureText,
//               keyboardType: TextInputType.visiblePassword,
//               prefixIcon: const Icon(Icons.lock),
//               suffixIcon: TextButton(
//                 onPressed: () {
//                   obscureText = !obscureText;
//                   passWordIcon = obscureText
//                       ? CupertinoIcons.eye_fill
//                       : CupertinoIcons.eye_slash_fill;
//                 },
//                 child: Icon(passWordIcon),
//               ),
//               onChanged: (val) {
//                 if (val!.contains(RegExp(r'[A-Z]'))) {
//                   setState(() {
//                     containsUpperCase = true;
//                   });
//                 } else {
//                   setState(() {
//                     containsUpperCase = false;
//                   });
//                 }
//                 if (val.contains(RegExp(r'[a-z]'))) {
//                   setState(() {
//                     containsLowerCase = true;
//                   });
//                 } else {
//                   setState(() {
//                     containsLowerCase = false;
//                   });
//                 }
//                 if (val.contains(RegExp(r'[0-9]'))) {
//                   containsNumber = true;
//                 } else {
//                   containsNumber = false;
//                 }
//                 if (val.length >= 8) {
//                   setState(() {
//                     contains8Length = true;
//                   });
//                 } else {
//                   setState(() {
//                     contains8Length = false;
//                   });
//                 }
//               },
//               validator: (val) {
//                 if (val!.isEmpty) {
//                   return 'من فضلك املاء هذا الحقل';
//                 } else if (!RegExp(
//                         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
//                     .hasMatch(val)) {
//                   return 'ادخل كلمة سر صحيحة';
//                 }
//                 return null;
//               },
//             ),
//             addVerticalSpace(8),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       AppStrings.pssaWordfoeldRequiredLength,
//                       style: getRegularStyle(
//                           fontSize: FontSize.s14,
//                           color: contains8Length ? Colors.green : Colors.black),
//                     ),
//                     addVerticalSpace(8),
//                     Text(
//                       AppStrings.pssaWordfoeldRequirednumber,
//                       style: getRegularStyle(
//                           fontSize: FontSize.s14,
//                           color: containsNumber ? Colors.green : Colors.black),
//                     )
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       AppStrings.pssaWordfoeldRequiredUpper,
//                       style: getRegularStyle(
//                           fontSize: FontSize.s14,
//                           color:
//                               containsUpperCase ? Colors.green : Colors.black),
//                     ),
//                     addVerticalSpace(8),
//                     Text(
//                       AppStrings.pssaWordfoeldRequiredLower,
//                       style: getRegularStyle(
//                           fontSize: FontSize.s14,
//                           color: containsLowerCase
//                               ? Colors.green
//                               : Colors.redAccent),
//                     )
//                   ],
//                 )
//               ],
//             ),
//             addVerticalSpace(16),
//             CustomTextField(
//               controller: nameControler,
//               hintText: 'الإسم',
//               obscureText: false,
//               keyboardType: TextInputType.name,
//               prefixIcon: const Icon(Icons.person),
//               validator: (val) {
//                 if (val!.isEmpty) {
//                   return 'قم بتعبئة الحقل';
//                 } else if (val.length > 10) {
//                   return "الإسم طويل جدا";
//                 }
//                 return null;
//               },
//             )
//           ],
//         ));
//   }
// }
