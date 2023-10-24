import 'package:dsm_helper/models/Syno/Virtualization/VirtualizationHost.dart';
import 'package:dsm_helper/pages/virtual_machine/enums/guest_status_enums.dart';
import 'package:dsm_helper/pages/virtual_machine/enums/guest_status_type_enums.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/line_progress_bar.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class HostTab extends StatefulWidget {
  const HostTab({super.key});

  @override
  State<HostTab> createState() => _HostTabState();
}

class _HostTabState extends State<HostTab> {
  bool loading = true;
  VirtualizationHost virtualizationHost = VirtualizationHost();
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    virtualizationHost = await VirtualizationHost.list();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: LoadingWidget(size: 30),
          )
        : virtualizationHost.hosts != null && virtualizationHost.hosts!.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, i) {
                  return _buildHostItem(virtualizationHost.hosts![i]);
                },
                itemCount: virtualizationHost.hosts!.length,
              )
            : EmptyWidget(
                text: "暂无集群",
              );
  }

  Widget _buildHostItem(Hosts host) {
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
                  "${host.name}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                host.statusTypeEnum == GuestStatusTypeEnum.healthy
                    ? (host.statusEnum != GuestStatusEnum.unknown
                        ? Label(
                            host.statusEnum.label,
                            host.statusEnum.color,
                          )
                        : Label("${host.status}", host.statusEnum.color))
                    : host.statusTypeEnum != GuestStatusTypeEnum.unknown
                        ? Label(host.statusTypeEnum.label, host.statusTypeEnum.color)
                        : Label("${host.statusType}", host.statusTypeEnum.color),
              ],
            ),
            Text(
              "${host.model}",
              style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
            ),
            if (host.statusEnum == GuestStatusEnum.running) ...[
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
                              "${(host.cpuUsage ?? 0).toStringAsFixed(1)}%",
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LineProgressBar(
                          value: host.cpuUsage ?? 0,
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
                              "${Utils.formatSize((host.freeRamSize ?? 0) * 1024, fixed: 2)}",
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LineProgressBar(
                          value: (host.freeRamSize != null && host.totalRamSize != null ? host.freeRamSize! / host.totalRamSize! : 0) * 100,
                          backgroundColor: Theme.of(context).dividerColor,
                        ),
                      ],
                    ),
                  ),
                ],
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
