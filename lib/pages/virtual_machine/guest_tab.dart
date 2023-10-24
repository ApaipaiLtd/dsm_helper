import 'dart:ui';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_exception.dart';
import 'package:dsm_helper/models/Syno/Virtualization/VirtualizationGuest.dart';
import 'package:dsm_helper/pages/virtual_machine/dialogs/guest_power_off_dialog.dart';
import 'package:dsm_helper/pages/virtual_machine/dialogs/guest_save_dialog.dart';
import 'package:dsm_helper/pages/virtual_machine/enums/guest_status_enums.dart';
import 'package:dsm_helper/pages/virtual_machine/enums/guest_status_type_enums.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/line_progress_bar.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class GuestTab extends StatefulWidget {
  const GuestTab({super.key});

  @override
  State<GuestTab> createState() => _GuestTabState();
}

class _GuestTabState extends State<GuestTab> {
  bool loading = true;
  VirtualizationGuest virtualizationGuest = VirtualizationGuest();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    virtualizationGuest = await VirtualizationGuest.list();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: LoadingWidget(size: 30))
        : virtualizationGuest.guests != null && virtualizationGuest.guests!.length > 0
            ? ListView.builder(
                itemBuilder: (context, i) {
                  return _buildGuestItem(virtualizationGuest.guests![i]);
                },
                itemCount: virtualizationGuest.guests!.length,
              )
            : EmptyWidget(
                text: "暂无虚拟机",
              );
  }

  Widget _buildGuestItem(Guests guest) {
    GlobalKey actionButtonKey = GlobalKey();
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.of(context)?.cardColor,
        borderRadius: BorderRadius.circular(22),
      ),
      margin: EdgeInsets.only(top: 14, left: 16, right: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${guest.name}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                guest.statusTypeEnum == GuestStatusTypeEnum.healthy
                    ? (guest.statusEnum != GuestStatusEnum.unknown
                        ? Label(
                            guest.statusEnum.label,
                            guest.statusEnum.color,
                          )
                        : Label("${guest.status}", guest.statusEnum.color))
                    : guest.statusTypeEnum != GuestStatusTypeEnum.unknown
                        ? Label(guest.statusTypeEnum.label, guest.statusTypeEnum.color)
                        : Label("${guest.statusType}", guest.statusTypeEnum.color),
                SizedBox(
                  width: 10,
                ),
                CupertinoButton(
                  key: actionButtonKey,
                  onPressed: () async {
                    showPopupWindow(
                      context,
                      gravity: KumiPopupGravity.leftTop,
                      bgColor: Colors.transparent,
                      clickOutDismiss: true,
                      clickBackDismiss: true,
                      customAnimation: false,
                      customPop: false,
                      customPage: false,
                      underStatusBar: true,
                      underAppBar: true,
                      needSafeDisplay: true,
                      offsetX: 30,
                      offsetY: 30,
                      // curve: Curves.easeInSine,
                      duration: Duration(milliseconds: 200),
                      targetRenderBox: actionButtonKey.currentContext!.findRenderObject() as RenderBox,
                      childFun: (pop) {
                        return BackdropFilter(
                          key: GlobalKey(),
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            width: 150,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            margin: EdgeInsets.only(top: 50),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(23),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PopupMenuItem(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //   "assets/icons/share.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text("开机"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    GuestPowerOffDialog.show(context, guest: guest, action: "shutdown");
                                  },
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //   "assets/icons/upload_cloud.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text("关机"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () async {
                                    GuestPowerOffDialog.show(context, guest: guest, action: "poweroff");
                                  },
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //   "assets/icons/star.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text("强制关机"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () async {
                                    GuestPowerOffDialog.show(context, guest: guest, action: "reboot");
                                  },
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //   "assets/icons/archive.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text("重新启动"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () async {
                                    var hide = showWeuiLoadingToast(context: context);
                                    try {
                                      bool? res = await guest.canSave();
                                      if (res == true) {
                                        hide();
                                      }
                                      GuestSaveDialog.show(context, guest: guest);
                                    } on DsmException catch (e) {
                                      hide();
                                      if (e.code == 630) {
                                        Utils.vibrate(FeedbackType.error);
                                        Utils.toast("未在主机上配置暂停虚拟机的存储空间");
                                      }
                                    } catch (e) {
                                      hide();
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //   "assets/icons/unzip.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text("暂停"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () async {},
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //   "assets/icons/unzip.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text("恢复"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () async {},
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //   "assets/icons/rename.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text("重置"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () async {},
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //   "assets/icons/delete.png",
                                      //   width: 20,
                                      //   height: 20,
                                      // ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Text(
                                        "删除",
                                        style: TextStyle(color: AppTheme.of(context)?.errorColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  child: Image.asset(
                    "assets/icons/more_horizontal.png",
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
            Text(
              "${guest.desc}",
              style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
            ),
            if (guest.statusEnum == GuestStatusEnum.running) ...[
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "CPU",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              "${((guest.vcpuUsage ?? 0) / 10).toStringAsFixed(1)}%",
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LineProgressBar(
                          value: (guest.vcpuUsage ?? 0) / 10,
                          backgroundColor: Theme.of(context).dividerColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "内存",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              "${Utils.formatSize((guest.ramUsed ?? 0) * 1024, fixed: 2)}",
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LineProgressBar(
                          value: (guest.ramUsed != null && guest.hostRamSize != null ? guest.ramUsed! / guest.hostRamSize! : 0) * 100,
                          backgroundColor: Theme.of(context).dividerColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              DefaultTextStyle(
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 14),
                child: Row(
                  children: [
                    Text("${guest.ip}"),
                    Spacer(),
                    Image.asset(
                      "assets/icons/arrow_down.png",
                      width: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${Utils.formatSize(guest.totalNetReceive ?? 0, showByte: true)}",
                      style: TextStyle(color: AppTheme.of(context)?.primaryColor),
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      "assets/icons/arrow_up.png",
                      width: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${Utils.formatSize(guest.totalNetSend ?? 0, showByte: true)}",
                      style: TextStyle(color: AppTheme.of(context)?.successColor),
                    ),
                  ],
                ),
              ),
              // ...networks.map((network) {
              //   return _buildNetworkItem(network, networks.indexOf(network));
              // }).toList(),
            ],
          ],
        ),
      ),
    );
  }
}
