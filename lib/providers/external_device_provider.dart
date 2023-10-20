import 'package:dsm_helper/models/Syno/Core/ExternalDevice/Storage/Device.dart';
import 'package:flutter/material.dart';

class ExternalDeviceProvider with ChangeNotifier {
  Device _usb = Device();
  Device _esata = Device();
  Device get usb => _usb;
  Device get esata => _esata;
  List<ExternalDevices> get devices => (_usb.devices ?? []) + (_esata.devices ?? []);
  ExternalDeviceProvider();
  void setExternalDevice({Device? usb, Device? esata}) async {
    if (usb != null) _usb = usb;
    if (esata != null) _esata = esata;
    notifyListeners();
  }
}
