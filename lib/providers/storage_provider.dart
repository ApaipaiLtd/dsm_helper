import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:flutter/material.dart';

class StorageProvider with ChangeNotifier {
  Storage _storage = Storage();
  Storage get storage => _storage;
  StorageProvider();
  void setStorage(Storage storage) async {
    _storage = storage;
    notifyListeners();
  }
}
