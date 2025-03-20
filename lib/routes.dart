import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/music_list_screen.dart';
import 'screens/music_detail_screen.dart';
import 'screens/upload_music_screen.dart';
import 'screens/search_screen.dart';
import 'screens/music_player_screen.dart';  // ✅ ต้อง Import ไฟล์นี้ด้วย

class AppRoutes {
  static const String home = '/';
  static const String musicList = '/music-list';
  static const String musicDetail = '/music-detail';
  static const String uploadMusic = '/upload-music';
  static const String search = '/search';
  static const String musicPlayer = '/music-player';  // ✅ แก้ชื่อให้สอดคล้อง

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomeScreen(),
      musicList: (context) => MusicListScreen(),
      musicDetail: (context) => MusicDetailScreen(),
      uploadMusic: (context) => UploadMusicScreen(),
      search: (context) => SearchScreen(),
      musicPlayer: (context) => MusicPlayerScreen(), // ✅ เพิ่มเส้นทางให้ musicPlayer
    };
  }
}
