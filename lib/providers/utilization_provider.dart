import 'dart:math';

import 'package:dsm_helper/models/Syno/Core/System/Utilization.dart';
import 'package:flutter/material.dart';

class UtilizationProvider with ChangeNotifier {
  Utilization _utilization = Utilization();
  Utilization get utilization => _utilization;

  List<Network> get networks => _networks;
  List<Network> _networks = List.generate(20, (index) => Network(tx: 0, rx: 0));

  int get maxNetworkSpeed {
    int maxSpeed = 0;
    for (var network in _networks) {
      int maxVal = max(network.rx!, network.tx!);
      if (maxSpeed < maxVal) {
        maxSpeed = maxVal;
      }
    }
    return maxSpeed;
  }

  UtilizationProvider();
  void setUtilization(Utilization utilization) async {
    _utilization = utilization;
    _networks.removeAt(0);
    _networks.add(utilization.network!.first);
    notifyListeners();
  }
}
