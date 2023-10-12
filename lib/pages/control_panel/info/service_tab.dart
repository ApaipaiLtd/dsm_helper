import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/Package.dart';
import 'package:dsm_helper/models/Syno/Core/Security/Firewall/Rules/FirewallRulesServ.dart';
import 'package:dsm_helper/models/Syno/Core/Service.dart';
import 'package:dsm_helper/models/Syno/Core/Service/ServicePortInfo.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class ServiceTab extends StatefulWidget {
  const ServiceTab({super.key});

  @override
  State<ServiceTab> createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ServiceTab> {
  CoreService service = CoreService(additional: ['active_status']);
  Package packages = Package(additional: ['status']);
  ServicePortInfo servicePortInfo = ServicePortInfo();
  FirewallRulesServ firewallRulesServ = FirewallRulesServ();
  bool loading = true;
  @override
  void initState() {
    getServices();
    super.initState();
  }

  getServices() async {
    List<DsmResponse> batchRes = await Api.dsm.batch(apis: [CoreService(), Package()]);
    batchRes.forEach((res) {
      switch (res.data.runtimeType.toString()) {
        case "CoreService":
          service = res.data;
          break;
        case "Package":
          packages = res.data;
          break;
      }
    });

    await getFirewallRules([...service.service?.map((e) => e.serviceId!) ?? [], ...packages.packages?.map((e) => e.id!) ?? []]);
    setState(() {
      loading = false;
    });
  }

  getFirewallRules(List<String> serviceId) async {
    List<DsmResponse> batchRes = await Api.dsm.batch(apis: [ServicePortInfo(serviceId: serviceId), FirewallRulesServ(serviceId: serviceId)]);
    batchRes.forEach((res) {
      switch (res.data.runtimeType.toString()) {
        case "ServicePortInfo":
          servicePortInfo = res.data;
          break;
        case "FirewallRulesServ":
          firewallRulesServ = res.data;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: LoadingWidget(
            size: 30,
          ))
        : ListView(
            children: [
              WidgetCard(
                title: "DSM内部服务",
                body: Column(
                  children: service.service!
                      .map((e) => Container(
                            child: Row(
                              children: [
                                Text(e.displayNameSectionKey!),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              WidgetCard(
                title: "套件",
                body: Column(
                  children: packages.packages!
                      .map((e) => Container(
                            child: Row(
                              children: [
                                Text(e.name!),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          );
  }
}
