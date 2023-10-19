import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

class SettingProvider with ChangeNotifier {
  int _refreshDuration = 10;
  int get refreshDuration => _refreshDuration;

  bool _showShortcut = true;
  bool get showShortcut => _showShortcut;

  bool _videoPlayer = true;
  bool get videoPlayer => _videoPlayer;

  bool _launchGesture = true;
  bool get launchGesture => _launchGesture;

  bool _launchBiometrics = true;
  bool get launchBiometrics => _launchBiometrics;

  SettingProvider({int refreshDuration = 10, bool showShortcut = true}) {
    this._refreshDuration = refreshDuration;
    this._showShortcut = showShortcut;
  }
  void setRefreshDuration(int duration) async {
    _refreshDuration = duration;
    notifyListeners();
    SpUtil.putInt("refresh_duration", duration);
  }

  void setShowShortcut(bool showShortcut) {
    _showShortcut = showShortcut;
    notifyListeners();
    SpUtil.putBool("show_shortcut", _showShortcut);
  }

  void setVideoPlayer(bool videoPlayer) {
    _videoPlayer = videoPlayer;
    notifyListeners();
    SpUtil.putBool("video_player", _videoPlayer);
  }

  void setLaunchGesture(bool launchGesture) {
    _launchGesture = launchGesture;
    notifyListeners();
    SpUtil.putBool("launch_gesture", _launchGesture);
  }

  void setLaunchBiometrics(bool launchBiometrics) {
    _launchBiometrics = launchBiometrics;
    notifyListeners();
    SpUtil.putBool("launch_biometrics", _launchBiometrics);
  }
}
