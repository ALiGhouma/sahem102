import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahem/Core/resources/color_manager.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    Key? key,
    required this.svgPath,
    required this.textCard,
    required this.phoneNumber,
  }) : super(key: key);

  final String svgPath;
  final String textCard;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Column(
          children: [
            const SizedBox(height: 5),
            SvgPicture.asset(
              svgPath,
              height: 80,
              width: 80,
            ),
            const SizedBox(height: 3),
            Text(
              textCard,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0XFF05AC8C),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    phoneNumber,
                    style: TextStyle(fontSize: 30, color: ColorManager.white),
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    Icons.call,
                    size: 40,
                    color: ColorManager.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
