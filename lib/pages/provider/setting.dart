import 'package:dsm_helper/util/function.dart';
import 'package:flutter/material.dart';

class SettingProvider with ChangeNotifier {
  int _refreshDuration = 10;
  int get refreshDuration => _refreshDuration;
  SettingProvider(this._refreshDuration);
  void setRefreshDuration(int duration) async {
    _refreshDuration = duration;
    notifyListeners();
    Util.setStorage("refresh_duration", duration.toString());
  }
}
