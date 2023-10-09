import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/Backup/Service/NetworkBackup.dart';
import 'package:dsm_helper/models/Syno/Core/BandwidthControl/Protocol.dart';
import 'package:dsm_helper/models/Syno/Core/ExternalDevice/Printer/BonjourSharing.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/Afp.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/Ftp.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/Nfs.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/ServiceDiscovery.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/Sftp.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/Smb.dart';
import 'package:dsm_helper/models/Syno/Core/FileServ/WSTransfer.dart';
import 'package:dsm_helper/models/Syno/Core/SyslogClient/FileTransfer.dart';
import 'package:dsm_helper/models/Syno/Core/Tftp.dart';
import 'package:dsm_helper/pages/control_panel/file_service/log_setting.dart';
import 'package:dsm_helper/pages/log_center/log_center.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
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
  List<String> utf8Modes = ['禁用', '自动', '强制'];
  bool loading = true;
  late TabController _tabController;
  Smb smb = Smb();
  Afp afp = Afp();
  Nfs nfs = Nfs();
  Ftp ftp = Ftp();
  Sftp sftp = Sftp();
  BandwidthProtocol? bandwidth;
  Tftp? tftp;
  NetworkBackup? networkBackup;
  ServiceDiscovery? serviceDiscovery;
  BonjourSharing? bonjourSharing;
  FileTransfer fileTransferLog = FileTransfer();
  WsTransfer? wsTransfer;
  bool saving = false;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getData();
    super.initState();
  }

  getData() async {
    // var res = await Api.fileService();
    var batchRes = await Api.dsm.batch(apis: [
      Smb(),
      Afp(),
      Nfs(),
      Ftp(),
      Sftp(),
      FileTransfer(),
    ]);
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
          _nfsv4Controller.value = TextEditingValue(text: nfs.nfsV4Domain ?? "");
          break;
        case "Ftp":
          ftp = res.data;
          _timeoutController.value = TextEditingValue(text: "${ftp.timeout ?? ''}");
          _ftpPortController.value = TextEditingValue(text: "${ftp.portnum ?? ''}");
          break;
        case "Sftp":
          sftp = res.data;
          _sftpPortController.value = TextEditingValue(text: "${sftp.portnum ?? ''}");
          break;
        case "FileTransfer":
          fileTransferLog = res.data;
          break;
        case "BandwidthProtocol":
          bandwidth = res.data;
          break;
        case "NetworkBackup":
          networkBackup = res.data;
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(title: Text("文件服务")),
      body: loading
          ? Center(child: LoadingWidget(size: 30))
          : Column(
              children: [
                TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  tabs: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text("SMB/AFP/NFS"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text("FTP"),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    //   child: Text("TFTP"),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    //   child: Text("rsync"),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    //   child: Text("高级设置"),
                    // ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "SMB",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        smb.enableSamba = !smb.enableSamba!;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: 60,
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "启用SMB服务",
                                            ),
                                          ),
                                          if (smb.enableSamba!)
                                            Icon(
                                              CupertinoIcons.checkmark_alt,
                                              color: Color(0xffff9813),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (smb.enableSamba!) ...[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: TextField(
                                        controller: _workgroupController,
                                        onChanged: (v) => smb.workgroup = v,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: '工作群组',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          smb.disableShadowCopy = !smb.disableShadowCopy!;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        height: 60,
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "不可访问以前版本",
                                              ),
                                            ),
                                            if (smb.disableShadowCopy!)
                                              Icon(
                                                CupertinoIcons.checkmark_alt,
                                                color: Color(0xffff9813),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          fileTransferLog.cifs = !fileTransferLog.cifs!;
                                        });
                                        if (fileTransferLog.cifs!) {
                                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                                            return LogSetting("cifs");
                                          }));
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        height: 60,
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "启动传输日志",
                                              ),
                                            ),
                                            if (fileTransferLog.cifs!)
                                              Icon(
                                                CupertinoIcons.checkmark_alt,
                                                color: Color(0xffff9813),
                                              ),
                                          ],
                                        ),
                                      ),
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
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              borderRadius: BorderRadius.circular(20),
                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              borderRadius: BorderRadius.circular(20),
                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "AFP",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        afp.enableAfp = !afp.enableAfp!;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: 60,
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "启用AFP服务",
                                            ),
                                          ),
                                          if (afp.enableAfp!)
                                            Icon(
                                              CupertinoIcons.checkmark_alt,
                                              color: Color(0xffff9813),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (afp.enableAfp!) ...[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          fileTransferLog.afp = !fileTransferLog.afp!;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        height: 60,
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "启动传输日志",
                                              ),
                                            ),
                                            if (fileTransferLog.afp!)
                                              Icon(
                                                CupertinoIcons.checkmark_alt,
                                                color: Color(0xffff9813),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "NFS",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        nfs.enableNfs = !nfs.enableNfs!;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: 60,
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "启用NFS服务",
                                            ),
                                          ),
                                          if (nfs.enableNfs!)
                                            Icon(
                                              CupertinoIcons.checkmark_alt,
                                              color: Color(0xffff9813),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (nfs.enableNfs!) ...[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          nfs.enableNfsV4 = !nfs.enableNfsV4!;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        height: 60,
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "启用 NFSv4.1 支持",
                                              ),
                                            ),
                                            if (nfs.enableNfsV4!)
                                              Icon(
                                                CupertinoIcons.checkmark_alt,
                                                color: Color(0xffff9813),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  if (nfs.enableNfsV4! && nfs.enableNfsV4!) ...[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: TextField(
                                        controller: _nfsv4Controller,
                                        onChanged: (v) => nfs.nfsV4Domain = v,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'NFSv4 域',
                                        ),
                                      ),
                                    ),
                                  ],
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
                        padding: EdgeInsets.symmetric(vertical: 20),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "FTP/FTPS",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        ftp.enableFtp = !ftp.enableFtp!;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: 60,
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "启用FTP服务",
                                            ),
                                          ),
                                          if (ftp.enableFtp!)
                                            Icon(
                                              CupertinoIcons.checkmark_alt,
                                              color: Color(0xffff9813),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        ftp.enableFtps = !ftp.enableFtps!;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: 60,
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "启用 FTP SSL/TLS 加密服务（FTPS）",
                                            ),
                                          ),
                                          if (ftp.enableFtps!)
                                            Icon(
                                              CupertinoIcons.checkmark_alt,
                                              color: Color(0xffff9813),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (ftp.enableFtps!) ...[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: TextField(
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
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: TextField(
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
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ftp.enableFxp = !ftp.enableFxp!;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        height: 60,
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "启用 FXP",
                                              ),
                                            ),
                                            if (ftp.enableFxp!)
                                              Icon(
                                                CupertinoIcons.checkmark_alt,
                                                color: Color(0xffff9813),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ftp.enableFips = !ftp.enableFips!;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        height: 60,
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "启用 FIPS 加密模块",
                                              ),
                                            ),
                                            if (ftp.enableFips!)
                                              Icon(
                                                CupertinoIcons.checkmark_alt,
                                                color: Color(0xffff9813),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ftp.enableAscii = !ftp.enableAscii!;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        height: 60,
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "支持 ASCII 传送模式",
                                              ),
                                            ),
                                            if (ftp.enableAscii!)
                                              Icon(
                                                CupertinoIcons.checkmark_alt,
                                                color: Color(0xffff9813),
                                              ),
                                          ],
                                        ),
                                      ),
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
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.all(20),
                                        child: Row(
                                          children: [
                                            Text("UTF-8 编码:"),
                                            Spacer(),
                                            Text("${utf8Modes[ftp.utf8Mode!]}"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "SFTP",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        sftp.enable = !sftp.enable!;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: 60,
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "启用SFTP服务",
                                            ),
                                          ),
                                          if (sftp.enable!)
                                            Icon(
                                              CupertinoIcons.checkmark_alt,
                                              color: Color(0xffff9813),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    child: TextField(
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Center(),
                      // Center(),
                      // Center(),
                    ],
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      onPressed: () async {
                        if (saving) {
                          return;
                        }
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
                      child: saving
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CupertinoActivityIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  ' 保存中 ',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            )
                          : Text(
                              ' 保存 ',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
