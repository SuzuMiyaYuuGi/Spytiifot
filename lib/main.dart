import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'uploadmusicscreen.dart';

void main() {
  runApp(SpytifyApp());
}

class SpytifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: UploadMusicScreen(),
    );
  }
}
