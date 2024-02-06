// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// abstract class ReportState {}

// class ReportInitial extends ReportState {}

// class ReportContinu extends ReportState {}

// class ReportCubit extends Cubit<ReportState> {
//   ReportCubit() : super(ReportInitial());
//   Future uploadFile(File selectedImage) async {
//     // Firebase.initializeApp();
//     if (selectedImage == null) return;
//     //final fileName = selectedImage?.path;
//     //final destination = 'files/$fileName';
//     var time = DateTime.now().toString();

//     try {
//       //final ref = FirebaseStorage.instance
//       //     .ref(destination)
//       //     .child('reportesimage/id');
//       await firebase_storage.FirebaseStorage.instance
//           .ref('reportesimage/$time.png')
//           .putFile(selectedImage!);
//       //await ref.putFile(_selectedImage!);
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> getImage(selectedImage) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     selectedImage = File(pickedFile!.path);
//     emit(state);
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  File? _selectedImage;
  int currentStep = 0;
  String? dropdownvalue;
  int firstDropdown = 5;
  var items = [
    'شركة الكهرباء',
    'المرور ',
    'مركز الشرطى',
    'الإسعاف',
  ];

  String selectedFisrtDropdownValue = '';

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      emit(ImageSelected(image: _selectedImage));
    } else {
      emit(ImageSelectionFailed());
    }
  }

  void changeStep(int step) {
    currentStep = step;
    emit(StepChanged(step: step));
  }

  void updateDropdownValue(String value) {
    dropdownvalue = value;
    selectedFisrtDropdownValue = value;
    dropdownvalue == items[0]
        ? firstDropdown = 0
        : dropdownvalue == items[1]
            ? firstDropdown = 1
            : firstDropdown = 2;
    emit(DropdownValueChanged());
  }

  Future<void> uploadFile() async {
    if (_selectedImage == null) return;
    final fileName = _selectedImage?.path;
    final destination = 'files/$fileName';
    var time = DateTime.now().toString();

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('reportesimage/$time.png')
          .putFile(_selectedImage!);
      emit(FileUploaded());
    } catch (e) {
      print(e);
      emit(FileUploadFailed());
    }
  }
}
