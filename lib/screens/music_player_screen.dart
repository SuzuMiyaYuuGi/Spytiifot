import 'package:flutter/material.dart';
import '../routes.dart';

class MusicPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.musicList);
          },
          child: Text("Go to Play List"),
        ),
      ),
    );
  }
}
