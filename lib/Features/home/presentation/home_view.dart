// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sahem/Core/resources/color_manager.dart';
// import 'package:sahem/Features/add_report/presentation/view/add_report_view.dart';
// import 'package:sahem/Features/auth/data/user_model.dart';

// class HomeView extends StatelessWidget {
//   final UserModel userModel;

//   final List<String> images = [
//     'assets/images/slider(1).jpg',
//     'assets/images/slider(2).jpg',
//     'assets/images/slider(3).jpg',
//     'assets/images/slider(4).jpg',
//   ];
//   HomeView({Key? key, required this.userModel}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: SingleChildScrollView(
//         physics: NeverScrollableScrollPhysics(),
//         child: Column(
//           children: [
//             //this where i called the widget such customappbar
//             Container(
//               width: double.infinity,
//               height: 150.h,
//               //MediaQuery.of(context).size.height * 0.25,
//               decoration: ShapeDecoration(
//                 gradient: const LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,

//                   // begin: Alignment(0.01, -1.00),
//                   // end: Alignment(-0.01, 1),
//                   colors: [Color(0xFF00C8D7), Color(0xFF12787C)],
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(20.sp),
//                     bottomRight: Radius.circular(20.sp),
//                   ),
//                 ),
//               ),
//               child: Stack(children: [
//                 Positioned(
//                   right: MediaQuery.of(context).size.width * -0.2,
//                   top: MediaQuery.of(context).size.height * 0.1,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 1,
//                     height: MediaQuery.of(context).size.height * 0.75,
//                     decoration: ShapeDecoration(
//                       color: Colors.white.withOpacity(0.07),
//                       shape: const OvalBorder(),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: MediaQuery.of(context).size.width * 0.1,
//                   top: MediaQuery.of(context).size.height * 0.09,
//                   child: const CircleAvatar(
//                     maxRadius: 30,
//                     child: Icon(
//                       Icons.person,
//                       size: 50,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: MediaQuery.of(context).size.width * 0.1,
//                   top: MediaQuery.of(context).size.height * 0.17,
//                   child: Row(
//                     children: [
//                       Text(
//                         'مرحبا بيك  ',
//                         style: TextStyle(fontSize: 20, color: Colors.white),
//                       ),
//                       Text(
//                         userModel.username,
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Color.fromARGB(255, 196, 238, 232)),

//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.15,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: images.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 250,
//                       width: 190,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8.0),
//                         child: Image.asset(
//                           images[index],
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             // Text('Welcome ${userModel.username}'),
//             // Text('Phone Number: ${userModel.phoneNumber}'),

//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.01,
//             ),

//             //i called the report button
//             Container(
//               width: MediaQuery.of(context).size.width * 0.6,
//               height: MediaQuery.of(context).size.width * 0.6,
//               decoration: const ShapeDecoration(
//                 color: Color(0xFFAADBD8),
//                 shape: OvalBorder(),
//               ),
//               child: Stack(
//                 children: [
//                   Center(
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 AddReportView(), // Replace YourOtherPage() with the actual name of your other page
//                           ),
//                         );
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.65,
//                         height: MediaQuery.of(context).size.width * 0.65,
//                         decoration: const ShapeDecoration(
//                           color: Color(0xFF05AC8C),
//                           shape: OvalBorder(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Text(
//                       'اضافة بلاغ ',
//                       textAlign: TextAlign.right,
//                       style: TextStyle(
//                         color: ColorManager.white,
//                         fontSize: 25,
//                         fontWeight: FontWeight.w700,
//                         height: 0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height *
//                   0.03, // Adjust the height as per your requirement
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height *
//                   0.10, // Adjust the height as per your requirement
//               width: double.infinity,
//               decoration: const ShapeDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment(0.01, -1.00),
//                   end: Alignment(-0.01, 1),
//                   colors: [Color(0xFF05AC8C), Color(0xFF12787C)],
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(20),
//                     topLeft: Radius.circular(20),
//                   ),
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     ' خدماتك البلدية رقمية في \n   أي وقت ومن أي مكان',
//                     style: TextStyle(
//                         fontSize: 25,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Features/add_report/presentation/view/add_report_view.dart';
import 'package:sahem/Features/auth/data/user_model.dart';
import 'package:sahem/Features/home/componants/add_report_button.dart';

class HomeView extends StatefulWidget {
  final UserModel userModel;

  HomeView({Key? key, required this.userModel}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> images = [
    'assets/images/slider(1).jpg',
    'assets/images/slider(2).jpg',
    'assets/images/slider(3).jpg',
    'assets/images/slider(4).jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 120.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF05AC8C),
                      Color(0xFF12787C),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.sp),
                    bottomRight: Radius.circular(20.sp),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -MediaQuery.of(context).size.width * 0.2,
                      top: MediaQuery.of(context).size.height * 0.1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.75,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.07),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.05,
                      child: CircleAvatar(
                        maxRadius: 24,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 32,
                          color: Color(0xFF05AC8C),
                        ),
                      ),
                    ),
                    Positioned(
                      right: MediaQuery.of(context).size.width * 0.1,
                      top: MediaQuery.of(context).size.height * 0.12,
                      child: Row(
                        children: [
                          Text(
                            'مرحبا بيك  ',
                            style: getBoldStyle(
                                color: ColorManager.white.withOpacity(0.8),
                                fontSize: FontSize.s16),
                          ),
                          Text(
                            widget.userModel.username,
                            style: getBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: images
                      .map((image) => Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: 210.h,
                              width: 190.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              AnimatedAddReportButton(),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.01, -1.00),
                    end: Alignment(-0.01, 1),
                    colors: [Color(0xFF05AC8C), Color(0xFF12787C)],
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.sp),
                    topLeft: Radius.circular(20.sp),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Center(
                  child:
                      Text(' خدمات البلدية الرقمية  \n   في أي وقت ومن أي مكان',
                          textAlign: TextAlign.center,
                          style:
                              // TextStyle(
                              //   fontSize: 18.sp,
                              //   color: Colors.white,
                              //   fontWeight: FontWeight.bold,
                              // ),
                              getRegularStyle(color: ColorManager.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AddReportView(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 150.w,
//                   height: 150.h,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [Color(0xFF05AC8C), Color(0xFF12787C)],
//                     ),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 10,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       'اضافة بلاغ ',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: ColorManager.white,
//                         fontSize: 25.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),