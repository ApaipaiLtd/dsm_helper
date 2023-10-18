import 'package:dsm_helper/models/Syno/Core/System/SystemNetwork.dart';
import 'package:dsm_helper/pages/control_panel/info/enums/network_nif_status_enum.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:flutter/material.dart';

class NetworkNifItemWidget extends StatelessWidget {
  final Nif nif;
  final int index;
  const NetworkNifItemWidget(this.nif, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: "局域网${index + 1}",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "连接状态",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${nif.statusEnum != NetworkStatusEnum.unknown ? nif.statusEnum.label : nif.status}",
            style: TextStyle(fontSize: 16, color: nif.statusEnum.color),
          ),
          Divider(indent: 0, endIndent: 0, height: 20),
          Text(
            "网络物理地址(MAC address)",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${nif.mac}",
            style: TextStyle(fontSize: 16),
          ),
          Divider(indent: 0, endIndent: 0, height: 20),
          Text(
            "IP地址",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${nif.addr}(${nif.useDhcp == true ? 'DHCP' : '静态IP'})",
            style: TextStyle(fontSize: 16),
          ),
          Divider(indent: 0, endIndent: 0, height: 20),
          Text(
            "子网掩码(mask)",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${nif.mask}",
            style: TextStyle(fontSize: 16),
          ),
          Divider(indent: 0, endIndent: 0, height: 20),
          if (nif.ipv6 != null && nif.ipv6!.isNotEmpty)
            ...nif.ipv6!.expand((e) => [
                  Text(
                    "IPv6地址",
                    style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                  ),
                  Text(
                    "${e.addr}/${e.prefixLen} Scope:${e.scope}",
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(indent: 0, endIndent: 0, height: 20),
                ]),
          Text(
            "网络状态",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${nif.speed}Mb/s，${nif.duplex == true ? '全双工' : '半双工'}，MTU ${nif.mtu}",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
