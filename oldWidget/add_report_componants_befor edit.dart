import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Core/resources/font_manger.dart';
import 'package:sahem/Core/resources/style_manager.dart';
import 'package:sahem/Core/resources/values_manager.dart';
import 'package:sahem/Core/utils/space_adder.dart';
import 'package:sahem/Features/add_report/Data/report_model.dart';
import 'package:sahem/Features/add_report/presentation/Componants/current_location.dart';
import 'package:sahem/Features/add_report/presentation/Componants/image_step_content.dart';
import 'package:sahem/Features/add_report/presentation/Componants/report_completed.dart';
import 'package:sahem/Features/home/dropdown_list.dart';
import 'package:sahem/Features/home/presentation/cubit/report_cubit.dart';
import 'package:sahem/Features/home/presentation/report_camera.dart';
import 'package:sahem/Features/nav_bar/view/BottomNav.dart';
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
  String selectedFirstDropdownValue = '';
  int currentStep = 0;
  String? dropdownvalue;
  int firstDropdown = 5;
  String? sendReportErorr;
  var items = [
    'خدمات عامة',
    'خدمات الكهرباء',
    'خدمات المرور',
  ];
  bool isCompleted = false;

  File? _selectedImage;
  Position? _currentPosition;
  String? _currentAddress;
  StreamSubscription<Position>? positionStream;

  void listenToLocationChanges() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position? position) {
        print(position == null ? 'Unknown' : '$position');
        setState(() {
          _currentPosition = position;
        });
      },
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();

  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     setState(() => _currentPosition = position);
  //     _getAddressFromLatLng(_currentPosition!);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((error) {
      debugPrint('Error fetching current position: $error');
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = File(pickedFile!.path);
    });
  }

  @override
  void initState() {
    _getCurrentPosition();
    // TODO: implement initState
    super.initState();
    listenToLocationChanges();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    positionStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isCompleted
          ? ReportCompleted()
          : Column(
              children: [
                Container(
                  height: AppSize.s120.h,
                  width: MediaQuery.of(context).size.width.w,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF05AC8C), Color(0xFF12787C)]),
                  ),
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "إنشاء بلاغ جديد",
                          style: getBoldStyle(
                              fontSize: FontSize.s20,
                              color: ColorManager.white),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              textDirection: TextDirection.ltr,
                              color: ColorManager.white,
                            ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme:
                          ColorScheme.light(primary: ColorManager.primary)),
                  child: Stepper(
                    //connectorThickness: AppPadding.p23,
                    // controller: ,

                    type: StepperType.vertical,
                    steps: getStep(),
                    currentStep: currentStep,
                    onStepContinue: () {
                      final isLastStep = currentStep == getStep().length - 1;
                      if (isLastStep) {
                        uploadFile();
                        print("Complat");
                        setState(() {
                          isCompleted = true;
                        });
                      }
                      currentStep == 3
                          ? null
                          : setState(() {
                              currentStep = currentStep + 1;
                            });
                    },
                    onStepTapped: (step) => setState(() {
                      currentStep = step;
                    }),
                    stepIconBuilder: (stepIndex, stepState) {
                      if (stepIndex > currentStep) {}
                    },
                    onStepCancel: () {
                      currentStep == 0
                          ? null
                          : setState(() {
                              currentStep = currentStep - 1;
                            });
                    },

                    controlsBuilder:
                        (context, ControlsDetails controlsDetails) {
                      final isLastStep = currentStep == getStep().length - 1;
                      return Container(
                        margin: EdgeInsets.all(50),
                        child: Row(
                          children: <Widget>[
                            if (currentStep != 0)
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: controlsDetails.onStepCancel,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey),
                                    child: Text(
                                      "رجوع",
                                      style: getRegularStyle(
                                          fontSize: FontSize.s12,
                                          color: ColorManager.white),
                                    )),
                              ),
                            addHorizontalSpace(15),
                            Expanded(
                                child: isLastStep
                                    ? ElevatedButton(
                                        onPressed: () {
                                          uploadFile();
                                          print('thanks');
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorManager.primary),
                                        child: Text(
                                          isLastStep ? "التأكيد" : "التالي",
                                          style: getRegularStyle(
                                              fontSize: FontSize.s12,
                                              color: ColorManager.white),
                                        ))
                                    : ElevatedButton(
                                        onPressed:
                                            controlsDetails.onStepContinue,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorManager.primary),
                                        child: Text(
                                          isLastStep ? "التأكيد" : "التالي",
                                          style: getRegularStyle(
                                              fontSize: FontSize.s12,
                                              color: ColorManager.white),
                                        ))),
                          ],
                        ),
                      );
                    },
                  ),
                )),
              ],
            ),
    );
  }

  List<Step> getStep() => [
        Step(
            label: Text(
              'التقاط صورة',
              style: getLightStyle(fontSize: FontSize.s8),
            ),
            //subtitle: Text('aimen'),
            //state: currentStep > 0 ? StepState.complete : StepState.indexed,
            state: _selectedImage != null || currentStep > 0
                ? StepState.complete
                : StepState.indexed,
            isActive: currentStep >= 0,
            title: Text(
              'التقاط صورة',
              style: getLightStyle(fontSize: 8),
            ),
            content: ImageStepContent(
                selectedImage: _selectedImage, getImage: _getImage)),
        Step(
            label: Text(
              'التقاط صورة',
              style: getLightStyle(fontSize: FontSize.s8),
            ),
            //subtitle: Text('aimen'),
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: Text(
              'الموقع',
              style: getLightStyle(fontSize: 8),
            ),
            content: CurrentLocationStepContant(
                Lan: _currentPosition?.longitude ?? 0,
                Lat: _currentPosition?.longitude ?? 0,
                currentAddress: _currentAddress ?? "",
                getcurrent: _getCurrentPosition)),
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
                        selectedFirstDropdownValue = newValue;
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
                SecondDropDownlist(checker: firstDropdown)
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
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Title & info
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: ColorManager.primary,
                  ),
                  addHorizontalSpace(5),
                  Text(
                    "عنوان البلاغ",
                    style: getBoldStyle(fontSize: FontSize.s16),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.sp),
                child: Text(
                  'طرابلس, طريق الشط ',
                  style: getLightStyle(fontSize: FontSize.s12),
                ),
              ),
              addVerticalSpace(16),

              // Report Type & info
              Row(
                children: [
                  Icon(
                    Icons.call_split,
                    color: ColorManager.primary,
                  ),
                  Text(
                    "تصنيف البلاغ",
                    style: getBoldStyle(fontSize: FontSize.s16),
                  ),
                ],
              ),
              addVerticalSpace(3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.sp),
                child: Text(
                  selectedFirstDropdownValue,
                  style: getRegularStyle(fontSize: FontSize.s12),
                ),
              ),
              addVerticalSpace(3),
              // Report notes
              Row(
                children: [
                  (SecondDropDownlist.noteTexetController != null)
                      ? Text(SecondDropDownlist.noteTexetController.text)
                      : Text(
                          "",
                          style: getRegularStyle(
                              color: Colors.red, fontSize: FontSize.s16),
                        ),
                ],
              ),

              Row(
                children: [
                  Icon(
                    Icons.flag,
                    color: ColorManager.primary,
                  ),
                  addHorizontalSpace(5.w),
                  Text(
                    "نوع البلاغ",
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.h),
                child: (SecondDropDownlist.secondDropdownValue != null)
                    ? Text(SecondDropDownlist.secondDropdownValue!)
                    : Text(
                        "",
                        style: getRegularStyle(
                            color: Colors.red, fontSize: FontSize.s16),
                      ),
              ),

              // report notes
              addVerticalSpace(8),
              Row(
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    color: ColorManager.primary,
                  ),
                  addHorizontalSpace(5.w),
                  Text(
                    "معلومات عن البلاغ",
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.h),
                child: (SecondDropDownlist.noteTexetController.length > 0)
                    ? Text(SecondDropDownlist.noteTexetController.text)
                    : Text(
                        "لا توجد معلومات إضافية${SecondDropDownlist.noteTexetController.length}",
                        style: getRegularStyle(
                            color: Colors.red, fontSize: FontSize.s16),
                      ),
              ),

              (_selectedImage != null)
                  ? SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(),
              TextButton(
                  onPressed: () {
                    uploadFile();
                    sendReportToFirebase(context);
                  },
                  child: Text('التاكيد'))
            ],
          ),
        ),
      ];

  // Future uploadFile() async {
  //   Firebase.initializeApp();
  //   if (_selectedImage == null) return;
  //   final fileName = _selectedImage?.path;
  //   final destination = 'files/$fileName';
  //   var time = DateTime.now().toString();

  //   try {
  //     // final ref = firebase_storage.FirebaseStorage.instance
  //     //     .ref(destination)
  //     //     .child('reportesimage/id');
  //     await firebase_storage.FirebaseStorage.instance
  //         .ref('reportesimage/$time.png')
  //         .putFile(_selectedImage!);

  //     //await ref.putFile(_selectedImage!);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<String?> uploadFile() async {
    if (_selectedImage == null) return null;

    final fileName = _selectedImage!.path;
    final destination = 'files/$fileName';
    var time = DateTime.now().toString();

    try {
      // Upload the image to Firebase Storage
      var uploadTask = await firebase_storage.FirebaseStorage.instance
          .ref('reportesimage/$time.png')
          .putFile(_selectedImage!);

      // Get the download URL of the uploaded image
      var downloadURL = await uploadTask.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  void sendReportToFirebase(BuildContext context) async {
    try {
      // Upload the image and get the download URL
      var imageURL = await uploadFile();

      // Get a reference to the Firestore database
      final firestore = FirebaseFirestore.instance;

      // Generate a unique ID for the report
      var reportId =
          (await firestore.collection('reports').get()).docs.length + 1;

      // Prepare the data to be sent
      var data = {
        'reportId': reportId,
        'selectedFirstDropdownValue': selectedFirstDropdownValue,
        'secondDropdownValue': SecondDropDownlist.secondDropdownValue,
        'noteText': SecondDropDownlist.noteTexetController.text,
        'imageURL': imageURL ??
            '', // Use imageURL if available, otherwise an empty string
      };

      // Add the data to Firestore
      await firestore.collection('reports').doc(reportId.toString()).set(data);

      // Show a success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إرسال البلاغ بنجاح'),
        ),
      );

      // Reset the form or perform any other actions after sending the report
      // For example:
      // resetForm();
    } catch (e) {
      // Show an error Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء إرسال البلاغ'),
        ),
      );

      print('Error sending report: $e');
    }
  }

  // void sendReportToFirebase() async {
  //   try {
  //     // Get a reference to the Firestore database
  //     final firestore = FirebaseFirestore.instance;

  //     // Generate a unique ID for the report
  //     var reportId =
  //         (await firestore.collection('reports').get()).docs.length + 1;

  //     // Prepare the data to be sent
  //     var data = {
  //       'reportId': reportId,
  //       'ReportCatrogy': selectedFirstDropdownValue,
  //       'ReportType': SecondDropDownlist.secondDropdownValue,
  //       'Reportnotes': SecondDropDownlist.noteTexetController.text,
  //       'imageURL': _selectedImage != null ? 'URL_of_your_image' : '',
  //     };

  //     // Add the data to Firestore
  //     await firestore.collection('reports').doc(reportId.toString()).set(data);

  //     // Reset the form or perform any other actions after sending the report
  //     // For example:
  //     // resetForm();
  //   } catch (e) {
  //     print('Error sending report: $e');
  //   }
  // }
}
