import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String id;
  final String category;
  final String type;
  //final File selectedImage;

  ReportModel({
    required this.id,
    required this.category,
    required this.type,
    //required this.selectedImage,
  });

  factory ReportModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ReportModel(
      id: doc.id,
      category: data['category'],
      type: data['type'],
      //selectedImage: data["selectedImage"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      category: category,
      type: type,
      //selectedImage: selectedImage,
    };
  }
}
