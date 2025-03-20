import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/song.dart';
import '../routes.dart';

class MusicListScreen extends StatefulWidget {
  @override
  _MusicListScreenState createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen> {
  final String defaultImage = "https://via.placeholder.com/150";

  final List<Song> songs = [
    Song(title: "Born Again", artist: "LISA, Doja Cat, RAYE", image: "https://th.bing.com/th/id/OIP.2wFtFaLzI4k5TtfIiCaOyQHaHa?rs=1&pid=ImgDetMain"),
    Song(title: "Yours Ever", artist: "cocktail, Q Flure", image: "https://th.bing.com/th/id/OIP.sser6rSI9jXQn3EyvbbovwHaHa?rs=1&pid=ImgDetMain"),
    Song(title: "DAY ONE", artist: "PUN", image: "https://i.ytimg.com/vi/FAtUIozzvEo/maxresdefault.jpg"),
    Song(title: "Like JENNIE", artist: "JENNIE", image: "https://th.bing.com/th?id=OIF.8GE%2f2G8g8jNEDHamnQzQpQ&rs=1&pid=ImgDetMain"),
    Song(title: "Garden Of Eden", artist: "Lady Gaga", image: "https://i.ytimg.com/vi/s1AUBvW1LOI/oar2.jpg?sqp=-oaymwEYCM4FENAFSFqQAgHyq4qpAwcIARUAAIhC&rs=AOn4CLANdtaQHB9qIAgGF8gXVyzsJ8M56g"),
    Song(title: "luther (with sza)", artist: "Kendrick Lamar, SZA", image: "https://th.bing.com/th/id/OIP.Mr5g9VPvv1g9Hnk0UwBZegHaE5?w=235&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
    Song(title: "I Just Wanna Know", artist: "PUN", image: "https://th.bing.com/th/id/OIP.nn3T_0Y7BaWpKR3-11cO6QHaEK?rs=1&pid=ImgDetMain"),
    Song(title: "earthquake", artist: "JISOO", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKm6CVSWh3FjwNZH6uLQpr4CgSDr6aiK0-2A&s"),
    Song(title: "number one girl", artist: "ROSÉ", image: "https://th.bing.com/th/id/OIP.tsjvixO26ZVkhx6-ycs31gHaE8?rs=1&pid=ImgDetMain"),
  ];

  final List<String> categories = ["All", "Pop", "Rock", "Hip-Hop", "Jazz", "Classical", "EDM", "Country", "Blues"];

  bool isShuffled = false;
  List<Song> filteredSongs = [];

  @override
  void initState() {
    super.initState();
    filteredSongs = songs; // เริ่มต้นแสดงทุกเพลง
  }

  void _filterSongs(String query) {
    setState(() {
      filteredSongs = songs.where((song) {
        final titleLower = song.title.toLowerCase();
        final artistLower = song.artist.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower) || artistLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
      body: Column(
        children: [
          _buildHeader(),
          _buildCategoryChips(),
          Expanded(child: _buildSongList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade900, Colors.green.shade700],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          SizedBox(height: 20),
          Text("Play List", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 5),
          Text("${filteredSongs.length} Songs", style: TextStyle(color: Colors.white70)),
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
                  IconButton(
                    icon: Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.musicPlayer);
                    },
                  ),
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
        onChanged: _filterSongs,
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
      itemCount: filteredSongs.length,
      itemBuilder: (context, index) {
        final song = filteredSongs[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              song.image ?? defaultImage,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(song.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(song.artist, style: TextStyle(color: Colors.white70)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.play_circle_fill, color: Colors.green, size: 28),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.musicPlayer);
                },
              ),
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
