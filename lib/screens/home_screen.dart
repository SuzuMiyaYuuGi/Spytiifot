import 'package:flutter/material.dart';
import '../routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home - Spytifot")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Navigation Menu",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // ปุ่มไปยังหน้า Play List
            _buildNavigationButton(context, "Go to Play List", AppRoutes.musicList),

            // ปุ่มไปยังหน้า Music Player
            _buildNavigationButton(context, "Go to Music Player", AppRoutes.musicPlayer),

            // ปุ่มไปยังหน้า Music Detail
            _buildNavigationButton(context, "Go to Music Detail", AppRoutes.musicDetail),

            // ปุ่มไปยังหน้า Upload Music
            _buildNavigationButton(context, "Go to Upload Music", AppRoutes.uploadMusic),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String title, String routeName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          textStyle: TextStyle(fontSize: 16),
        ),
        onPressed: () => Navigator.pushNamed(context, routeName),
        child: Text(title),
      ),
    );
  }
}
