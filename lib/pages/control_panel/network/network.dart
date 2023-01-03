import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/bubble_tab_indicator.dart';
import 'package:dsm_helper/widgets/expansion_container.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class Network extends StatefulWidget {
  const Network({Key key}) : super(key: key);

  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> with SingleTickerProviderStateMixin {
  TextEditingController _serverNameController = TextEditingController();
  TextEditingController _dnsPrimaryController = TextEditingController();
  TextEditingController _dnsSecondaryController = TextEditingController();
  TextEditingController _proxyHttpHostController = TextEditingController();
  TextEditingController _proxyHttpPortController = TextEditingController();
  TabController _tabController;
  Map network = {};
  Map proxy = {};
  Map gateway = {};
  Map dsm = {};
  List ethernets = [];
  List pppoes = [];
  bool loading = true;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    getData();
    super.initState();
  }

  getData() async {
    var res = await Api.networkStatus();
    if (res['success']) {
      setState(() {
        loading = false;
      });
      List result = res['data']['result'];
      result.forEach((item) {
        if (item['success'] == true) {
          switch (item['api']) {
            case "SYNO.Core.Network":
              setState(() {
                if (item['data'] != null) {
                  network = item['data'];
                  _serverNameController.value = TextEditingValue(text: network['server_name']);
                  _dnsPrimaryController.value = TextEditingValue(text: network['dns_primary']);
                  _dnsSecondaryController.value = TextEditingValue(text: network['dns_secondary']);
                }
              });
              break;
            case "SYNO.Core.Network.Ethernet":
              setState(() {
                ethernets = item['data'];
              });
              break;
            case "SYNO.Core.Network.PPPoE":
              setState(() {
                pppoes = item['data'];
              });
              break;
            case "SYNO.Core.Network.Proxy":
              setState(() {
                proxy = item['data'];
                _proxyHttpHostController.value = TextEditingValue(text: proxy['http_host']);
                _proxyHttpPortController.value = TextEditingValue(text: proxy['http_port']);
              });
              break;
            case "SYNO.Core.Network.Router.Gateway.List":
              setState(() {
                gateway = item['data'];
              });
              break;
            case "SYNO.Core.Web.DSM":
              setState(() {
                dsm = item['data'];
                print(dsm);
              });
              break;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text("网络"),
      ),
      body: loading
          ? Center(
              child: NeuCard(
                padding: EdgeInsets.all(50),
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                child: CupertinoActivityIndicator(
                  radius: 14,
                ),
              ),
            )
          : Column(
              children: [
                NeuCard(
                  width: double.infinity,
                  decoration: NeumorphicDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  curveType: CurveType.flat,
                  bevel: 10,
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicator: BubbleTabIndicator(
                      indicatorColor: Theme.of(context).scaffoldBackgroundColor,
                      shadowColor: Util.getAdjustColor(Theme.of(context).scaffoldBackgroundColor, -20),
                    ),
                    tabs: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text("常规"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text("网络界面"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text("流量控制"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text("静态路由"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text("DSM设置"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView(
                        children: [
                          NeuCard(
                            decoration: NeumorphicDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                            bevel: 10,
                            curveType: CurveType.flat,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "常规",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("请输入系统名称、域名服务器 (DNS) 及默认网关。"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  NeuCard(
                                    decoration: NeumorphicDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    bevel: 20,
                                    curveType: CurveType.flat,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    child: TextField(
                                      controller: _serverNameController,
                                      onChanged: (v) => network['server_name'] = v,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: '系统名称',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("默认网关(gateway): ${network['gateway']}"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("IPv6默认网关: ${network['v6gateway'] == "" ? "-" : network['v6gateway']}"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        network['dns_manual'] = !network['dns_manual'];
                                      });
                                    },
                                    child: NeuCard(
                                      decoration: NeumorphicDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      curveType: network['dns_manual'] ? CurveType.emboss : CurveType.flat,
                                      bevel: 12,
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      child: Row(
                                        children: [
                                          Text("手动配置DNS服务器"),
                                          Spacer(),
                                          if (network['dns_manual'])
                                            Icon(
                                              CupertinoIcons.checkmark_alt,
                                              color: Color(0xffff9813),
                                              size: 22,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  NeuCard(
                                    decoration: NeumorphicDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    bevel: 20,
                                    curveType: network['dns_manual'] ? CurveType.flat : CurveType.concave,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    child: TextField(
                                      controller: _dnsPrimaryController,
                                      enabled: network['dns_manual'],
                                      onChanged: (v) => network['dns_primary'] = v,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: '首选DNS服务器',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  NeuCard(
                                    decoration: NeumorphicDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    bevel: 20,
                                    curveType: network['dns_manual'] ? CurveType.flat : CurveType.concave,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    child: TextField(
                                      controller: _dnsSecondaryController,
                                      enabled: network['dns_manual'],
                                      onChanged: (v) => network['dns_secondary'] = v,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: '备用DNS服务器',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          NeuCard(
                            decoration: NeumorphicDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                            bevel: 10,
                            curveType: CurveType.flat,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "代理服务器",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        proxy['enable'] = !proxy['enable'];
                                      });
                                    },
                                    child: NeuCard(
                                      decoration: NeumorphicDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      curveType: proxy['enable'] ? CurveType.emboss : CurveType.flat,
                                      bevel: 12,
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      child: Row(
                                        children: [
                                          Text("手动配置DNS服务器"),
                                          Spacer(),
                                          if (proxy['enable'])
                                            Icon(
                                              CupertinoIcons.checkmark_alt,
                                              color: Color(0xffff9813),
                                              size: 22,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  NeuCard(
                                    decoration: NeumorphicDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    bevel: 20,
                                    curveType: proxy['enable'] ? CurveType.flat : CurveType.concave,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    child: TextField(
                                      controller: _proxyHttpHostController,
                                      enabled: proxy['enable'],
                                      onChanged: (v) => proxy['http_host'] = v,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: '地址',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  NeuCard(
                                    decoration: NeumorphicDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    bevel: 20,
                                    curveType: proxy['enable'] ? CurveType.flat : CurveType.concave,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    child: TextField(
                                      controller: _proxyHttpPortController,
                                      enabled: proxy['enable'],
                                      onChanged: (v) => proxy['http_port'] = v,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: '端口',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      ListView(
                        children: [
                          ...ethernets.map((ethernet) {
                            return NeuCard(
                              decoration: NeumorphicDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                              bevel: 10,
                              curveType: CurveType.flat,
                              // padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ExpansionContainer(
                                title: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "局域网${ethernets.indexOf(ethernet) + 1}",
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        if (ethernet['status'] == 'connected') Label("已联机", Colors.blue) else if (ethernet['status'] == 'disconnected') Label("尚未联机", Colors.grey) else Label(ethernet['status'], Colors.orangeAccent),
                                      ],
                                    ),
                                    if (ethernet['status'] == 'connected')
                                      Row(
                                        children: [
                                          Text(ethernet['use_dhcp'] ? 'DHCP' : '静态IP'),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(ethernet['ip']),
                                        ],
                                      ),
                                  ],
                                ),
                                showFirst: false,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("子网掩码(mask)："),
                                            Expanded(
                                              child: Text(
                                                ethernet['mask'] == '' ? '--' : ethernet['mask'],
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("IPv6地址："),
                                              Expanded(
                                                child: ethernet['ipv6'] != null && ethernet['ipv6'].length > 0
                                                    ? Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: (ethernet['ipv6'] as List).map((ipv6) {
                                                          return Text(ipv6);
                                                        }).toList(),
                                                      )
                                                    : Text(
                                                        "--",
                                                        textAlign: TextAlign.right,
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text("网络状态："),
                                            Expanded(
                                              child: Text(
                                                "${ethernet['max_supported_speed']} Mb/s,${ethernet['duplex'] ? '全双工' : '半双工'}, MTU ${ethernet['mtu']}",
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          ...pppoes.map((pppoe) {
                            return NeuCard(
                              decoration: NeumorphicDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                              bevel: 10,
                              curveType: CurveType.flat,
                              // padding: EdgeInsets.symmetric(horizontal: 20),
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
                                        if (pppoe['status'] == 'connected') Label("已联机", Colors.blue) else if (pppoe['status'] == 'disconnected') Label("尚未联机", Colors.grey) else Label(pppoe['status'], Colors.orangeAccent),
                                      ],
                                    ),
                                    if (pppoe['status'] == 'connected')
                                      Row(
                                        children: [
                                          Text(pppoe['use_dhcp'] ? 'DHCP' : '静态IP'),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(pppoe['ip']),
                                        ],
                                      ),
                                  ],
                                ),
                                showFirst: false,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("子网掩码(mask)："),
                                            Expanded(
                                              child: Text(
                                                pppoe['mask'] == '' ? '--' : pppoe['mask'],
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("IPv6地址："),
                                              Expanded(
                                                child: pppoe['ipv6'] != null && pppoe['ipv6'].length > 0
                                                    ? Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: (pppoe['ipv6'] as List).map((ipv6) {
                                                          return Text(ipv6);
                                                        }).toList(),
                                                      )
                                                    : Text(
                                                        "--",
                                                        textAlign: TextAlign.right,
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (pppoe['status'] == 'connected')
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Row(
                                              children: [
                                                Text("网络状态："),
                                                Expanded(
                                                  child: Text(
                                                    "${pppoe['max_supported_speed']} Mb/s,${pppoe['duplex'] ? '全双工' : '半双工'}, MTU ${pppoe['mtu']}",
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
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
                      Center(
                        child: Text("开发中"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
