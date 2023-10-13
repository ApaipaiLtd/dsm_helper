import 'package:dsm_helper/models/Syno/Core/Desktop/InitData.dart';
import 'package:flutter/material.dart';

class InitDataProvider with ChangeNotifier {
  InitDataModel _initData = InitDataModel();
  InitDataModel get initData => _initData;
  InitDataProvider();
  void setInitData(InitDataModel initData) {
    _initData = initData;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
