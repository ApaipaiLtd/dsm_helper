import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:dsm_helper/pages/control_panel/info/enums/use_device_class_enum.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:flutter/material.dart';

class UsbDeviceItem extends StatelessWidget {
  final UsbDev dev;
  final bool isLast;
  const UsbDeviceItem(this.dev, {this.isLast = false, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dev.classEnum != UsbDeviceClassEnum.unknown ? dev.classEnum.label : dev.cls ?? '未知',
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${dev.product} - ${dev.producer}",
            style: TextStyle(fontSize: 16),
          ),
          if (!isLast) Divider(indent: 0, endIndent: 0, height: 20),
        ],
      ),
    );
  }
}
