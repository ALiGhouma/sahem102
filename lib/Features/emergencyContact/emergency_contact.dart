// import 'package:flutter/material.dart';
// class EmergencyContact extends StatefulWidget {
//   const EmergencyContact({super.key});

//   @override
//   State<EmergencyContact> createState() => _EmergencyContactState();
// }

// class _EmergencyContactState extends State<EmergencyContact> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text("emergency contact"),),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sahem/Features/emergencyContact/componantes/rowscontnat.dart';

//import 'numbers_Page.dart';

class EmergencyContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "الوصول السريع",
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              "للاستفادة منها في حال الطوارئ",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: rowCard(),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
    );
  }
}
