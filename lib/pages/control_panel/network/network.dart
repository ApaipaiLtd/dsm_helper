import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/Network/Ethernet.dart';
import 'package:dsm_helper/models/Syno/Core/Network/Network.dart';
import 'package:dsm_helper/models/Syno/Core/Network/PPPoE.dart';
import 'package:dsm_helper/models/Syno/Core/Network/Proxy.dart';
import 'package:dsm_helper/pages/control_panel/info/enums/network_nif_status_enum.dart';
import 'package:dsm_helper/pages/control_panel/network/enums/interface_type_enums.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/widgets/dot_widget.dart';
import 'package:dsm_helper/widgets/expansion_container.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Network extends StatefulWidget {
  const Network({super.key});

  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> with SingleTickerProviderStateMixin {
  TextEditingController _serverNameController = TextEditingController();
  TextEditingController _dnsPrimaryController = TextEditingController();
  TextEditingController _dnsSecondaryController = TextEditingController();
  TextEditingController _proxyHttpHostController = TextEditingController();
  TextEditingController _proxyHttpPortController = TextEditingController();
  late TabController _tabController;
  CoreNetwork network = CoreNetwork();
  Proxy proxy = Proxy();
  Map gateway = {};
  Map dsm = {};
  Ethernets ethernets = Ethernets();
  PPPoEs pppoes = PPPoEs();
  bool loading = true;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    getData();
    super.initState();
  }

  getData() async {
    List<DsmResponse> batchRes = await Api.dsm.batch(apis: [CoreNetwork(), Proxy(), Ethernets(), PPPoEs()]);
    batchRes.forEach((res) {
      switch (res.data.runtimeType.toString()) {
        case "CoreNetwork":
          network = res.data;
          print(network.toJson());
          _serverNameController.value = TextEditingValue(text: network.serverName ?? '');
          _dnsPrimaryController.value = TextEditingValue(text: network.dnsPrimary ?? '');
          _dnsSecondaryController.value = TextEditingValue(text: network.dnsSecondary ?? '');
          break;
        case "Proxy":
          proxy = res.data;
          _proxyHttpHostController.value = TextEditingValue(text: proxy.httpHost ?? '');
          _proxyHttpPortController.value = TextEditingValue(text: proxy.httpPort ?? '');
          break;
        case "Ethernets":
          ethernets = res.data;
          break;
        case "PPPoEs":
          pppoes = res.data;
          break;
      }
    });

    setState(() {
      loading = false;
    });
    // var res = await Api.networkStatus();
    // if (res['success']) {
    //   setState(() {
    //     loading = false;
    //   });
    //   List result = res['data']['result'];
    //   result.forEach((item) {
    //     if (item['success'] == true) {
    //       switch (item['api']) {
    //         case "SYNO.Core.Network":
    //           setState(() {
    //             if (item['data'] != null) {
    //               network = item['data'];
    //               _serverNameController.value = TextEditingValue(text: network['server_name']);
    //               _dnsPrimaryController.value = TextEditingValue(text: network['dns_primary']);
    //               _dnsSecondaryController.value = TextEditingValue(text: network['dns_secondary']);
    //             }
    //           });
    //           break;
    //         case "SYNO.Core.Network.Ethernet":
    //           setState(() {
    //             ethernets = item['data'];
    //           });
    //           break;
    //         case "SYNO.Core.Network.PPPoE":
    //           setState(() {
    //             pppoes = item['data'];
    //           });
    //           break;
    //         case "SYNO.Core.Network.Proxy":
    //           setState(() {
    //             proxy = item['data'];
    //             _proxyHttpHostController.value = TextEditingValue(text: proxy['http_host']);
    //             _proxyHttpPortController.value = TextEditingValue(text: proxy['http_port']);
    //           });
    //           break;
    //         case "SYNO.Core.Network.Router.Gateway.List":
    //           setState(() {
    //             gateway = item['data'];
    //           });
    //           break;
    //         case "SYNO.Core.Web.DSM":
    //           setState(() {
    //             dsm = item['data'];
    //             print(dsm);
    //           });
    //           break;
    //       }
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("网络"),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              text: "常规",
            ),
            Tab(
              text: "网络界面",
            ),
            Tab(
              text: "流量控制",
            ),
            Tab(
              text: "静态路由",
            ),
          ],
        ),
      ),
      body: loading
          ? Center(
              child: LoadingWidget(
                size: 30,
              ),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    WidgetCard(
                      title: "常规",
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "请输入服务器名称、域名服务器 (DNS) 及默认网关。",
                            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 14),
                          ),
                          TextField(
                            controller: _serverNameController,
                            onChanged: (v) => network.serverName = v,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: '服务器名称',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "默认网关(gateway)",
                            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                          ),
                          Text(
                            "${network.gateway} (${network.gatewayInfo?.ifnameEnum != InterfaceTypeEnum.unknown ? network.gatewayInfo?.ifnameEnum.label : network.gatewayInfo?.ifname})",
                            style: TextStyle(fontSize: 16),
                          ),
                          Divider(),
                          Text(
                            "IPv6默认网关",
                            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                          ),
                          Text(
                            "${network.v6gateway == null || network.v6gateway == "" ? "-" : network.v6gateway}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "手动配置DNS服务器",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: network.dnsManual ?? false,
                                    onChanged: (v) {
                                      setState(() {
                                        network.dnsManual = !network.dnsManual!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            controller: _dnsPrimaryController,
                            enabled: network.dnsManual,
                            onChanged: (v) => network.dnsPrimary = v,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: '首选DNS服务器',
                            ),
                          ),
                          TextField(
                            controller: _dnsSecondaryController,
                            enabled: network.dnsManual,
                            onChanged: (v) => network.dnsSecondary = v,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: '备用DNS服务器',
                            ),
                          )
                        ],
                      ),
                    ),
                    WidgetCard(
                      title: '代理服务器',
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "通过代理服务器连接",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: proxy.enable ?? false,
                                    onChanged: (v) {
                                      setState(() {
                                        proxy.enable = !proxy.enable!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            controller: _proxyHttpHostController,
                            enabled: proxy.enable ?? false,
                            onChanged: (v) => proxy.httpHost = v,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: '地址',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: _proxyHttpPortController,
                            enabled: proxy.enable ?? false,
                            onChanged: (v) => proxy.httpPort = v,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: '端口',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: [
                    if (ethernets.ethernets != null)
                      ...ethernets.ethernets!.map((ethernet) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppTheme.of(context)?.cardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.only(left: 16, right: 16, top: 14),

                          // padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ExpansionContainer(
                            expandedCrossAxisAlignment: CrossAxisAlignment.start,
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "局域网${ethernets.ethernets!.indexOf(ethernet) + 1}",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DotWidget(
                                      size: 10,
                                      color: ethernet.statusEnum.color,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${ethernet.statusEnum != NetworkStatusEnum.unknown ? ethernet.statusEnum.label : ethernet.status ?? '-'}",
                                      style: TextStyle(color: ethernet.statusEnum.color, fontSize: 12),
                                    ),
                                  ],
                                ),
                                if (ethernet.statusEnum == NetworkStatusEnum.connected)
                                  Row(
                                    children: [
                                      Text(
                                        ethernet.ip ?? '',
                                        style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Label(ethernet.useDhcp == true ? 'DHCP' : '静态IP', AppTheme.of(context)?.primaryColor ?? Colors.blue),
                                    ],
                                  ),
                              ],
                            ),
                            children: [
                              Text(
                                "子网掩码(mask)",
                                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                              ),
                              Text(
                                ethernet.mask == '' ? '--' : ethernet.mask ?? '--',
                                style: TextStyle(fontSize: 16),
                              ),
                              Divider(),
                              Text(
                                "IPv6地址",
                                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                              ),
                              ethernet.ipv6 != null && ethernet.ipv6!.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: ethernet.ipv6!.map((ipv6) {
                                        return Text(ipv6);
                                      }).toList(),
                                    )
                                  : Text(
                                      "--",
                                      textAlign: TextAlign.start,
                                    ),
                              Divider(),
                              Text(
                                "网络状态",
                                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                              ),
                              Text(
                                "${ethernet.maxSupportedSpeed} Mb/s,${ethernet.duplex == true ? '全双工' : '半双工'}, MTU ${ethernet.mtu}",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 14),
                            ],
                          ),
                        );
                      }).toList(),
                    if (pppoes.pppoes != null)
                      ...pppoes.pppoes!.map((pppoe) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppTheme.of(context)?.cardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.only(left: 16, right: 16, top: 14),
                          child: ExpansionContainer(
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "PPPoE",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DotWidget(
                                      size: 10,
                                      color: pppoe.statusEnum.color,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${pppoe.statusEnum != NetworkStatusEnum.unknown ? pppoe.statusEnum.label : pppoe.status ?? '-'}",
                                      style: TextStyle(color: pppoe.statusEnum.color, fontSize: 12),
                                    ),
                                  ],
                                ),
                                if (pppoe.statusEnum == NetworkStatusEnum.connected)
                                  Row(
                                    children: [
                                      Text(pppoe.ip ?? '-'),
                                    ],
                                  ),
                              ],
                            ),
                            expandedCrossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "子网掩码(mask)",
                                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                              ),
                              Text(
                                pppoe.mask == '' ? '--' : pppoe.mask ?? '--',
                                style: TextStyle(fontSize: 16),
                              ),
                              Divider(),
                              Text(
                                "IPv6地址",
                                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                              ),
                              pppoe.ipv6 != null && pppoe.ipv6!.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: pppoe.ipv6!.map((ipv6) {
                                        return Text(ipv6);
                                      }).toList(),
                                    )
                                  : Text(
                                      "--",
                                      textAlign: TextAlign.right,
                                    ),
                            ],
                          ),
                        );
                      }).toList(),
                  ],
                ),
                Center(
                  child: Text("开发中"),
                ),
                Center(
                  child: Text("开发中"),
                ),
              ],
            ),
    );
  }
}
