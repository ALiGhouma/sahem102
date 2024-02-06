import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Features/add_report/presentation/Componants/image_step_content.dart';
import 'package:sahem/Features/home/dropdown_list.dart';
import 'package:sahem/Features/home/presentation/cubit/report_cubit.dart';
import 'package:sahem/Features/home/presentation/report_camera.dart';
import 'package:sahem/firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AddReportVomponantsView(),
//     );
//   }
//}

class AddReportVomponantsView extends StatefulWidget {
  const AddReportVomponantsView({Key? key}) : super(key: key);

  @override
  State<AddReportVomponantsView> createState() => _MyStepperState();
}

class _MyStepperState extends State<AddReportVomponantsView> {
  String selectedFisrtDropdownValue = '';
  int currentStep = 0;
  String? dropdownvalue;
  int firstDropdown = 5;
  var items = [
    'شركة الكهرباء',
    'المرور ',
    'مركز الشرطى',
    'الإسعاف',
  ];

  File? _selectedImage;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _selectedImage = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stepper(
        connectorColor: MaterialStatePropertyAll(ColorManager.primary),

        // controller: ,
        type: StepperType.horizontal,
        steps: getStep(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == getStep().length - 1;
          if (isLastStep) {
            //send data to server
            print("Complat");
          }
          currentStep == 2
              ? null
              : setState(() {
                  currentStep = currentStep + 1;
                });
        },
        onStepTapped: (step) => setState(() {
          currentStep = step;
        }),
        onStepCancel: () {
          currentStep == 0
              ? null
              : setState(() {
                  currentStep = currentStep - 1;
                });
        },

        controlsBuilder: (context, ControlsDetails controlsDetails) {
          return Container(
            margin: EdgeInsets.all(50),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: ElevatedButton(
                        onPressed: controlsDetails.onStepContinue,
                        child: Text(
                          "التالي",
                          //style: getRegularStyle(fontSize: FontSize.s8),
                        ))),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: controlsDetails.onStepCancel,
                        child: Text(
                          "رجوع",
                          //style: getRegularStyle(fontSize: FontSize.s8),
                        ))),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Step> getStep() => [
        Step(
            label: Text("data"),
            //subtitle: Text('aimen'),
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: Text(
              'التقاط صورة',
              style: getLightStyle(fontSize: 8),
            ),
            content: ImageStepContent(
                selectedImage: _selectedImage, getImage: _getImage)),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text(
            'جهة ونوع البلاغ',
            style: getLightStyle(fontSize: 8),
          ),
          content: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(children: [
                SizedBox(
                  height: 40,
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(8),
                    value: dropdownvalue,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                        selectedFisrtDropdownValue = newValue;
                        dropdownvalue == items[0]
                            ? firstDropdown = 0
                            : dropdownvalue == items[1]
                                ? firstDropdown = 1
                                : firstDropdown = 2;
                      });
                      print(dropdownvalue);
                    },
                  ),
                ),
                SecondPage(checker: firstDropdown)
              ])),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text(
            'التأكيد على البيانات',
            style: getLightStyle(fontSize: 8),
          ),
          content: Column(
            children: [
              Text(selectedFisrtDropdownValue),
              (SecondPage.secondDropdownValue != null)
                  ? Text(SecondPage.secondDropdownValue!)
                  : SizedBox(),
              (_selectedImage != null)
                  ? Image.file(
                      _selectedImage!,
                      height: 160,
                      width: 440,
                      fit: BoxFit.fill,
                    )
                  : SizedBox(),
              (SecondPage.noteTexetController != null)
                  ? Text(SecondPage.noteTexetController.text)
                  : SizedBox(),
              TextButton(
                  onPressed: () {
                    uploadFile();
                  },
                  child: Text('التاكيد'))
            ],
          ),
        ),
      ];
  Future uploadFile() async {
    Firebase.initializeApp();
    if (_selectedImage == null) return;
    final fileName = _selectedImage?.path;
    final destination = 'files/$fileName';
    var time = DateTime.now().toString();

    try {
      // final ref = firebase_storage.FirebaseStorage.instance
      //     .ref(destination)
      //     .child('reportesimage/id');
      await firebase_storage.FirebaseStorage.instance
          .ref('reportesimage/$time.png')
          .putFile(_selectedImage!);

      //await ref.putFile(_selectedImage!);
    } catch (e) {
      print(e);
    }
  }
}
