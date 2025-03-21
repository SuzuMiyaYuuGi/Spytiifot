import 'package:flutter/material.dart';
import '../routes.dart'; // ✅ Import Routes ที่กำหนดไว้

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // เก็บ state ของ navigation bar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: HomeContent(),

      // **🔽 Bottom Navigation Bar**
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (_selectedIndex == index) return;
          setState(() {
            _selectedIndex = index;
          });

          // ✅ นำทางไปยังหน้าต่างๆ ผ่าน `routes.dart`
          switch (index) {
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
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.playlist_play), label: "Play List"),
          BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: "Upload"),
        ],
      ),
    );
  }
}

// 📌 **หน้าหลักของ Home**
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              title: Text(
                "Good afternoon",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings, size: 28, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
            ),

            // 🔹 Your favorite artist
            Text(
              "Your favorite artist",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildArtistCircle("https://i.scdn.co/image/ab67616d00001e022a038d3bf875d23e4aeaa84e", "Billie Eilish"),
                  _buildArtistCircle("https://i.scdn.co/image/ab67616d0000b273a6ede36b57589893a4a8506b", "Post Malone"),
                  _buildArtistCircle("https://i.scdn.co/image/ab67616d0000b273ba5db46f4b838ef6027e6f96", "Ed Sheeran"),
                  _buildArtistCircle("https://i.scdn.co/image/ab67616d0000b273e2f039481babe23658fc719a", "Linkin Park"),
                  _buildArtistCircle("https://i.scdn.co/image/ab67616d0000b2739d28fd01859073a3ae6ea209", "NewJeans"),
                ],
              ),
            ),

            SizedBox(height: 20),

            // 🔹 Recent Play
            Text(
              "Recent play",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildRecentCard(context, "https://i.scdn.co/image/ab67616100005174c36dd9eb55fb0db4911f25dd", "Bruno Mars", "Grenade"),
                  _buildRecentCard(context, "https://i.scdn.co/image/ab67616d0000b2739d28fd01859073a3ae6ea209", "NewJeans", "Super Shy"),
                  _buildRecentCard(context, "https://i.scdn.co/image/ab67616d0000b273e2f039481babe23658fc719a", "Linkin Park", "New Divine"),
                ],
              ),
            ),

            SizedBox(height: 20),

            // 🔹 Made for you
            Text(
              "Made for you",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),

            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildPlaylistCard(context, "https://i.scdn.co/image/ab67616d0000b2732e05fd2e7fa984c228bdd637", "ขี้หึง", "Silly Fools"),
                _buildPlaylistCard(context, "https://i.scdn.co/image/ab67616d0000b2739d28fd01859073a3ae6ea209", "Super Shy", "NewJeans"),
                _buildPlaylistCard(context, "https://i.scdn.co/image/ab67616100005174c36dd9eb55fb0db4911f25dd", "Grenade", "Bruno Mars"),
                _buildPlaylistCard(context, "https://i.scdn.co/image/ab67616d0000b273e2f039481babe23658fc719a", "New Divine", "Linkin Park"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // **สร้าง Widget สำหรับแสดงศิลปิน**
  Widget _buildArtistCircle(String imageUrl, String name) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey[800],
            child: ClipOval(
              child: Image.network(
                imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(name, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  // **สร้าง Widget สำหรับ Recent Play**
  Widget _buildRecentCard(BuildContext context, String imageUrl, String artist, String song) {
    return GestureDetector(
      onTap: () {
        // กดแล้วไปหน้า MusicPlayerScreen
        Navigator.pushNamed(context, AppRoutes.musicPlayer);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageUrl, height: 100, width: 150, fit: BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(artist, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                child: Text(song, style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // **สร้าง Widget สำหรับ Playlist Card (Made for you)**
  Widget _buildPlaylistCard(BuildContext context, String imageUrl, String title, String artist) {
    return GestureDetector(
      onTap: () {
        // กดแล้วไปหน้า MusicPlayerScreen
        Navigator.pushNamed(context, AppRoutes.musicPlayer);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: Colors.red);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, bottom: 8),
              child: Text(
                artist,
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
