import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // สำหรับ rootBundle.loadString
import 'package:audioplayers/audioplayers.dart';
import 'package:volume_controller/volume_controller.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({Key? key}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen>
    with TickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  bool isMuted = false;
  bool hasStarted = false; // ตรวจสอบว่าเพลงเริ่มเล่นแล้วหรือยัง
  double _currentPosition = 0.0;
  double _totalDuration = 1.0;
  double _volume = 1.0; // เริ่มต้นที่ 100%

  late AnimationController _rotationController;

  // สำหรับไอคอนหัวใจ (ถูกใจ)
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _audioPlayer = AudioPlayer();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _setupAudioPlayer();
    _setupVolumeController();
  }

  void _setupAudioPlayer() async {
    try {
      // ตั้งค่า PlayerMode และ ReleaseMode เพื่อช่วยอ่าน Duration ให้ถูกต้อง
      await _audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
      await _audioPlayer.setReleaseMode(ReleaseMode.stop);

      // กำหนดแหล่งเสียงให้กับ AudioPlayer
      await _audioPlayer.setSource(AssetSource("audio/music.mp3"));
      // ตั้งค่าเสียงให้เป็น 100% หลังโหลดไฟล์เสียง
      await _audioPlayer.setVolume(1.0);
      print("🎵 Audio loaded and volume set to 1.0");
    } catch (e) {
      print("🚨 Error loading audio: $e");
      return;
    }

    // สร้าง Completer เพื่อรอให้ onDurationChanged ส่งค่าที่ถูกต้อง (มากกว่า 1 วินาที)
    Completer<void> durationCompleter = Completer<void>();
    _audioPlayer.onDurationChanged.listen((Duration d) {
      // ถ้าค่า Duration ที่ได้มากกว่า 1 วินาที ให้ถือว่าได้ข้อมูลที่ถูกต้อง
      if (d.inSeconds > 1 && !durationCompleter.isCompleted) {
        durationCompleter.complete();
      }
      setState(() {
        _totalDuration = d.inSeconds.toDouble();
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _currentPosition = p.inSeconds.toDouble();
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        _rotationController.stop();
        hasStarted = false; // รีเซ็ตสถานะเมื่อเล่นจบ
      });
    });

    // รอให้ได้ Duration ที่ถูกต้อง โดยใช้ timeout ในกรณีที่ไม่มีการอัปเดต
    try {
      await durationCompleter.future.timeout(const Duration(seconds: 5));
    } catch (e) {
      print("🚨 Timeout waiting for duration: $e");
    }

    // หลังจากที่ได้ Duration ที่ถูกต้องแล้ว ให้เริ่มเล่นเพลง
    try {
      await _audioPlayer.play(AssetSource("audio/music.mp3"));
      setState(() {
        isPlaying = true;
        hasStarted = true;
      });
      _rotationController.repeat();
      print("🎵 Audio started playing");
    } catch (e) {
      print("🚨 Error playing audio: $e");
    }
  }

  void _setupVolumeController() {
    // ดึงระดับเสียงปัจจุบันจากระบบ
    VolumeController().getVolume().then((volume) {
      setState(() {
        _volume = volume;
        isMuted = _volume == 0.0;
      });
    });

    // ตั้งค่า Listener ให้เสียงเปลี่ยนตามปุ่มของโทรศัพท์ (ถ้ามี)
    VolumeController().listener((volume) {
      setState(() {
        _volume = volume;
        isMuted = _volume == 0.0;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _rotationController.dispose();
    VolumeController().removeListener();
    super.dispose();
  }

  /// ฟังก์ชันสำหรับโหลดเนื้อเพลงจากไฟล์ใน assets และแสดงเป็น Bottom Sheet ที่สามารถลากขึ้นลงได้
  Future<void> _showLyrics(BuildContext context) async {
    String lyrics;
    try {
      // อ่านไฟล์ lyrics จาก assets
      lyrics = await rootBundle.loadString('assets/lyrics/music_lyrics.txt');
    } catch (e) {
      lyrics = 'ไม่สามารถโหลดเนื้อเพลงได้\n$e';
    }

    // แสดง Bottom Sheet ที่ลากขึ้นลงได้ (DraggableScrollableSheet)
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ให้สามารถขยายเต็มจอได้
      backgroundColor: Colors.transparent, // พื้นหลังโปร่งใส
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5, // เริ่มต้นครึ่งจอ
          minChildSize: 0.3,     // เล็กสุด 30% ของจอ
          maxChildSize: 0.9,     // ใหญ่สุด 90% ของจอ
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                child: Text(
                  lyrics,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatTime(double seconds) {
    final minutes = seconds ~/ 60;
    final sec = (seconds % 60).toInt();
    return '${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // พื้นหลังทำเป็น Gradient ไล่สีเขียวไปดำ
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF299D25),
              Color(0xFF202020),
              Color(0xFF121212),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar
              _buildTopBar(),
              const SizedBox(height: 20),
              // ภาพอัลบั้มแบบหมุน
              _buildAlbumArt(),
              const SizedBox(height: 20),
              // ชื่อเพลง + ศิลปิน + ไอคอนหัวใจ
              _buildSongInfo(),
              const SizedBox(height: 10),
              // แถบเลื่อนเวลาเพลง + เวลา
              _buildProgressBar(),
              const SizedBox(height: 10),
              // ปุ่มควบคุมเพลง (Previous / Play-Pause / Next)
              _buildControlButtons(),
              const SizedBox(height: 20),
              // ควบคุมเสียง
              _buildVolumeControl(),
              const Spacer(),
              // ปุ่ม Lyrics (เมื่อกดจะเลื่อนขึ้นเป็น Bottom Sheet)
              _buildLyricsButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          // ปุ่มย้อนกลับ
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'NOW PLAYING',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // ปุ่มเมนู (จุดสามจุด)
          IconButton(
            onPressed: () {
              // TODO: ใส่ฟังก์ชันที่ต้องการ
            },
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumArt() {
    return RotationTransition(
      turns: _rotationController,
      child: Container(
        width: 240,
        height: 240,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white70, width: 4),
        ),
        child: ClipOval(
          child: Image.network(
            // เปลี่ยนเป็นรูปภาพที่ต้องการ
            'https://i.ytimg.com/vi/qguo-j5PxBE/hqdefault.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSongInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ข้อมูลเพลง (ชื่อเพลง + ศิลปิน) ชิดซ้าย
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ชื่อเพลง
                Text(
                  'ซ่อน(ไม่)หา',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // ศิลปิน
                const Text(
                  'Jeff Satur',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // ไอคอนหัวใจ (กดถูกใจ) ชิดขวา
          GestureDetector(
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.greenAccent : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.white54,
            min: 0,
            max: _totalDuration,
            value: _currentPosition.clamp(0, _totalDuration),
            onChanged: (value) {
              _audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatTime(_currentPosition),
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                _formatTime(_totalDuration),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous, color: Colors.white),
          onPressed: () {
            // TODO: ใส่ฟังก์ชันย้อนกลับเพลง
          },
        ),
        InkWell(
          onTap: () async {
            if (isPlaying) {
              await _audioPlayer.pause();
              _rotationController.stop();
            } else {
              if (!hasStarted) {
                await _audioPlayer.play(AssetSource("audio/music.mp3"));
                hasStarted = true;
              } else {
                await _audioPlayer.resume();
              }
              _rotationController.repeat();
            }
            setState(() {
              isPlaying = !isPlaying;
            });
          },
          child: Icon(
            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
            size: 60,
            color: Colors.white,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.skip_next, color: Colors.white),
          onPressed: () {
            // TODO: ใส่ฟังก์ชันข้ามไปเพลงถัดไป
          },
        ),
      ],
    );
  }

  Widget _buildVolumeControl() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              isMuted ? Icons.volume_off : Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isMuted = !isMuted;
                _volume = isMuted ? 0.0 : 1.0;
                _audioPlayer.setVolume(_volume);
                VolumeController().setVolume(_volume);
              });
            },
          ),
          Expanded(
            child: Slider(
              activeColor: Colors.white,
              inactiveColor: Colors.white54,
              min: 0,
              max: 1,
              value: _volume,
              onChanged: (value) {
                setState(() {
                  _volume = value;
                  isMuted = _volume == 0.0;
                  _audioPlayer.setVolume(value);
                  VolumeController().setVolume(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLyricsButton() {
    return GestureDetector(
      onTap: () => _showLyrics(context),
      child: const Text(
        'LYRICS',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
