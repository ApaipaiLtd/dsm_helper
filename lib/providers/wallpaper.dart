import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

class WallpaperProvider with ChangeNotifier {
  bool _showWallpaper = true;
  bool get showWallpaper => _showWallpaper;
  WallpaperProvider(this._showWallpaper);
  void changeMode(bool showWallpaper) async {
    _showWallpaper = showWallpaper;
    notifyListeners();
    SpUtil.putBool("show_wallpaper", showWallpaper);
  }
}
