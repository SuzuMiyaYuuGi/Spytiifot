import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/music_list_screen.dart';
import 'screens/music_detail_screen.dart';
import 'screens/upload_music_screen.dart';
import 'screens/search_screen.dart'; // เพิ่มไฟล์หน้าค้นหา

class AppRoutes {
  static const String home = '/';
  static const String musicList = '/music-list';
  static const String musicDetail = '/music-detail';
  static const String uploadMusic = '/upload-music';
  static const String search = '/search'; // เพิ่ม route ค้นหา

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomeScreen(),
      musicList: (context) => MusicListScreen(),
      musicDetail: (context) => MusicDetailScreen(),
      uploadMusic: (context) => UploadMusicScreen(),
      search: (context) => SearchScreen(), // เพิ่มเส้นทางให้ Search
    };
  }
}
