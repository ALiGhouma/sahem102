// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sahem/Features/add_report/Data/report_model.dart';
// import 'package:sahem/Features/add_report/presentation/manager/add_report_state.dart';
// import 'package:sahem/Features/auth/data/user_model.dart';
// import 'package:sahem/Features/auth/manger/cubit/auth_state.dart';
// import 'package:sahem/Features/home/presentation/cubit/report_cubit.dart';

// class AdddReportCubit extends Cubit<AdddReportState> {
//   //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   AdddReportCubit()
//       : super(
//           AdddReportInitianState(),
//         );

//   void SendReport(category, type) async {
//     try {
//       // UserCredential userCredential =
//       //     await _firebaseAuth.signInWithCredential(credential);

//       ReportModel reportModel = ReportModel(
//         id: "FirebaseStorage",
//         category: category,
//         type: type,
//       );
//       await FirebaseFirestore.instance
//           .collection('Reports')
//           .doc("userCredential.user!.uid")
//           .set(reportModel.toFirestore());
//       // saveCurrentUserData();
//       // UserModel userModel = UserModel(
//       //   id: userCredential.user!.uid,
//       //   phoneNumber: userCredential.user!.phoneNumber!,
//       //   username: username!,
//       // );
//     } on FirebaseAuthException catch (ex) {
//       emit(AddReportErrorState(ex.message.toString()));
//     }
//   }
// }
