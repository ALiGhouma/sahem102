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
import 'package:sahem/Features/auth/data/user_model.dart';

class homeView extends StatelessWidget {
  final UserModel userModel;

  const homeView({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${userModel.username}'),
            Text('Phone Number: ${userModel.phoneNumber}'),
            // Add other widgets as needed
          ],
        ),
      ),
    );
  }
}
