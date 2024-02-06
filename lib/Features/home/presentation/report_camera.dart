// import 'dart:async';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:gallery_saver/gallery_saver.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:sahem/Core/resources/color_manager.dart';
// import 'package:sahem/Features/home/presentation/v_report.dart';

// class ReportCamera extends StatefulWidget {
//   const ReportCamera({super.key});

//   @override
//   State<ReportCamera> createState() => _ReportCameraState();
// }

// class _ReportCameraState extends State<ReportCamera> {
//   late List<CameraDescription> cameras;
//   late CameraController cameraController;
//   Position? _currentPosition;
//   String? _currentAddress;
//   StreamSubscription<Position>? positionStream;

//   @override
//   void initState() {
//     startCamera();
//     // TODO: implement initState
//     super.initState();
//     listenToLocationChanges();
//   }

//   void listenToLocationChanges() {
//     final LocationSettings locationSettings = LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 100,
//     );
//     positionStream =
//         Geolocator.getPositionStream(locationSettings: locationSettings).listen(
//       (Position? position) {
//         print(position == null ? 'Unknown' : '$position');
//         setState(() {
//           _currentPosition = position;
//         });
//       },
//     );
//   }

//   void startCamera() async {
//     cameras = await availableCameras();
//     cameraController =
//         CameraController(cameras[0], ResolutionPreset.high, enableAudio: false);
//     await cameraController.initialize().then((value) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();

//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//       _getAddressFromLatLng(_currentPosition!);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   Future<void> _getAddressFromLatLng(Position position) async {
//     await placemarkFromCoordinates(
//             _currentPosition!.latitude, _currentPosition!.longitude)
//         .then((List<Placemark> placemarks) {
//       Placemark place = placemarks[0];
//       setState(() {
//         _currentAddress =
//             '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
//       });
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   @override
//   void dispose() {
//     cameraController.dispose();
//     // TODO: implement dispose
//     super.dispose();
//     positionStream?.cancel();
//   }

//   Color _bgColor = Colors.white;

//   Future<void> toggleFlashlight() async {
//     if (cameraController.value.isInitialized) {
//       if (cameraController.value.flashMode == FlashMode.off) {
//         await cameraController.setFlashMode(FlashMode.torch);
//         setState(() {
//           _bgColor = Colors.greenAccent;
//         });
//       } else {
//         await cameraController.setFlashMode(FlashMode.off);
//         setState(() {
//           _bgColor = Colors.white;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isOn = false;
//     if (cameraController.value.isInitialized) {
//       return SafeArea(
//         child: Scaffold(
//           body: Column(
//             children: [
//               customAppBar(),
//               // const SizedBox(
//               //   height: 10,
//               // ),
//               Container(
//                 margin: const EdgeInsets.only(left: 15, right: 15),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'صورة للبلاغ',
//                       style:
//                           TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 height: 650,
//                 child: Stack(
//                   children: [
//                     CameraPreview(
//                       cameraController,
//                       child: Stack(
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                   child: IconButton(
//                                 onPressed: () {
//                                   toggleFlashlight();
//                                 },
//                                 icon: Icon(
//                                   (isOn == false)
//                                       ? Icons.flash_on
//                                       : Icons.flash_off,
//                                   size: 50,
//                                   color: Colors.white70,
//                                 ),
//                               )),
//                             ],
//                           ),
//                           Positioned(
//                               top: 475,
//                               right: 115,
//                               child: IconButton(
//                                 icon: Icon(
//                                   Icons.circle_rounded,
//                                   color: Colors.white70,
//                                   size: 80,
//                                 ),
//                                 onPressed: () {
//                                   cameraController
//                                       .takePicture()
//                                       .then((XFile? file) {
//                                     if (mounted) {
//                                       print('image done${file!.path}');
//                                       _getCurrentPosition();
//                                       print(
//                                           'Current Location - LNG: ${_currentPosition?.longitude ?? ""}, LAT: ${_currentPosition?.latitude ?? ""}, ADDRESS: ${_currentAddress ?? ""}');
//                                       showDialog(
//                                         context: context,
//                                         builder: (ctx) => AlertDialog(
//                                           title: const Text(
//                                             "لقد تم التقاط الصورة! ",
//                                             style: TextStyle(fontSize: 20),
//                                           ),
//                                           content: const Text(
//                                             " هل تريد الذهاب الى صفحة التأكيد؟",
//                                             style: TextStyle(fontSize: 15),
//                                           ),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(ctx).push(
//                                                     MaterialPageRoute(
//                                                         builder: (context) {
//                                                   return VerificationReport(
//                                                     Lan: _currentPosition!
//                                                         .longitude,
//                                                     Lat: _currentPosition!
//                                                         .longitude,
//                                                     Address:
//                                                         _currentAddress ?? "",
//                                                     image: file,
//                                                   );
//                                                 }));
//                                               },
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.all(14),
//                                                 child: const Text(
//                                                   "نعم",
//                                                   style:
//                                                       TextStyle(fontSize: 20),
//                                                 ),
//                                               ),
//                                             ),
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(ctx).pop();
//                                               },
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.all(14),
//                                                 child: const Text(
//                                                   "لا",
//                                                   style:
//                                                       TextStyle(fontSize: 20),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     }
//                                   });
//                                 },
//                               ))
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     }
//     if (!cameraController.value.isInitialized) {
//       return const CircularProgressIndicator();
//     } else {
//       return Container();
//     }
//   }

//   Widget customAppBar() {
//     return Container(
//       width: double.infinity,
//       height: 80,
//       decoration: const ShapeDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.01, -1.00),
//           end: Alignment(-0.01, 1),
//           colors: [Color(0xFF05AC8C), Color(0xFF12787C)],
//         ),
//         shape: RoundedRectangleBorder(),
//       ),
//       child: Stack(children: [
//         Positioned(
//           right: MediaQuery.of(context).size.width * -0.08,
//           top: MediaQuery.of(context).size.height * 0.04,
//           child: Container(
//             width: 194,
//             height: 122,
//             decoration: ShapeDecoration(
//               color: Colors.white.withOpacity(0.07),
//               shape: const OvalBorder(),
//             ),
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.only(left: 10, right: 10, top: 35),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'بيانات البلاغ',
//                 style: TextStyle(
//                     color: ColorManager.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.arrow_forward_ios_outlined),
//                 color: ColorManager.white,
//               ),
//             ],
//           ),
//         )
//       ]),
//     );
//   }
// }
