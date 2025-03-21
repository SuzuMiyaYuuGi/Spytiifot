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
                  _buildRecentCard(context, "data:image/jpeg;base64,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", "ซ่อน (ไม่) หา ", "Jeff Satur"),
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
                _buildPlaylistCard(context, "data:image/jpeg;base64,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", "ซ่อน (ไม่) หา ", "Jeff Satur , Pluviophile"),
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
