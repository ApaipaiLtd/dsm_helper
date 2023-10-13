import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

class ShortcutProvider with ChangeNotifier {
  bool _showShortcut = true;
  bool get showShortcut => _showShortcut;
  ShortcutProvider(this._showShortcut);
  void setShowShortcut(bool showShortcut) async {
    _showShortcut = showShortcut;
    notifyListeners();
    SpUtil.putBool("show_shortcut", showShortcut);
  }
}
