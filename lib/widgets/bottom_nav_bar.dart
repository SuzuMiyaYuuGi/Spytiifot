import 'package:flutter/material.dart';
import '../routes.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRoutes.home);
            break;
          case 1:
            Navigator.pushNamed(context, AppRoutes.musicList);
            break;
          case 2:
            Navigator.pushNamed(context, AppRoutes.musicPlayer);
            break;
          case 3:
            Navigator.pushNamed(context, AppRoutes.uploadMusic);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.library_music), label: "Play List"),
        BottomNavigationBarItem(icon: Icon(Icons.upload), label: "Upload"),
      ],
    );
  }
}
