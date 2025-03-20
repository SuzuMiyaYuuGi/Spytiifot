import 'package:flutter/material.dart';
import '../routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  
  BottomNavBar({required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, AppRoutes.home);
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.search);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.musicList);
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.uploadMusic);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.greenAccent,
      unselectedItemColor: Colors.white70,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => _onItemTapped(context, index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 28),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, size: 28),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music, size: 28),
          label: "Play List",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.upload_file, size: 28),
          label: "Upload",
        ),
      ],
    );
  }
}
