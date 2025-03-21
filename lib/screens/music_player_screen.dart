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
      // กำหนดแหล่งเสียงให้กับ AudioPlayer
      await _audioPlayer.setSource(AssetSource("audio/music.mp3"));
      // ตั้งค่าเสียงให้เป็น 100% หลังโหลดไฟล์เสียง
      await _audioPlayer.setVolume(1.0);
      print("🎵 Audio loaded and volume set to 1.0");
    } catch (e) {
      print("🚨 Error loading audio: $e");
    }

    _audioPlayer.onDurationChanged.listen((Duration d) {
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

  /// ฟังก์ชันสำหรับโหลดเนื้อเพลงจากไฟล์ใน assets
  Future<void> _showLyrics(BuildContext context) async {
    String lyrics;
    try {
      // อ่านไฟล์ lyrics จาก assets
      lyrics = await rootBundle.loadString('assets/lyrics/music_lyrics.txt');
    } catch (e) {
      lyrics = 'ไม่สามารถโหลดเนื้อเพลงได้\n$e';
    }

    // แสดง Popup (Dialog) พร้อมเนื้อเพลง
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Lyrics'),
        content: SingleChildScrollView(
          child: Text(lyrics),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(height: 80),
              _buildTopBar(),
              const SizedBox(height: 30),
              _buildAlbumArt(),
              const SizedBox(height: 30),
              _buildProgressBar(),
              const SizedBox(height: 20),
              _buildControlButtons(),
              const SizedBox(height: 20),
              _buildVolumeControl(),
              const Spacer(),
              _buildLyricsButton(), // ปุ่มกดดูเนื้อเพลง
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
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
        ],
      ),
    );
  }

  Widget _buildAlbumArt() {
    return RotationTransition(
      turns: _rotationController,
      child: Container(
        width: 264,
        height: 264,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.green, width: 4),
        ),
        child: ClipOval(
          child: Image.network(
            'https://i.ytimg.com/vi/qguo-j5PxBE/hqdefault.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
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
            Text(_formatTime(_currentPosition), style: const TextStyle(color: Colors.white)),
            Text(_formatTime(_totalDuration), style: const TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }

  String _formatTime(double seconds) {
    int minutes = (seconds ~/ 60);
    int sec = (seconds % 60).toInt();
    return '${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous, color: Colors.white),
          onPressed: () {},
        ),
        InkWell(
          onTap: () async {
            if (isPlaying) {
              await _audioPlayer.pause();
              _rotationController.stop();
            } else {
              // ถ้าเพลงยังไม่เคยเล่น ให้เรียก play() เพื่อเริ่มเล่นเพลง
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
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 50,
            color: Colors.white,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.skip_next, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildVolumeControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ปุ่ม Mute/Unmute
        IconButton(
          icon: Icon(
            isMuted ? Icons.volume_off : Icons.volume_up,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              isMuted = !isMuted;
              // ถ้า mute ให้ตั้งค่าเสียงเป็น 0, ถ้า unmute ให้ตั้งเป็น 1.0 (100%)
              _volume = isMuted ? 0.0 : 1.0;
              _audioPlayer.setVolume(_volume);
              VolumeController().setVolume(_volume);
            });
          },
        ),
        // Slider ปรับเสียงจากแอป
        Slider(
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
      ],
    );
  }

  /// ปุ่มสำหรับแสดงเนื้อเพลง
  Widget _buildLyricsButton() {
    // ใช้ GestureDetector, InkWell, หรือ InkResponse ก็ได้
    return InkWell(
      onTap: () => _showLyrics(context),
      child: const Text(
        'LYRICS',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
