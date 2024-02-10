// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sahem/Core/resources/color_manager.dart';
// import 'package:sahem/Core/resources/style_manager.dart';
// import 'package:sahem/Core/utils/space_adder.dart';
// import 'package:sahem/Features/auth/data/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ReportHistory extends StatelessWidget {
//   ReportHistory({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<String> typelist = ['نظافة عامة', 'انقطاع كهرباء', 'ازدحام'];
//     List<bool> isActiveList = [true, false, true]; // Example boolean list

//     bool isDoen;
//     return FutureBuilder(
//       future: FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection('addresses')
//           .get(),
//       builder: (context, AsyncSnapshot snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           // Use address ID to fetch reports with the same ID
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               var reportData =
//                   snapshot.data!.docs[index].data() as Map<String, dynamic>;
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   addVerticalSpace(15),
//                   Container(
//                     width: 380,
//                     height: 81,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: ColorManager.primary)),
//                     child: Row(children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text("نوع البلاغ", style: getRegularStyle()),
//                           Text("${typelist[index]}", style: getRegularStyle()),
//                           // Add the selectable items here
//                           // You can use typelist to map through the items
//                         ],
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(Icons.call_missed_outlined),
//                               isActiveList[index]
//                                   ? Text("مفعل", style: getRegularStyle())
//                                   : Text("غير مفعل", style: getRegularStyle()),
//                             ],
//                           ),
//                           Text("22/01/2024"),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       )
//                     ]),
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_cubit.dart';
import 'package:sahem/Features/auth/presentation/view/sigin_in_view.dart';

class UserReportsPage extends StatefulWidget {
  final AuthCubit _authCubit = AuthCubit();
  final String? firebaseAuth =
      FirebaseAuth.instance.currentUser?.phoneNumber.toString();
  UserReportsPage({
    super.key,
  });

  @override
  State<UserReportsPage> createState() => _UserReportsPageState();
}

class _UserReportsPageState extends State<UserReportsPage> {
  final _firestore = FirebaseFirestore.instance;

  // final String currentUserNumber; // Current user's number
  final String? firebaseAuth =
      FirebaseAuth.instance.currentUser?.phoneNumber.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Reports'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        //  stream: _firestore.collection('reports').snapshots(),

        stream: _firestore
            .collection('reports')
            .where('phoneNumber', isEqualTo: widget._authCubit)
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final userData = user.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(userData['userId'] ?? "no name"),
                subtitle:
                    Text(userData['phoneNumber'] ?? "no number" as String),
              );
            },
          );
        },
      ),
    );
  }
}
//   void _showLogoutConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("تأكيد الخروج"),
//           content: Text("هل أنت متأكد أنك تريد تسجيل الخروج؟"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("لا"),
//             ),
//             TextButton(
//               onPressed: () {
//                 _logout(context);
//               },
//               child: Text("نعم"),
//             ),
//           ],
//         );
//       },
//     );
//   }

  // void _logout(BuildContext context) {
  //   // Delete username from SharedPreferences
  //  ._authCubit.saveUsername('');
  //   // Postpone any process that requires the username
  //   // Here you can add any additional cleanup tasks before logging out
  //   // For example, you might want to clear the current user session, etc.
  //   // Then navigate to the home page
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => SiginInView()),
  //     (route) => false,
  //   );
  // }
