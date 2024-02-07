// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class homeView extends StatelessWidget {
//   homeView({super.key});
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//     inputData() {
//     final User? user = _firebaseAuth.currentUser;
//     final Uid = user?.uid;

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(inputData),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Features/auth/data/user_model.dart';

class HomeView extends StatelessWidget {
  final UserModel userModel;

  final List<String> images = [
    'https://image.adsoftheworld.com/xrwxxt020548rglngk3gj7329adl',
    'https://image.adsoftheworld.com/xrwxxt020548rglngk3gj7329adl',
    'https://image.adsoftheworld.com/xrwxxt020548rglngk3gj7329adl',
    'https://image.adsoftheworld.com/xrwxxt020548rglngk3gj7329adl',
    'https://image.adsoftheworld.com/xrwxxt020548rglngk3gj7329adl',
  ];
  HomeView({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            //this where i called the widget such customappbar
            Container(
              width: double.infinity,
              height: 150.h,
              //MediaQuery.of(context).size.height * 0.25,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  // begin: Alignment(0.01, -1.00),
                  // end: Alignment(-0.01, 1),
                  colors: [Color(0xFF05AC8C), Color(0xFF12787C)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.sp),
                    bottomRight: Radius.circular(20.sp),
                  ),
                ),
              ),
              child: Stack(children: [
                Positioned(
                  right: MediaQuery.of(context).size.width * -0.2,
                  top: MediaQuery.of(context).size.height * 0.1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.07),
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.09,
                  child: const CircleAvatar(
                    maxRadius: 30,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.17,
                  child: Text(
                    'مرحبا بيك ...',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text('Welcome ${userModel.username}'),
            Text('Phone Number: ${userModel.phoneNumber}'),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),

            //i called the report button
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              decoration: const ShapeDecoration(
                color: Color(0xFFAADBD8),
                shape: OvalBorder(),
              ),
              child: Stack(
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.width * 0.65,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF05AC8C),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'اضافة بلاغ ',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.03, // Adjust the height as per your requirement
            ),
            Container(
              height: MediaQuery.of(context).size.height *
                  0.10, // Adjust the height as per your requirement
              width: double.infinity,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.01, -1.00),
                  end: Alignment(-0.01, 1),
                  colors: [Color(0xFF05AC8C), Color(0xFF12787C)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    ' خدماتك البلدية رقمية في \n   أي وقت ومن أي مكان',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
