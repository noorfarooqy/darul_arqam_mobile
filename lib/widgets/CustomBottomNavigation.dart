import 'package:flutter/material.dart';


class BuildCustomBottomNavigationWidget extends StatelessWidget {
  BuildCustomBottomNavigationWidget({this.currentIndex});
  final currentIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index){
        if(index == 0){
          Navigator.pushReplacementNamed(context, '/homepage');
        }
        else if(index == 1){
          Navigator.pushReplacementNamed(context, '/duruuspage');
        }
        else if(index == 2){
          Navigator.pushReplacementNamed(context, '/buugaagScreen');
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeIcon: Icon(
            Icons.home,
            color: Colors.blue,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_filled),
          title: Text('Duruus'),
          activeIcon: Icon(
            Icons.play_circle_filled,
            color: Colors.blue,
          ),
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text('Buugaagta'),
          activeIcon: Icon(
            Icons.book,
            color: Colors.blue,
          ),
        )
      ],
    );
  }
}

