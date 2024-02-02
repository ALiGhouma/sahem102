import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String phoneNumber;
  final String username;

  UserModel(
      {required this.id, required this.phoneNumber, required this.username});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      phoneNumber: data['phoneNumber'],
      username: data['username'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'phoneNumber': phoneNumber,
      'username': username,
    };
  }
}
