import 'package:flutter/material.dart';
import '../routes.dart'; // <-- ปรับตามเส้นทางไฟล์ routes.dart ของคุณ

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // เก็บ state ของ BottomNavigationBar

  @override
  Widget build(BuildContext context) {
    // ความสูง BottomNavigationBar ปกติ ~56 px
    final bottomNavBarHeight = kBottomNavigationBarHeight;
    // ระยะปลอดภัย SafeArea ด้านล่าง (บางเครื่องมี Notch / Gesture Navigation)
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    // รวมกัน + เผื่ออีกนิด (20 px)
    final totalBottomPadding = bottomNavBarHeight + bottomSafeArea + 20;

    return Scaffold(
      // AppBar ใน Scaffold
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Good afternoon",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: 28),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,

      // เนื้อหา (body)
      body: SingleChildScrollView(
        child: Padding(
          // ใช้ totalBottomPadding ที่คำนวณได้
          padding: EdgeInsets.only(left: 16, right: 16, bottom: totalBottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Your favorite artist
              const Text(
                "Your favorite artist",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),

              // แถบศิลปินแนวนอน
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
              const SizedBox(height: 20),

              // 🔹 Recent play
              const Text(
                "Recent play",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),

              // Recent play แนวนอน
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildRecentCard(
                      context,
                      "https://i.kfs.io/album/global/266027464,2v1/fit/500x500.jpg",
                      "ซ่อน (ไม่) หา",
                      "Jeff Satur",
                    ),
                    _buildRecentCard(
                      context,
                      "https://i.scdn.co/image/ab67616100005174c36dd9eb55fb0db4911f25dd",
                      "Bruno Mars",
                      "Grenade",
                    ),
                    _buildRecentCard(
                      context,
                      "https://i.scdn.co/image/ab67616d0000b2739d28fd01859073a3ae6ea209",
                      "NewJeans",
                      "Super Shy",
                    ),
                    _buildRecentCard(
                      context,
                      "https://i.scdn.co/image/ab67616d0000b273e2f039481babe23658fc719a",
                      "Linkin Park",
                      "New Divine",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Made for you
              const Text(
                "Made for you",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),

              // ใช้ LayoutBuilder เพื่อคำนวณ crossAxisCount อัตโนมัติ
              LayoutBuilder(
                builder: (context, constraints) {
                  // กำหนดความกว้าง card ~160px
                  int crossAxisCount = (constraints.maxWidth / 160).floor();
                  if (crossAxisCount < 2) crossAxisCount = 2; // อย่างน้อย 2 คอลัมน์

                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      _buildPlaylistCard(
                        context,
                        "https://i.kfs.io/album/global/266027464,2v1/fit/500x500.jpg",
                        "ซ่อน (ไม่) หา",
                        "Jeff Satur , Pluviophile",
                      ),
                      _buildPlaylistCard(
                        context,
                        "https://i.scdn.co/image/ab67616d0000b2739d28fd01859073a3ae6ea209",
                        "Super Shy",
                        "NewJeans",
                      ),
                      _buildPlaylistCard(
                        context,
                        "https://i.scdn.co/image/ab67616100005174c36dd9eb55fb0db4911f25dd",
                        "Grenade",
                        "Bruno Mars",
                      ),
                      _buildPlaylistCard(
                        context,
                        "https://i.scdn.co/image/ab67616d0000b273e2f039481babe23658fc719a",
                        "New Divine",
                        "Linkin Park",
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white70,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          // ตัวอย่างการนำทาง
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.playlist_play), label: "Play List"),
          BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: "Upload"),
        ],
      ),
    );
  }

  /// วาดศิลปินแบบวงกลม
  Widget _buildArtistCircle(String imageUrl, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
          const SizedBox(height: 5),
          SizedBox(
            width: 70,
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /// Card สำหรับ Recent Play (แนวนอน)
  Widget _buildRecentCard(BuildContext context, String imageUrl, String artist, String song) {
    // กำหนดความกว้าง ~35% ของหน้าจอ แต่ min=130, max=180
    final size = MediaQuery.of(context).size;
    double cardWidth = size.width * 0.35;
    if (cardWidth < 130) cardWidth = 130;
    if (cardWidth > 180) cardWidth = 180;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.musicPlayer);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: cardWidth,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // รูป
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  imageUrl,
                  width: cardWidth,
                  height: cardWidth,
                  fit: BoxFit.cover,
                ),
              ),
              // ชื่อศิลปิน
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  artist,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // ชื่อเพลง
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Text(
                  song,
                  style: const TextStyle(color: Colors.white70),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Card สำหรับ Playlist (Made for you)
  Widget _buildPlaylistCard(BuildContext context, String imageUrl, String title, String artist) {
    return GestureDetector(
      onTap: () {
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
            // รูป
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // ชื่อ Playlist
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // ศิลปิน
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Text(
                artist,
                style: const TextStyle(color: Colors.white70),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
