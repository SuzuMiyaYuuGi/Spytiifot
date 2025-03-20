import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({Key? key}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen>
    with TickerProviderStateMixin {
  double _currentPosition = 15.0; // 15 วินาที
  double _totalDuration = 292.0; // 4 นาที 52 วินาที = 292 วินาที

  bool isShuffled = false;
  bool isMuted = false;
  bool isPlaying = false;
  bool isLiked = false;

  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    // AnimationController สำหรับหมุน Album Art ช้า ๆ (10 วินาทีต่อรอบ)
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// ใช้ Container สำหรับไล่สีพื้นหลัง
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 41, 157, 37), // สีเขียว
              Color.fromARGB(255, 32, 32, 32),
              Color.fromARGB(255, 18, 18, 18),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // เลื่อน Top Bar ลงมาเยอะขึ้น
              const SizedBox(height: 80),
              // แถบด้านบนที่มีปุ่ม Back, "NOW PLAYING" ตรงกลาง และปุ่ม More Options
              _buildTopBar(),
              const SizedBox(height: 30),
              // วงกลมรูปปกเพลง (Album Art) ที่ใช้ NetworkImage และมีการหมุนเมื่อเล่นเพลง
              _buildAlbumArt(),
              const SizedBox(height: 30),
              // ชื่อเพลง + ศิลปิน + ปุ่มหัวใจ (Like)
              _buildSongInfo(),
              const SizedBox(height: 20),
              // Slider แสดงความคืบหน้าของเพลง
              _buildProgressBar(),
              const SizedBox(height: 20),
              // ปุ่มควบคุมเพลง (Shuffle, Previous, Play/Pause, Next, Volume)
              _buildControlButtons(),
              const Spacer(),
              // ปุ่ม LYRICS
              _buildLyricsButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// แถบด้านบน (ปุ่ม Back, "NOW PLAYING" อยู่ตรงกลาง และปุ่ม 3 จุด)
  Widget _buildTopBar() {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          // ปุ่ม Back ด้านซ้าย
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          // ข้อความ "NOW PLAYING" อยู่ตรงกลาง
          const Center(
            child: Text(
              'NOW PLAYING',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // ปุ่มจุด 3 จุด ด้านขวา
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                // TODO: ฟังก์ชันสำหรับเมนูเพิ่มเติม
              },
              icon: const Icon(Icons.more_vert, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// วงกลมรูปปกเพลง (Album Art) ที่โหลดจาก URL และมีการหมุนเมื่อเล่นเพลง
  Widget _buildAlbumArt() {
    return RotationTransition(
      turns: _rotationController,
      child: Container(
        width: 264, // ขนาดเพิ่มขึ้นประมาณ 20% จากเดิม (220 -> 264)
        height: 264,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.green, width: 4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: NetworkImage(
                  'https://i.ytimg.com/vi/hoCew_i0W9M/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCBEs0SNNumpUf2pyv8aMDicpw5gA',
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ชื่อเพลง + ศิลปิน + ปุ่มหัวใจ (Like)
  Widget _buildSongInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ชื่อเพลงและศิลปิน
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ซ่อนไม่หา (Ghost)',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Jeff Satur',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          // ปุ่มหัวใจ (Like) - เมื่อกดจะเปลี่ยนเป็นสีเขียวเต็มดวง
          IconButton(
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.green : Colors.white,
            ),
            iconSize: 28,
          ),
        ],
      ),
    );
  }

  /// Slider แสดงความคืบหน้าของเพลง พร้อมเวลา
  Widget _buildProgressBar() {
    String _formatTime(double seconds) {
      int m = (seconds ~/ 60);
      int s = (seconds % 60).toInt();
      String mm = m.toString().padLeft(1, '0');
      String ss = s.toString().padLeft(2, '0');
      return '$mm:$ss';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.white54,
            min: 0,
            max: _totalDuration,
            value: _currentPosition,
            onChanged: (value) {
              setState(() {
                _currentPosition = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatTime(_currentPosition),
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                _formatTime(_totalDuration),
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ปุ่มควบคุมเพลง (Shuffle, Previous, Play/Pause, Next, Volume)
  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ปุ่ม Shuffle: เปลี่ยนเป็นสีเขียวเมื่อเปิดใช้งาน
        IconButton(
          iconSize: 28,
          icon: Icon(
            Icons.shuffle,
            color: isShuffled ? Colors.green : Colors.white,
          ),
          onPressed: () {
            setState(() {
              isShuffled = !isShuffled;
            });
          },
        ),
        const SizedBox(width: 20),
        // ปุ่ม Previous
        IconButton(
          iconSize: 32,
          icon: const Icon(Icons.skip_previous, color: Colors.white),
          onPressed: () {
            // TODO: previous track
          },
        ),
        const SizedBox(width: 20),
        // ปุ่ม Play/Pause: เมื่อกดจะสลับสถานะและเริ่ม/หยุดหมุน Album Art
        InkWell(
          onTap: () {
            setState(() {
              isPlaying = !isPlaying;
              if (isPlaying) {
                _rotationController.repeat();
              } else {
                _rotationController.stop();
              }
            });
            // TODO: play/pause
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
        const SizedBox(width: 20),
        // ปุ่ม Next
        IconButton(
          iconSize: 32,
          icon: const Icon(Icons.skip_next, color: Colors.white),
          onPressed: () {
            // TODO: next track
          },
        ),
        const SizedBox(width: 20),
        // ปุ่ม Volume
        IconButton(
          iconSize: 28,
          icon: Icon(
            isMuted ? Icons.volume_off : Icons.volume_up,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              isMuted = !isMuted;
            });
          },
        ),
      ],
    );
  }

  /// ปุ่ม LYRICS ด้านล่าง (กดแบบ tap หรือ long press เพื่อแสดง Lyrics Panel)
  Widget _buildLyricsButton() {
    return GestureDetector(
      onTap: _showLyricsSheet,
      onLongPress: _showLyricsSheet,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'LYRICS',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_drop_up, color: Colors.white),
        ],
      ),
    );
  }

  /// ฟังก์ชันสำหรับแสดงแถบเนื้อเพลง (Lyrics) ด้วย Modal Bottom Sheet ที่สามารถลากเลื่อนได้
  void _showLyricsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 42, 42, 42),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // เส้นเล็กด้านบนของ Bottom Sheet
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 129, 129, 129),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Lyrics',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // ตัวอย่างเนื้อเพลง
                      const Text(
                        'Here is the lyrics content...\n'
                        'Line 1 of the lyrics...\n'
                        'Line 2 of the lyrics...\n'
                        'Line 3 of the lyrics...\n'
                        'More lyrics...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 129, 129, 129),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
