import 'package:flutter/material.dart';
import '../routes.dart';

class MusicDetailScreen extends StatefulWidget {
  const MusicDetailScreen({Key? key}) : super(key: key);

  @override
  State<MusicDetailScreen> createState() => _MusicDetailScreenState();
}

class _MusicDetailScreenState extends State<MusicDetailScreen> {
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      // ลบ AppBar เพื่อให้หน้าจอเต็มที่
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ส่วน Cover Image พร้อมตกแต่งมุมล่างโค้งมน
            Stack(
              children: [
                SizedBox(
                  height: size.height * 0.45,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    child: Image.network(
                      'https://i.kfs.io/album/global/266027464,2v1/fit/500x500.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient overlay เพื่อความคมชัดของข้อความ
                Container(
                  height: size.height * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                // ไอคอนลูกศรย้อนกลับ (←) สีขาวที่มุมซ้ายบน
                Positioned(
                  top: 40,
                  left: 16,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                // ข้อมูลเพลงและปุ่มต่างๆ วางด้านล่างของ Cover Image
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ซ่อน (ไม่) หา | Ghost',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // รูปโปรไฟล์วงกลม + ชื่อศิลปิน
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkmr5rQsg9XdW3eOt-AIt27fi4MOk7ziSkkg&s',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Jeff Satur',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          // ปุ่ม Follow และปุ่ม Play
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isFollowed = !isFollowed;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        isFollowed
                                            ? 'Followed Jeff Satur!'
                                            : 'Unfollowed Jeff Satur!',
                                      ),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      isFollowed ? Colors.grey : Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(isFollowed ? 'Following' : 'Follow'),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Playing...'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // ส่วนเนื้อหารายละเอียดเพิ่มเติม
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description :",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sometimes relationships are like a game of hide and seek. "
                    "But this time no matter how well you hide, I'll stop seeking, "
                    "because I've found just a ghost of you.\n"
                    "Premiered Jan 19, 2024",
                    style: TextStyle(height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Music Credits :",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Produced by BILbilly01\n"
                    "Written by Jeff Satur\n"
                    "Lyric by Jeff Satur / Pluophile\n"
                    "Composed by Jeff Satur\n"
                    "Arranged by BILbilly01\n"
                    "All Instrument Recorded by BILbilly01\n"
                    "Vocals Edited by Henry Watkins\n"
                    "Mixed and Mastered by Henry Watkins at Studio 28\n",
                    style: TextStyle(height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Music Video :",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Directed by Prach Rojanasinwilai\n",
                    style: TextStyle(height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Other Credits :",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Jeff's Make-up Artist : @makeupbyRasika\n"
                    "Jeff's Hair Stylist : Winchattra\n",
                    style: TextStyle(height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
