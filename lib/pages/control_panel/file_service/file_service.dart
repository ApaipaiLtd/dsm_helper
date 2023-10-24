import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/Acl.dart';
import 'package:dsm_helper/models/Syno/Core/Backup/Service/NetworkBackup.dart';
import 'package:dsm_helper/models/Syno/Core/BandwidthControl/Protocol.dart';
import 'package:dsm_helper/models/Syno/Core/ExternalDevice/Printer/BonjourSharing.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/Afp.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/Ftp.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/Nfs.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/ReflinkCopy.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/ServiceDiscovery.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/Sftp.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/Smb.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/WsTransfer.dart';
import 'package:dsm_helper/models/Syno/Core/SyslogClient/FileTransfer.dart';
import 'package:dsm_helper/models/Syno/Core/Tftp.dart';
import 'package:dsm_helper/models/Syno/Core/Web/Dsm.dart';
import 'package:dsm_helper/pages/control_panel/file_service/log_setting.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/log_center/log_center.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/neu_picker.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FileService extends StatefulWidget {
  @override
  _FileServiceState createState() => _FileServiceState();
}

class _FileServiceState extends State<FileService> with SingleTickerProviderStateMixin {
  TextEditingController _workgroupController = TextEditingController();
  TextEditingController _nfsv4Controller = TextEditingController();
  TextEditingController _timeoutController = TextEditingController();
  TextEditingController _ftpPortController = TextEditingController();
  TextEditingController _sftpPortController = TextEditingController();
  TextEditingController _rsyncPortController = TextEditingController();
  List<String> utf8Modes = ['禁用', '自动', '强制'];
  bool loading = true;
  late TabController _tabController;
  Smb smb = Smb();
  Afp afp = Afp();
  Nfs nfs = Nfs();
  Ftp ftp = Ftp();
  Sftp sftp = Sftp();
  ReflinkCopy reflinkCopy = ReflinkCopy();
  BandwidthProtocol? bandwidth;
  Tftp? tftp;
  NetworkBackup networkBackup = NetworkBackup();
  ServiceDiscovery serviceDiscovery = ServiceDiscovery();
  BonjourSharing bonjourSharing = BonjourSharing();
  FileTransfer fileTransferLog = FileTransfer();
  Dsm dsm = Dsm();
  Acl acl = Acl();
  WsTransfer? wsTransfer;
  bool saving = false;
  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    getData();
    super.initState();
  }

  getData() async {
    // var res = await Api.fileService();
    var batchRes = await Api.dsm.batch(apis: [Smb(), Afp(), Nfs(), Ftp(), Sftp(), FileTransfer(), NetworkBackup(), BonjourSharing(), ReflinkCopy(), ServiceDiscovery(), Dsm(), Acl()]);
    setState(() {
      loading = false;
    });
    batchRes.forEach((res) {
      print(res.data);
      switch (res.data.runtimeType.toString()) {
        case "Smb":
          smb = res.data;
          _workgroupController.value = TextEditingValue(text: smb.workgroup ?? "");
          break;
        case "Afp":
          afp = res.data;
          break;
        case "Nfs":
          nfs = res.data;
          _nfsv4Controller.text = nfs.nfsV4Domain ?? "";
          break;
        case "Ftp":
          ftp = res.data;
          _timeoutController.text = "${ftp.timeout ?? ''}";
          _ftpPortController.text = "${ftp.portnum ?? '21'}";
          break;
        case "Sftp":
          sftp = res.data;
          _sftpPortController.text = "${sftp.portnum ?? '22'}";
          break;
        case "FileTransfer":
          fileTransferLog = res.data;
          break;
        case "BandwidthProtocol":
          bandwidth = res.data;
          break;
        case "NetworkBackup":
          networkBackup = res.data;
          _rsyncPortController.text = networkBackup.rsyncSshdPort ?? '22';
          break;
        case "BonjourSharing":
          bonjourSharing = res.data;
          break;
        case "ServiceDiscovery":
          serviceDiscovery = res.data;
          break;
        case "WsTransfer":
          wsTransfer = res.data;
          break;
        case "ReflinkCopy":
          reflinkCopy = res.data;
          break;
        case "Dsm":
          dsm = res.data;
          break;
        case "Acl":
          acl = res.data;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text(
          "文件服务",
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text("SMB"),
            ),
            Tab(
              child: Text("AFP"),
            ),
            Tab(
              child: Text("NFS"),
            ),
            Tab(
              child: Text("FTP"),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            //   child: Text("TFTP"),
            // ),
            Tab(
              child: Text("rsync"),
            ),
            Tab(
              child: Text("高级设置"),
            ),
          ],
        ),
      ),
      body: loading
          ? Center(child: LoadingWidget(size: 30))
          : TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    WidgetCard(
                      title: "SMB",
                      bodyPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      body: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用SMB服务",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: smb.enableSamba!,
                                    onChanged: (v) {
                                      setState(
                                        () {
                                          smb.enableSamba = v;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (smb.enableSamba!) ...[
                            TextField(
                              controller: _workgroupController,
                              onChanged: (v) => smb.workgroup = v,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: '工作群组',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "不可访问以前版本",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      value: smb.disableShadowCopy!,
                                      onChanged: (v) {
                                        setState(() {
                                          smb.disableShadowCopy = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "启动传输日志",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      value: fileTransferLog.cifs!,
                                      onChanged: (v) {
                                        setState(() {
                                          fileTransferLog.cifs = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (fileTransferLog.cifs!) ...[
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CupertinoButton(
                                      onPressed: () {
                                        if (fileTransferLog.cifs!) {
                                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                                            return LogSetting("cifs");
                                          }));
                                        }
                                      },
                                      color: AppTheme.of(context)?.primaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text("日志设置"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: CupertinoButton(
                                      onPressed: () {
                                        Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                                          return LogCenter();
                                        }));
                                      },
                                      color: AppTheme.of(context)?.primaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        "查看日志",
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: [
                    WidgetCard(
                      title: "AFP",
                      body: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用AFP服务",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: afp.enableAfp!,
                                    onChanged: (v) {
                                      setState(() {
                                        afp.enableAfp = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (afp.enableAfp!) ...[
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "启动传输日志",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      value: fileTransferLog.afp!,
                                      onChanged: (v) {
                                        setState(() {
                                          fileTransferLog.afp = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "应用默认的UNIX权限",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      value: afp.enableUmask!,
                                      onChanged: (v) {
                                        setState(() {
                                          afp.enableUmask = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "断开连接后立即释放资源",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      value: afp.enableDisconnectQuick!,
                                      onChanged: (v) {
                                        setState(() {
                                          afp.enableDisconnectQuick = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: [
                    WidgetCard(
                      title: "NFS",
                      body: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用NFS服务",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: nfs.enableNfs!,
                                    onChanged: (v) {
                                      setState(() {
                                        nfs.enableNfs = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (nfs.enableNfs!) ...[
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "启用NFSv4.1支持",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      value: nfs.enableNfsV4!,
                                      onChanged: (v) {
                                        setState(() {
                                          nfs.enableNfsV4 = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (nfs.enableNfsV4! && nfs.enableNfsV4!) ...[
                            TextField(
                              controller: _nfsv4Controller,
                              onChanged: (v) => nfs.nfsV4Domain = v,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'NFSv4域',
                              ),
                            )
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: [
                    WidgetCard(
                      title: "FTP/FTPS",
                      body: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用FTP服务(无加密)",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: ftp.enableFtp!,
                                    onChanged: (v) {
                                      setState(() {
                                        ftp.enableFtp = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用FTP SSL/TLS加密服务(FTPS)",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: ftp.enableFtps!,
                                    onChanged: (v) {
                                      setState(() {
                                        ftp.enableFtps = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (ftp.enableFtp! || ftp.enableFtps!) ...[
                            TextField(
                              controller: _timeoutController,
                              onChanged: (v) {
                                try {
                                  ftp.timeout = int.parse(v);
                                } catch (e) {
                                  print("error");
                                }
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: '超时(1-7200秒)',
                              ),
                            ),
                            TextField(
                              controller: _ftpPortController,
                              onChanged: (v) {
                                try {
                                  ftp.portnum = int.parse(v);
                                } catch (e) {
                                  print("error");
                                }
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'FTP 服务所使用的端口号',
                              ),
                            ),
                          ],
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用FXP",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: ftp.enableFxp!,
                                    onChanged: (v) {
                                      setState(() {
                                        ftp.enableFxp = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用FIPS加密模块",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: ftp.enableFips!,
                                    onChanged: (v) {
                                      setState(() {
                                        ftp.enableFips = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "支持ASCII传送模式",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: ftp.enableAscii!,
                                    onChanged: (v) {
                                      setState(() {
                                        ftp.enableAscii = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return NeuPicker(
                                    utf8Modes,
                                    value: ftp.utf8Mode!,
                                    onConfirm: (v) {
                                      setState(() {
                                        ftp.utf8Mode = v;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "UTF-8 编码:",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Spacer(),
                                Text("${utf8Modes[ftp.utf8Mode!]}"),
                                Icon(
                                  CupertinoIcons.right_chevron,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    WidgetCard(
                      title: "SFTP",
                      body: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用SFTP服务",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: sftp.enable!,
                                    onChanged: (v) {
                                      setState(() {
                                        sftp.enable = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (sftp.enable!)
                            TextField(
                              controller: _sftpPortController,
                              onChanged: (v) {
                                try {
                                  sftp.portnum = int.parse(v);
                                } catch (e) {
                                  print("error");
                                }
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: '端口号',
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: [
                    WidgetCard(
                      title: "rsync",
                      body: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用rsync服务",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: networkBackup.enable!,
                                    onChanged: (v) {
                                      setState(() {
                                        networkBackup.enable = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (networkBackup.enable!) ...[
                            TextField(
                              controller: _rsyncPortController,
                              onChanged: (v) {
                                networkBackup.rsyncSshdPort = v;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: '端口号',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "启用rsync账户",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      value: networkBackup.enableRsyncAccount!,
                                      onChanged: (v) {
                                        setState(() {
                                          networkBackup.enableRsyncAccount = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: [
                    WidgetCard(
                      title: "文件快速克隆",
                      body: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用文件快速克隆",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: reflinkCopy.reflinkCopyEnable!,
                                    onChanged: (v) {
                                      setState(() {
                                        reflinkCopy.reflinkCopyEnable = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    WidgetCard(
                      title: "Bonjour",
                      body: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用Bonjour服务发现",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: dsm.enableAvahi!,
                                    onChanged: (v) {
                                      setState(() {
                                        dsm.enableAvahi = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (reflinkCopy.reflinkCopyEnable!) ...[
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "启用Bonjour打印机共享",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      value: bonjourSharing.enableBonjourSupport!,
                                      onChanged: (v) {
                                        setState(() {
                                          bonjourSharing.enableBonjourSupport = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "启用通过SMB进行Bonjour Time Machine推送",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      value: serviceDiscovery.enableSmbTimeMachine!,
                                      onChanged: (v) {
                                        setState(() {
                                          serviceDiscovery.enableSmbTimeMachine = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "启用通过AFP进行Bonjour Time Machine推送",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      value: serviceDiscovery.enableAfpTimeMachine!,
                                      onChanged: (v) {
                                        setState(() {
                                          serviceDiscovery.enableAfpTimeMachine = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    WidgetCard(
                      title: "SSDP",
                      body: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "启用Windows网络发现以允许通过网络浏览器访问",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            child: Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: dsm.enableSsdp!,
                                onChanged: (v) {
                                  setState(() {
                                    dsm.enableSsdp = v;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    WidgetCard(
                      title: "跳过遍历检查",
                      body: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "启用跳过遍历检查",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            child: Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: acl.enable!,
                                onChanged: (v) {
                                  setState(() {
                                    acl.enable = v;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
      persistentFooterButtons: [
        CupertinoButton(
          color: AppTheme.of(context)?.primaryColor,
          borderRadius: BorderRadius.circular(15),
          padding: EdgeInsets.symmetric(vertical: 10),
          onPressed: saving
              ? null
              : () async {
                  setState(() {
                    saving = true;
                  });
                  // var res = await Api.fileServiceSave(smb, fileTransferLog, afp, nfs, ftp, sftp);
                  //
                  // if (res['success']) {
                  //   setState(() {
                  //     saving = false;
                  //   });
                  //   Utils.toast("保存成功");
                  //   getData();
                  // }
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (saving) ...[
                LoadingWidget(
                  size: 16,
                  color: AppTheme.of(context)?.placeholderColor,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
              Text(
                '保存',
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        )
      ],
    );
  }
}
