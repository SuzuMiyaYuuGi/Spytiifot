import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/music_list_screen.dart';
import 'screens/music_player_screen.dart';
import 'screens/music_detail_screen.dart';
import 'screens/upload_music_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String musicList = '/music-list';
  static const String musicPlayer = '/music-player';
  static const String musicDetail = '/music-detail';
  static const String uploadMusic = '/upload-music';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => HomeScreen(),
      musicList: (context) => MusicListScreen(),
      musicPlayer: (context) => MusicPlayerScreen(),
      musicDetail: (context) => MusicDetailScreen(),
      uploadMusic: (context) => UploadMusicScreen(),
    };
  }
}
