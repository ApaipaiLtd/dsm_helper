import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerProvider with ChangeNotifier {
  AudioPlayer _player;
  String _url;
  String _name;
  AudioPlayer get player => _player;
  String get url => _url;
  String get name => _name;
  AudioPlayerProvider() {
    _player = AudioPlayer();
  }
  void setPlayer(AudioPlayer player) async {
    _player = player;
    notifyListeners();
  }

  void setUrl(String url, String name) async {
    _url = url;
    _name = name;
  }
}
