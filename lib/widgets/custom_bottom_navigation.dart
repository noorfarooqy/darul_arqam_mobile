import 'package:flutter/material.dart';

class BuildCustomBottomNavigationWidget extends StatelessWidget {
  BuildCustomBottomNavigationWidget({this.currentIndex});
  final currentIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/homepage');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/duruuspage');
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, '/buugaagScreen');
        } else if (index == 3) {
          Navigator.pushReplacementNamed(context, '/sermonScreen');
        } else if (index == 4) {
          Navigator.pushReplacementNamed(context, '/settingsScreen');
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          label: 'Home',
          activeIcon: Icon(
            Icons.home,
            color: Colors.blue,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.play_circle_filled,
            color: Colors.black,
          ),
          label: 'Duruus',
          activeIcon: Icon(
            Icons.play_circle_filled,
            color: Colors.blue,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.book,
            color: Colors.black,
          ),
          label: 'Buugaagta',
          activeIcon: Icon(
            Icons.book,
            color: Colors.blue,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.library_music,
            color: Colors.black,
          ),
          label: 'Muxaadaro',
          activeIcon: Icon(
            Icons.library_music,
            color: Colors.blue,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.black,
          ),
          label: 'Settings',
          activeIcon: Icon(
            Icons.settings,
            color: Colors.blue,
          ),
        )
      ],
    );
  }
}
