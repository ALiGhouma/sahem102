// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:sahem/Core/utils/space_adder.dart';

// class CurrentLocation extends StatefulWidget {
//   const CurrentLocation({super.key});

//   @override
//   State<CurrentLocation> createState() => _CurrentLocationState();
// }

// class _CurrentLocationState extends State<CurrentLocation> {
//   Position? _currentPosition;
//   String? _currentAddress;
//   StreamSubscription<Position>? positionStream;

//   @override
//   void initState() {
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
//     // TODO: implement dispose
//     super.dispose();
//     positionStream?.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future<bool> _handleLocationPermission() async {
//       bool serviceEnabled;
//       LocationPermission permission;

//       serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text(
//                 'Location services are disabled. Please enable the services')));
//         return false;
//       }
//       permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Location permissions are denied')));
//           return false;
//         }
//       }
//       if (permission == LocationPermission.deniedForever) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text(
//                 'Location permissions are permanently denied, we cannot request permissions.')));
//         return false;
//       }
//       return true;
//     }

//     return Column(
//       children: [
//         TextButton(
//           onPressed: () {
//             _getCurrentPosition();
//             print(
//                 'Current Location - LNG: ${_currentPosition?.longitude ?? ""}, LAT: ${_currentPosition?.latitude ?? ""}, ADDRESS: ${_currentAddress ?? ""}');
//           },
//           child: Column(
//             children: [
//               Text("تحديد موقعك"),
//               addVerticalSpace(50),
//               if (_currentAddress != null)
//                 Text("Current Address: $_currentAddress"),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
