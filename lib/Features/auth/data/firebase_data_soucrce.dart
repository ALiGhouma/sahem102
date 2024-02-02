// import 'dart:ffi';

// import 'package:cloud_firestore/cloud_firestore.dart';

// abstract class FirebaseDataSource {
//   static FirebaseFirestore db = FirebaseFirestore.instance;
//   static Stream<QuerySnapshot<Map<String, dynamic>>> getTasks() {
//     final Stream<QuerySnapshot<Map<String, dynamic>>> stream =
//         db.collection("reports").snapshots();
//     return stream;
//   }

//   static Future<void> updateReports(
//     String reportId,
//     Map<String, dynamic> reportMap,
//   ) {
//     return db.collection('reports').doc(reportId).update(reportMap);
//   }
// }
