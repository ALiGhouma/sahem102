import 'package:flutter/material.dart';
import 'package:sahem/Features/emergencyContact/componantes/rowCard.dart';

final List icon_name = [
  {
    "icon": "assets/icons/police.svg",
    "iconName": "police",
    "PhoneNumber": "999"
  },
  {"icon": "assets/icons/Help.svg", "iconName": "Help", "PhoneNumber": "111"},
  {
    "icon": "assets/icons/Trafficpolice.svg",
    "iconName": "Traffic",
    "PhoneNumber": "000"
  },
  {
    "icon": "assets/icons/ambulance.svg",
    "iconName": "Ambulance",
    "PhoneNumber": "000"
  },
  {
    "icon": "assets/icons/electricity.svg",
    "iconName": "Electrician",
    "PhoneNumber": "000"
  },
  {
    "icon": "assets/icons/fire.svg",
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
              svgPath: (icon_name[i]["icon"]),
              phoneNumber: icon_name[i]["PhoneNumber"],
              textCard: icon_name[i]["iconName"]);
        },
      ),
    );
  }
}
