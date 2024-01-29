import 'dart:io';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final int age;
  final String? image;

  const UserModel(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.age,
      this.image});

  static const empty = UserModel(id: '', name: '', lastName: '', age: 15);

  // When comparing two instances of MyUser class we want to check
  // that all the properties are the same, then we can say that
  // the two instances are equals

  @override
  List<Object?> get props => [id, name, lastName, age, image];

//funchtion convert UserModel to map
  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'age': age,
      'image': image,
    };
  }

  //funchtion convert firebase  map to instance usermodel
  UserModel.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data["name"] as String,
        lastName = data['lastName'] as String,
        age = data['age'] as int,
        image = data['image'] as String?;

  UserModel copyWith({
    String? id,
    String? name,
    String? lastName,
    int? age,
    String? image,
  }) {
    return UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age,
        image: image ?? this.image);
  }
}
