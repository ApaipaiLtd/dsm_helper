import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:dsm_helper/models/Syno/Core/System/Utilization.dart';
import 'package:flutter/material.dart';

class UtilizationProvider with ChangeNotifier {
  Utilization _utilization = Utilization();
  Utilization get utilization => _utilization;
  UtilizationProvider();
  void setUtilization(Utilization utilization) async {
    _utilization = utilization;
    notifyListeners();
  }
}
