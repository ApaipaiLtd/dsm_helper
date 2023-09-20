import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:flutter/material.dart';

class SystemInfoProvider with ChangeNotifier {
  System _systemInfo = System();
  System get systemInfo => _systemInfo;
  SystemInfoProvider();
  void setSystemInfo(System system) async {
    _systemInfo = system;
    notifyListeners();
  }
}
