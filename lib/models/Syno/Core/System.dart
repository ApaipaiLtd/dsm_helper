// ignore_for_file: unnecessary_import

import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_response.dart';
import 'package:dsm_helper/models/base_model.dart';
import 'package:dsm_helper/pages/control_panel/info/enums/use_device_class_enum.dart';

/// cpu_clock_speed : 1996
/// cpu_cores : "4"
/// cpu_family : "Celeron"
/// cpu_series : "J3455"
/// cpu_vendor : "INTEL"
/// enabled_ntp : true
/// external_pci_slot_info : []
/// firmware_date : "2023/04/08"
/// firmware_ver : "DSM 7.1.1-42962 Update 5"
/// model : "DS918+"
/// ntp_server : "pool.ntp.org"
/// ram_size : 8192
/// sata_dev : []
/// serial : "17A0PDN881802"
/// support_esata : "no"
/// sys_temp : 60
/// sys_tempwarn : false
/// systempwarn : false
/// temperature_warning : false
/// time : "2023-09-14 09:11:23"
/// time_zone : "Beijing"
/// time_zone_desc : "(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi"
/// up_time : "240:6:24"
/// usb_dev : [{"cls":"hub","pid":"0608","producer":"Genesys Logic, Inc.","product":"Hub","rev":"85.37","vid":"05e3"}]

class System extends BaseModel {
  System({
    this.cpuClockSpeed,
    this.cpuCores,
    this.cpuFamily,
    this.cpuSeries,
    this.cpuVendor,
    this.enabledNtp,
    this.externalPciSlotInfo,
    this.firmwareDate,
    this.firmwareVer,
    this.model,
    this.ntpServer,
    this.ramSize,
    this.sataDev,
    this.serial,
    this.supportEsata,
    this.sysTemp,
    this.sysTempwarn,
    this.systempwarn,
    this.temperatureWarning,
    this.time,
    this.timeZone,
    this.timeZoneDesc,
    this.upTime,
    this.usbDev,
  });

