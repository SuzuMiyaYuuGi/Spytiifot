import 'package:flutter/material.dart';
import '../routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // สีพื้นหลัง Spotify Theme
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Spytifot",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 28),
            onPressed: () {
              // เพิ่มฟังก์ชันค้นหาเพลง
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Evening",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),

            // **หมวดหมู่ที่เพิ่มเข้ามา**
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategoryTitle("Your Playlists"),
                    _buildPlaylistGrid(context, [
                      ["Liked Songs", Icons.favorite, AppRoutes.musicList],
                      ["Top Hits", Icons.trending_up, AppRoutes.musicList],
                      ["Chill Vibes", Icons.spa, AppRoutes.musicList],
                      ["Workout", Icons.fitness_center, AppRoutes.musicList],
                    ]),

                    _buildCategoryTitle("Made For You"),
                    _buildPlaylistGrid(context, [
                      ["Discover Weekly", Icons.explore, AppRoutes.musicList],
                      ["Release Radar", Icons.new_releases, AppRoutes.musicList],
                      ["Daily Mix 1", Icons.queue_music, AppRoutes.musicList],
                      ["Daily Mix 2", Icons.library_music, AppRoutes.musicList],
                    ]),

                    _buildCategoryTitle("Genres & Moods"),
                    _buildPlaylistGrid(context, [
                      ["Pop", Icons.music_note, AppRoutes.musicList],
                      ["Hip-Hop", Icons.headset, AppRoutes.musicList],
                      ["Jazz", Icons.surround_sound, AppRoutes.musicList],
                      ["Classical", Icons.album, AppRoutes.musicList],
                      ["Rock", Icons.electric_bolt_sharp, AppRoutes.musicList],
                      ["Lo-Fi", Icons.nightlight_round, AppRoutes.musicList],
                    ]),

                    _buildCategoryTitle("Trending Now"),
                    _buildPlaylistGrid(context, [
                      ["Hot 100", Icons.local_fire_department, AppRoutes.musicList],
                      ["Viral Hits", Icons.public, AppRoutes.musicList],
                      ["Global Top 50", Icons.trending_up, AppRoutes.musicList],
                      ["Indie Radar", Icons.blur_on, AppRoutes.musicList],
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // **Bottom Navigation Bar แบบ Spotify**
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: "Library"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // **สร้างหัวข้อหมวดหมู่**
  Widget _buildCategoryTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  // **สร้าง GridView สำหรับ Playlist**
  Widget _buildPlaylistGrid(BuildContext context, List<List<dynamic>> playlists) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: playlists.map((playlist) {
        return _buildPlaylistCard(context, playlist[0], playlist[1], playlist[2]);
      }).toList(),
    );
  }

  // **สร้าง Playlist Card**
  Widget _buildPlaylistCard(BuildContext context, String title, IconData icon, String routeName) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.greenAccent),
            SizedBox(width: 10),
            Expanded(
              child: Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
