import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/Package.dart';
import 'package:dsm_helper/models/Syno/Core/Security/Firewall/Rules/FirewallRulesServ.dart';
import 'package:dsm_helper/models/Syno/Core/Service.dart';
import 'package:dsm_helper/models/Syno/Core/Service/ServicePortInfo.dart';
import 'package:dsm_helper/pages/control_panel/info/enums/firewall_status_enum.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/strings.dart';
import 'package:dsm_helper/widgets/label.dart';
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
  Map<String, Service> serviceMap = {};
  Map<String, Packages> packageMap = {};
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
          service.service?.forEach((service) {
            if (service.displayNameSectionKey != null) {
              String name = service.displayNameSectionKey!;
              List<String> keys = service.displayNameSectionKey!.split(":");
              // var stringData = webManagerStrings;
              // for (int i = 0; i < keys.length; i++) {
              //   if(i == keys.length - 1){
              //     name = stringData[keys[i]];
              //   }else{
              //     stringData = stringData[keys[i]];
              //   }
              //
              // }
              if (keys.length == 2) {
                name = webManagerStrings[keys[0]]?[keys[1]] ?? service.displayNameSectionKey!;
              }
              service.displayName = name;
            }

            serviceMap[service.serviceId!] = service;
          });
          break;
        case "Package":
          packages = res.data;
          packages.packages?.forEach((element) {
            packageMap[element.id!] = element;
          });
          break;
      }
    });

    await getFirewallRules([...service.service?.map((e) => e.serviceId!) ?? [], ...packages.packages?.map((e) => e.id!) ?? []]);
    setState(() {
      loading = false;
    });
  }

  getFirewallRules(List<String> serviceId) async {
    List<DsmResponse> batchRes = await Api.dsm.batch(apis: [FirewallRulesServ(serviceId: serviceId), ServicePortInfo(serviceId: serviceId)]);
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
    firewallRulesServ.servicePolicy?.forEach((servicePolicy) {
      if (serviceMap[servicePolicy.serviceId!] != null) {
        serviceMap[servicePolicy.serviceId!]!.servicePolicy = servicePolicy;
        if (servicePolicy.interfaceInfo != null && servicePolicy.interfaceInfo!.isNotEmpty) {
          InterfaceInfo interfaceInfo = servicePolicy.interfaceInfo!.first;
          serviceMap[servicePolicy.serviceId!]!.portInfo.add(servicePortInfo.portInfo!.firstWhere((portInfo) => portInfo.portId == interfaceInfo.portInfo!.first.portId));
        }
      } else if (packageMap[servicePolicy.serviceId!] != null) {
        packageMap[servicePolicy.serviceId!]!.servicePolicy = servicePolicy;
        if (servicePolicy.interfaceInfo != null && servicePolicy.interfaceInfo!.isNotEmpty) {
          InterfaceInfo interfaceInfo = servicePolicy.interfaceInfo!.first;
          packageMap[servicePolicy.serviceId!]!.portInfo.add(servicePortInfo.portInfo!.firstWhere((portInfo) => portInfo.portId == interfaceInfo.portInfo!.first.portId));
        }
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
                  children: service.service!.map((e) {
                    return _buildServiceItem(e.displayName ?? e.displayNameSectionKey ?? '--', e.portInfo, e.servicePolicy!.statusEnum, isLast: service.service!.last == e);
                  }).toList(),
                ),
              ),
              WidgetCard(
                title: "套件",
                body: Column(
                  children: packages.packages!.map((e) => _buildServiceItem(e.name!, e.portInfo, e.servicePolicy!.statusEnum, isLast: packages.packages!.last == e)).toList(),
                ),
              )
            ],
          );
  }

  Widget _buildServiceItem(String name, List<PortInfo> portInfo, FirewallStatusEnum status, {bool isLast = false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 10,
              ),
              if (status != FirewallStatusEnum.unknown)
                Label(
                  status.label,
                  status.color,
                  fill: status == FirewallStatusEnum.deny,
                ),
            ],
          ),
          if (portInfo.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                portInfo.map((e) => e.dstPort!.join(",")).join(","),
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 14),
              ),
            ),
          if (!isLast)
            Divider(
              indent: 0,
              endIndent: 0,
            ),
        ],
      ),
    );
  }
}