  static Future<System> info() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.System",
      "info",
      version: 1,
      parser: System.fromJson,
    );
    return res.data;
  }

  System.fromJson(dynamic json) {
    cpuClockSpeed = json['cpu_clock_speed'];
    cpuCores = json['cpu_cores'];
    cpuFamily = json['cpu_family'];
    cpuSeries = json['cpu_series'];
    cpuVendor = json['cpu_vendor'];
    enabledNtp = json['enabled_ntp'];
    if (json['external_pci_slot_info'] != null) {
      externalPciSlotInfo = json['external_pci_slot_info'];
      // json['external_pci_slot_info'].forEach((v) {
      //   externalPciSlotInfo?.add(Dynamic.fromJson(v));
      // });
    }
    firmwareDate = json['firmware_date'];
    firmwareVer = json['firmware_ver'];
    model = json['model'];
    ntpServer = json['ntp_server'];
    ramSize = json['ram_size'];
    if (json['sata_dev'] != null) {
      sataDev = json['sata_dev'];
      // json['sata_dev'].forEach((v) {
      //   sataDev?.add(Dynamic.fromJson(v));
      // });
    }
    serial = json['serial'];
    supportEsata = json['support_esata'];
    sysTemp = json['sys_temp'];
    sysTempwarn = json['sys_tempwarn'];
    systempwarn = json['systempwarn'];
    temperatureWarning = json['temperature_warning'];
    time = json['time'];
    timeZone = json['time_zone'];
    timeZoneDesc = json['time_zone_desc'];
    upTime = json['up_time'];
    if (json['usb_dev'] != null) {
      usbDev = [];
      json['usb_dev'].forEach((v) {
        usbDev?.add(UsbDev.fromJson(v));
      });
    }
  }

  @override
  fromJson(json) {
    return System.fromJson(json);
  }

  String? api = "SYNO.Core.System";
  String? method = "info";
  int? version = 1;

  num? cpuClockSpeed;
  String? cpuCores;
  String? cpuFamily;
  String? cpuSeries;
  String? cpuVendor;
  bool? enabledNtp;
  List<dynamic>? externalPciSlotInfo;
  String? firmwareDate;
  String? firmwareVer;
  String? model;
  String? ntpServer;
  num? ramSize;
  List<dynamic>? sataDev;
  String? serial;
  String? supportEsata;
  num? sysTemp;
  bool? sysTempwarn;
  bool? systempwarn;
  bool? temperatureWarning;
  String? time;
  String? timeZone;
  String? timeZoneDesc;
  String? upTime;
  List<UsbDev>? usbDev;
  System copyWith({
    num? cpuClockSpeed,
    String? cpuCores,
    String? cpuFamily,
    String? cpuSeries,
    String? cpuVendor,
    bool? enabledNtp,
    List<dynamic>? externalPciSlotInfo,
    String? firmwareDate,
    String? firmwareVer,
    String? model,
    String? ntpServer,
    num? ramSize,
    List<dynamic>? sataDev,
    String? serial,
    String? supportEsata,
    num? sysTemp,
    bool? sysTempwarn,
    bool? systempwarn,
    bool? temperatureWarning,
    String? time,
    String? timeZone,
    String? timeZoneDesc,
    String? upTime,
    List<UsbDev>? usbDev,
  }) =>
      System(
        cpuClockSpeed: cpuClockSpeed ?? this.cpuClockSpeed,
        cpuCores: cpuCores ?? this.cpuCores,
        cpuFamily: cpuFamily ?? this.cpuFamily,
        cpuSeries: cpuSeries ?? this.cpuSeries,
        cpuVendor: cpuVendor ?? this.cpuVendor,
        enabledNtp: enabledNtp ?? this.enabledNtp,
        externalPciSlotInfo: externalPciSlotInfo ?? this.externalPciSlotInfo,
        firmwareDate: firmwareDate ?? this.firmwareDate,
        firmwareVer: firmwareVer ?? this.firmwareVer,
        model: model ?? this.model,
        ntpServer: ntpServer ?? this.ntpServer,
        ramSize: ramSize ?? this.ramSize,
        sataDev: sataDev ?? this.sataDev,
        serial: serial ?? this.serial,
        supportEsata: supportEsata ?? this.supportEsata,
        sysTemp: sysTemp ?? this.sysTemp,
        sysTempwarn: sysTempwarn ?? this.sysTempwarn,
        systempwarn: systempwarn ?? this.systempwarn,
        temperatureWarning: temperatureWarning ?? this.temperatureWarning,
        time: time ?? this.time,
        timeZone: timeZone ?? this.timeZone,
        timeZoneDesc: timeZoneDesc ?? this.timeZoneDesc,
        upTime: upTime ?? this.upTime,
        usbDev: usbDev ?? this.usbDev,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cpu_clock_speed'] = cpuClockSpeed;
    map['cpu_cores'] = cpuCores;
    map['cpu_family'] = cpuFamily;
    map['cpu_series'] = cpuSeries;
    map['cpu_vendor'] = cpuVendor;
    map['enabled_ntp'] = enabledNtp;
    if (externalPciSlotInfo != null) {
      map['external_pci_slot_info'] = externalPciSlotInfo?.map((v) => v.toJson()).toList();
    }
    map['firmware_date'] = firmwareDate;
    map['firmware_ver'] = firmwareVer;
    map['model'] = model;
    map['ntp_server'] = ntpServer;
    map['ram_size'] = ramSize;
    if (sataDev != null) {
      map['sata_dev'] = sataDev?.map((v) => v.toJson()).toList();
    }
    map['serial'] = serial;
    map['support_esata'] = supportEsata;
    map['sys_temp'] = sysTemp;
    map['sys_tempwarn'] = sysTempwarn;
    map['systempwarn'] = systempwarn;
    map['temperature_warning'] = temperatureWarning;
    map['time'] = time;
    map['time_zone'] = timeZone;
    map['time_zone_desc'] = timeZoneDesc;
    map['up_time'] = upTime;
    if (usbDev != null) {
      map['usb_dev'] = usbDev?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// cls : "hub"
/// pid : "0608"
/// producer : "Genesys Logic, Inc."
/// product : "Hub"
/// rev : "85.37"
/// vid : "05e3"

class UsbDev {
  UsbDev({
    this.cls,
    this.pid,
    this.producer,
    this.product,
    this.rev,
    this.vid,
  });

  UsbDev.fromJson(dynamic json) {
    cls = json['cls'];
    pid = json['pid'];
    producer = json['producer'];
    product = json['product'];
    rev = json['rev'];
    vid = json['vid'];
  }
  String? cls;
  UsbDeviceClassEnum get classEnum => UsbDeviceClassEnum.fromValue(cls ?? 'unknown');
  String? pid;
  String? producer;
  String? product;
  String? rev;
  String? vid;
  UsbDev copyWith({
    String? cls,
    String? pid,
    String? producer,
    String? product,
    String? rev,
    String? vid,
  }) =>
      UsbDev(
        cls: cls ?? this.cls,
        pid: pid ?? this.pid,
        producer: producer ?? this.producer,
        product: product ?? this.product,
        rev: rev ?? this.rev,
        vid: vid ?? this.vid,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cls'] = cls;
    map['pid'] = pid;
    map['producer'] = producer;
    map['product'] = product;
    map['rev'] = rev;
    map['vid'] = vid;
    return map;
  }
}
