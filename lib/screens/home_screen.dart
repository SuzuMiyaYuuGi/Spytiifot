import 'package:flutter/material.dart';
import '../routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // รายการหน้าที่ Bottom Navigation Bar จะเปลี่ยนไป
  final List<Widget> _pages = [
    HomeScreen(), // หน้าหลัก
    Placeholder(), // หน้าค้นหา (Search)
    Placeholder(), // หน้า Play List
    Placeholder(), // หน้า Upload Music
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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

      // **อัปเดต Bottom Navigation Bar**
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // นำทางไปยังหน้าต่างๆ ตามลำดับ
          switch (index) {
            case 0:
              Navigator.pushNamed(context, AppRoutes.home);
              break;
            case 1:
              Navigator.pushNamed(context, AppRoutes.musicPlayer);
              break;
            case 2:
              Navigator.pushNamed(context, AppRoutes.musicList);
              break;
            case 3:
              Navigator.pushNamed(context, AppRoutes.uploadMusic);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"), // เปลี่ยนจาก Library เป็น Search
          BottomNavigationBarItem(icon: Icon(Icons.playlist_play), label: "Play List"), // เปลี่ยนจาก Profile เป็น Play List
          BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: "Upload"), // เพิ่มเมนู Upload
        ],
      ),
    );
  }

  Widget _buildCategoryTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

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
