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
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   // final emailControler = TextEditingController();
//   // final passWordControler = TextEditingController();
//   // final nameControler = TextEditingController();
//   // IconData passWordIcon = CupertinoIcons.eye_fill;
//   // bool obscureText = true;
//   // bool containsUpperCase = false;
//   // bool containsLowerCase = false;
//   // bool containsNumber = false;
//   // bool contains8Length = false;

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CustomTextField(
//               controller: phoneController,
//               hintText: 'mobile',
//               obscureText: false,
//               keyboardType: TextInputType.emailAddress,
//               prefixIcon: Icon(Icons.alternate_email),
//               // validator: (val) {
//               //   if (val!.isEmpty) {
//               //     return 'ادخل الإيميل';
//               //   } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
//               //       .hasMatch(val)) {
//               //     return "أدخل بريد الكتروني صالح";
//               //   }
//               //   return null;
//               // },
//             ),
//             addVerticalSpace(16),
//             addVerticalSpace(8),
//             addVerticalSpace(16),
//             CustomTextField(
//               controller: nameController,
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
