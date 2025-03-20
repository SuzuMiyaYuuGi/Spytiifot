import 'package:flutter/material.dart';

class UploadMusicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Music'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.green,
              child: Icon(Icons.music_note, size: 60, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text('Artist Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            IconButton(
              icon: Icon(Icons.upload, color: Colors.blue),
              onPressed: () {},
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Music Name', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                OptionButton(text: 'Public', icon: Icons.public),
                OptionButton(text: 'Collaboration', icon: Icons.group),
                OptionButton(text: 'Free Download', icon: Icons.shopping_cart),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text('UPLOAD'),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String text;
  final IconData icon;

  OptionButton({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            SizedBox(width: 10),
            Text(text, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
