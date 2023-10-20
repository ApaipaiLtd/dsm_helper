import 'package:dsm_helper/models/Syno/Core/ExternalDevice/Storage/Device.dart';
import 'package:dsm_helper/pages/control_panel/external_device/dialogs/eject_external_device_dialog.dart';
import 'package:dsm_helper/pages/control_panel/external_device/enums/device_status_enum.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/providers/external_device_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/glass/glass_modal_popup.dart';
import 'package:dsm_helper/widgets/glass/popup_header.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExternalDevicePopupContent extends StatefulWidget {
  const ExternalDevicePopupContent({super.key});

  @override
  State<ExternalDevicePopupContent> createState() => _ExternalDevicePopupContentState();
}

class _ExternalDevicePopupContentState extends State<ExternalDevicePopupContent> {
  @override
  Widget build(BuildContext context) {
    ExternalDeviceProvider externalDeviceProvider = context.watch<ExternalDeviceProvider>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        PopupHeader(
          title: "外接设备",
        ),
        SizedBox(height: 10),
        Expanded(
          child: externalDeviceProvider.devices.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, i) {
                    return _buildDeviceItem(externalDeviceProvider.devices[i]);
                  },
                  itemCount: externalDeviceProvider.devices.length,
                )
              : EmptyWidget(
                  text: "无外接设备",
                ),
        ),
      ],
    );
  }

  Widget _buildDeviceItem(ExternalDevices device) {
    return WidgetCard(
      body: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${device.devTitle?.replaceAll("USB Disk", "USB硬盘")}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    device.statusEnum != DeviceStatusEnum.unknown
                        ? Label(
                            device.statusEnum.label,
                            device.statusEnum.color,
                            fill: true,
                          )
                        : Label(
                            device.status ?? '-',
                            device.statusEnum.color,
                            fill: true,
                          )
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "${device.product ?? '-'}",
                  style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
                ),
              ],
            ),
          ),
          CupertinoButton(
            child: Image.asset(
              "assets/icons/eject.png",
              width: 24,
              color: AppTheme.of(context)?.warningColor,
            ),
            padding: EdgeInsets.zero,
            onPressed: () {
              EjectExternalDeviceDialog.show(context: context, device: device);
            },
          ),
        ],
      ),
    );
  }
}

class ExternalDevicePopup {
  static Future show(BuildContext context) async {
    return await showGlassModalPopup(context, content: ExternalDevicePopupContent());
  }
}
