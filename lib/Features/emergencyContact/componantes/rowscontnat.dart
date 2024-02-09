import 'package:flutter/material.dart';
import 'package:sahem/Features/emergencyContact/componantes/rowCard.dart';
import 'package:flutter/material.dart';
import 'package:sahem/Core/resources/color_manager.dart';

final List icon_name = [
  {
    "icon": "assets/icons/police.png", // Changed to PNG
    "iconName": "police",
    "PhoneNumber": "999"
  },
  {
    "icon": "assets/icons/Help.png",
    "iconName": "Help",
    "PhoneNumber": "111"
  }, // Changed to PNG
  {
    "icon": "assets/icons/Trafficpolice.png", // Changed to PNG
    "iconName": "Traffic",
    "PhoneNumber": "000"
  },
  {
    "icon": "assets/icons/ambulance.png", // Changed to PNG
    "iconName": "Ambulance",
    "PhoneNumber": "000"
  },
  {
    "icon": "assets/icons/electricity.png", // Changed to PNG
    "iconName": "Electrician",
    "PhoneNumber": "000"
  },
  {
    "icon": "assets/icons/fire.png", // Changed to PNG
    "iconName": "Firefighert",
    "PhoneNumber": "000"
  },
];

class rowCard extends StatelessWidget {
  const rowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: icon_name.length,
        itemBuilder: (context, i) {
          return CardButton(
              imagePath: (icon_name[i]["icon"]), // Changed to imagePath
              phoneNumber: icon_name[i]["PhoneNumber"],
              textCard: icon_name[i]["iconName"]);
        },
      ),
    );
  }
}
