import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/song.dart';
import '../routes.dart';

class MusicListScreen extends StatefulWidget {
  @override
  _MusicListScreenState createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen> {
  final String defaultImage = "https://via.placeholder.com/150"; // รูปภาพเริ่มต้นจากเว็บ

  final List<Song> songs = [
    Song(title: "Born Again", artist: "LISA, Doja Cat, RAYE", image: "https://example.com/born_again.jpg"),
    Song(title: "Yours Ever", artist: "cocktail, Q Flure", image: "https://example.com/yours_ever.jpg"),
    Song(title: "DAY ONE", artist: "PUN", image: "https://example.com/day_one.jpg"),
    Song(title: "Like JENNIE", artist: "JENNIE", image: "https://example.com/like_jennie.jpg"),
    Song(title: "Garden Of Eden", artist: "Lady Gaga", image: "https://example.com/garden_of_eden.jpg"),
    Song(title: "luther (with sza)", artist: "Kendrick Lamar, SZA", image: "https://example.com/luther.jpg"),
    Song(title: "I Just Wanna Know", artist: "PUN", image: "https://example.com/just_wanna_know.jpg"),
    Song(title: "earthquake", artist: "JISOO", image: "https://example.com/earthquake.jpg"),
    Song(title: "number one girl", artist: "ROSÉ", image: "https://example.com/number_one_girl.jpg"),
  ];

  final List<String> categories = [
    "All", "Pop", "Rock", "Hip-Hop", "Jazz", "Classical", "EDM", "Country", "Blues", "Folk", "Reggae"
  ];

  bool isShuffled = false; // State สำหรับปุ่ม Shuffle

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavBar(),
      body: Column(
        children: [
          _buildHeader(screenWidth),
          _buildCategoryChips(),
          Expanded(child: _buildSongList()),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(16),
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.green[900],
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          _buildSearchBar(),
          SizedBox(height: 20),
          Text("Play List", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 5),
          Text("1,324,984 Songs", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.download, color: Colors.white, size: 30),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.shuffle, color: isShuffled ? Colors.yellow : Colors.white, size: 30),
                    onPressed: () {
                      setState(() {
                        isShuffled = !isShuffled;
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.white70),
          hintText: "Search in play list",
          hintStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Chip(
              label: Text(category, style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green[800],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSongList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              song.image ?? defaultImage, // ใช้รูปจาก URL หรือรูปเริ่มต้น
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.music_note, size: 50, color: Colors.grey);
              },
            ),
          ),
          title: Text(song.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(song.artist, style: TextStyle(color: Colors.white70)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.green, size: 24),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${song.title} added to favorites!"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.white, size: 24),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.musicDetail);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
