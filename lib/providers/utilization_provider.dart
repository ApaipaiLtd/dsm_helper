import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:dsm_helper/models/Syno/Core/System/Utilization.dart';
import 'package:flutter/material.dart';

class UtilizationProvider with ChangeNotifier {
  Utilization _utilization = Utilization();
  Utilization get utilization => _utilization;

  List<Network> get network => _network;
  List<Network> _network = List.generate(20, (index) => Network());

  UtilizationProvider();
  void setUtilization(Utilization utilization) async {
    _utilization = utilization;
    _network.removeAt(0);
    _network.add(utilization.network!.first);
    notifyListeners();
  }
}
