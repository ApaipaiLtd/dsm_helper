import 'package:dsm_helper/models/Syno/Docker/DockerNetwork.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/widgets/expansion_container.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> with AutomaticKeepAliveClientMixin {
  bool loading = true;
  DockerNetwork dockerNetwork = DockerNetwork();
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    dockerNetwork = await DockerNetwork.list();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return loading
        ? LoadingWidget(
            size: 30,
          )
        : ListView.builder(
            itemBuilder: (context, i) {
              return _buildNetworkItem(dockerNetwork.network![i]);
            },
            itemCount: dockerNetwork.network!.length,
          );
  }

  Widget _buildNetworkItem(Network network) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.of(context)?.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(left: 16, right: 16, top: 14),
      child: ExpansionContainer(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${network.name}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${network.containers!.length}个容器",
              style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.placeholderColor),
            )
          ],
        ),
        childrenPadding: EdgeInsets.only(bottom: 14),
        children: [
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "驱动程序",
                  style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                ),
                Text(
                  "${network.driver}",
                  style: TextStyle(fontSize: 16),
                ),
                if (network.subnet != null && network.subnet!.isNotEmpty) ...[
                  Divider(indent: 0, endIndent: 0, height: 20),
                  Text(
                    "子网",
                    style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                  ),
                  Text(
                    "${network.subnet}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
                if (network.gateway != null && network.gateway!.isNotEmpty) ...[
                  Divider(indent: 0, endIndent: 0, height: 20),
                  Text(
                    "网关",
                    style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                  ),
                  Text(
                    "${network.gateway}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
                Divider(indent: 0, endIndent: 0, height: 20),
                Text(
                  "IPv6",
                  style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                ),
                Text(
                  "${network.enableIpv6 == true ? '已启用' : '已禁用'}",
                  style: TextStyle(fontSize: 16),
                ),
                Divider(indent: 0, endIndent: 0, height: 20),
                Text(
                  "容器",
                  style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                ),
                SizedBox(
                  height: 5,
                ),
                if (network.containers != null && network.containers!.isNotEmpty)
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: network.containers!.map((e) => Label(e, AppTheme.of(context)?.primaryColor ?? Colors.blue)).toList(),
                  )
                else
                  Text("无"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
