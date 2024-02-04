import 'package:flutter/material.dart';
import 'package:sahem/Core/resources/color_manager.dart';
import 'package:sahem/Features/home/presentation/emergency_contact.dart';
import 'package:sahem/Features/home/presentation/home_screen.dart';
import 'package:sahem/Features/home/presentation/reports.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 1;

  final List<Widget> _screens = <Widget>[
    const EmergencyContact(),
    //HomeScreen(userModel: ,),
    //const //Reports(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency, color: ColorManager.white),
            label: 'جهات الطوارئ',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: ColorManager.white),
              label: 'الرئيسية',
              backgroundColor: ColorManager.white),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sticky_note_2_outlined,
              color: ColorManager.white,
            ),
            label: 'البلاغات',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorManager.white,
        unselectedItemColor: ColorManager.white,
        onTap: _onItemTapped,
        backgroundColor: ColorManager.primary,
        selectedFontSize: 20,
      ),
    );
  }
}
