import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:android_intent_plus/android_intent.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cool_ui/cool_ui.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/pages/control_panel/shared_folders/add_shared_folder.dart';
import 'package:dsm_helper/pages/file/dialogs/create_folder_dialog.dart';
import 'package:dsm_helper/pages/file/dialogs/delete_file_dialog.dart';
import 'package:dsm_helper/pages/file/dialogs/favorite_popup.dart';
import 'package:dsm_helper/pages/file/dialogs/remote_folder_popup.dart';
import 'package:dsm_helper/pages/file/enums/list_type_enums.dart';
import 'package:dsm_helper/pages/file/enums/sort_enums.dart';
import 'package:dsm_helper/pages/file/remote_folder.dart';
import 'package:dsm_helper/pages/file/widgets/file_grid_item_widget.dart';
import 'package:dsm_helper/pages/file/widgets/file_list_item_widget.dart';
import 'package:dsm_helper/pages/transfer/bus/download_file_bus.dart';
import 'package:dsm_helper/utils/bus/bus.dart';
import 'package:dsm_helper/utils/extensions/media_query_ext.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/log.dart';
import 'package:dsm_helper/utils/overlay_util.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_modal_popup.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter_floating/floating/listener/event_listener.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:dsm_helper/pages/common/audio_player.dart';
import 'package:dsm_helper/pages/common/image_preview.dart';
import 'package:dsm_helper/pages/common/pdf_viewer.dart';
import 'package:dsm_helper/pages/common/text_editor.dart';
import 'package:dsm_helper/pages/file/search.dart';
import 'package:dsm_helper/pages/file/select_folder.dart';
import 'package:dsm_helper/pages/file/share.dart';
import 'package:dsm_helper/pages/file/share_manager.dart';
import 'package:dsm_helper/pages/file/upload.dart';
import 'package:dsm_helper/providers/audio_player_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/animation_progress_bar.dart';
import 'package:dsm_helper/widgets/transparent_router.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating/floating/assist/floating_slide_type.dart';
import 'package:flutter_floating/floating/floating.dart';
import 'package:flutter_floating/floating/manager/floating_manager.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:gbk_codec/gbk_codec.dart';

import 'package:dsm_helper/apis/api.dart' as api;

class Files extends StatefulWidget {
  final String path;

  Files({this.path = '', super.key});

  @override
  FilesState createState({key}) => FilesState();
}

class FilesState extends State<Files> {
  GlobalKey moreButtonKey = GlobalKey();
  GlobalKey sortButtonKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List paths = [];
  FileStationList files = FileStationList();
  List smbFolders = [];
  List ftpFolders = [];
  List sftpFolders = [];
  List davFolders = [];
  bool loading = true;
  bool success = true;
  String msg = "";
  bool multiSelectMode = false;
  List<FileItem> selectedFiles = [];
  ScrollController _pathScrollController = ScrollController();
  ScrollController _fileScrollController = ScrollController();
  Map backgroundProcess = {};
  SortByEnum sortBy = SortByEnum.name;
  SortDirectionEnum sortDirection = SortDirectionEnum.ASC;
  bool searchResult = false;
  bool searching = false;
  Timer? searchTimer;
  Timer? processingTimer;
  ListType listType = ListType.list;
  Floating? audioPlayerFloating;

  @override
  void dispose() {
    searchTimer?.cancel();
    processingTimer?.cancel();
    OverlayUtil.hide();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      _pathScrollController.animateTo(_pathScrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.ease);
    });
    String listTypeStr = SpUtil.getString("file_list_type", defValue: "list")!;
    String sortByStr = SpUtil.getString("file_sort_by", defValue: "name")!;
    String sortDirectionStr = SpUtil.getString("file_sort_direction", defValue: "ASC")!;
    setState(() {
      listType = ListType.fromValue(listTypeStr);
      sortBy = SortByEnum.fromValue(sortByStr);
      sortDirection = SortDirectionEnum.fromValue(sortDirectionStr);
    });
    setState(() {
      paths = widget.path.isNotEmpty ? widget.path.split("/").sublist(1) : [];
    });
    refresh();

    // getSmbFolder();
    // getFtpFolder();
    // getSftpFolder();
    // getDavFolder();
    // processingTimer = Timer.periodic(Duration(seconds: 10), (timer) {
    //   getBackgroundTask();
    // });

    super.initState();
  }

  getBackgroundTask() async {
    var res = await Api.backgroundTask();
    if (res['success']) {
      if (res['data']['tasks'] != null && res['data']['tasks'].length > 0) {
        for (var task in res['data']['tasks']) {
          if (backgroundProcess[task['taskid']] == null) {
            String type = "";
            switch (task['api']) {
              case 'SYNO.FileStation.CopyMove':
                if (task['params']['remove_src']) {
                  type = "move";
                } else {
                  type = "copy";
                }
                break;
              case 'SYNO.FileStation.Delete':
                type = "delete";
                break;
              case 'SYNO.FileStation.Compress':
                type = "compress";
                break;
              case 'SYNO.FileStation.Extract':
                type = 'extract';
                break;
            }
            if (type.isNotBlank) {
              backgroundProcess[task['taskid']] = {
                "timer": null,
                "data": task,
                'type': type,
                'path': task['params']['path'],
              };
              getProcessingTaskResult(task['taskid']);
            }
          }
        }
      }
    }
  }

  getCopyMoveTaskResult(String taskId) async {
    //获取复制/移动进度
    var result = await Api.copyMoveResult(taskId);
    Log.logger.info(result);
    if (result['success'] != null && result['success']) {
      setState(() {
        backgroundProcess[taskId]['data'] = result['data'];
      });
      if (result['data']['finished']) {
        // if (showProcessList = true) {
        //   Utils.toast("${result['data']['path']} ${backgroundProcess[taskId]['type'] == 'copy' ? '复制' : '移动'}到 ${result['data']['dest_folder_path']} 完成");
        // }

        backgroundProcess[taskId]['timer']?.cancel();
        backgroundProcess[taskId]['timer'] = null;
        backgroundProcess.remove(taskId);
        refresh();
      }
    }
  }

  getDeleteTaskResult(String taskId) async {
    //获取删除进度
    try {
      var result = await Api.deleteResult(taskId);
      if (result['success'] != null && result['success']) {
        if (result['data']['finished']) {
          // if (showProcessList = true) {
          //   Utils.toast("文件删除完成");
          // }
          backgroundProcess[taskId]['timer']?.cancel();
          backgroundProcess[taskId]['timer'] = null;
          backgroundProcess.remove(taskId);
          refresh();
        }
      }
    } catch (e) {
      Utils.toast("文件删除出错");
      backgroundProcess[taskId]['timer']?.cancel();
      backgroundProcess[taskId]['timer'] = null;
      backgroundProcess.remove(taskId);
    }
  }

  getExtractTaskResult(String taskId) async {
    var result = await Api.extractResult(taskId);
    if (result['success'] != null && result['success']) {
      if (result['data']['finished']) {
        if (result['data']['errors'] != null && result['data']['errors'].length > 0) {
          if (result['data']['errors'][0]['code'] == 1403) {
            String password = "";
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  "解压密码",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: TextField(
                                    onChanged: (v) => password = v,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "请输入解压密码",
                                      labelText: "解压密码",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CupertinoButton(
                                        onPressed: () async {
                                          if (password == "") {
                                            Utils.toast("请输入解压密码");
                                            return;
                                          }
                                          Navigator.of(context).pop();
                                          // extractFile(result['data']['path'], password: password);
                                        },
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(25),
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "确定",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: CupertinoButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                        },
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(25),
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "取消",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
        } else {
          // if (showProcessList = true) {
          //   Utils.toast("文件解压完成");
          // }
        }
        backgroundProcess[taskId]['timer']?.cancel();
        backgroundProcess[taskId]['timer'] = null;
        backgroundProcess.remove(taskId);
        refresh();
      } else {
        setState(() {
          backgroundProcess[taskId]['data'] = result['data'];
        });
      }
    }
  }

  getCompressTaskResult(String taskId) async {
    //获取压缩进度
    try {
      var result = await Api.compressResult(taskId);
      if (result['success'] != null && result['success']) {
        if (result['data']['finished']) {
          // if (showProcessList = true) {
          //   Utils.toast("文件压缩完成");
          // }

          backgroundProcess[taskId]['timer']?.cancel();
          backgroundProcess[taskId]['timer'] = null;
          backgroundProcess.remove(taskId);
          refresh();
        }
      }
    } catch (e) {
      Utils.toast("文件压缩出错");
      backgroundProcess[taskId]['timer']?.cancel();
      backgroundProcess[taskId]['timer'] = null;
      backgroundProcess.remove(taskId);
    }
  }

  getProcessingTaskResult(String taskId) {
    if (backgroundProcess[taskId] == null) {
      return;
    }
    backgroundProcess[taskId]['timer'] = Timer.periodic(Duration(seconds: 1), (_) async {
      switch (backgroundProcess[taskId]['type']) {
        case 'copy':
        case 'move':
          getCopyMoveTaskResult(taskId);
          break;
        case 'extract':
          getExtractTaskResult(taskId);
          break;
        case 'delete':
          getDeleteTaskResult(taskId);
          break;
        case 'compress':
          getCompressTaskResult(taskId);
          break;
      }
    });
  }

  initFloating() {
    if (audioPlayerFloating == null) {
      var audioPlayerProvider = context.read<AudioPlayerProvider>();
      ja.AudioPlayer player = audioPlayerProvider.player!;

      audioPlayerFloating = floatingManager.createFloating(
        "audio_player_floating",
        Floating(
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  width: 50,
                  height: 50,
                  child: ExtendedImage.asset("assets/music_cover.png"),
                ),
                StreamBuilder(
                  stream: player.positionStream,
                  builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
                    Duration _duration = player.duration ?? Duration.zero;
                    Duration _position = snapshot.data ?? Duration(seconds: 1);
                    return CircularPercentIndicator(
                      radius: 25,
                      animation: true,
                      progressColor: Colors.blue,
                      animateFromLastPercent: true,
                      circularStrokeCap: CircularStrokeCap.round,
                      lineWidth: 3,
                      backgroundColor: Colors.black12,
                      percent: _position.inMilliseconds.toDouble() / _duration.inMilliseconds.toDouble(),
                    );
                  },
                ),
              ],
            ),
          ),
          slideType: FloatingSlideType.onRightAndBottom,
          bottom: 200,
          right: 0,
          isShowLog: true,
          slideBottomHeight: 100,
        ),
      );
      FloatingEventListener listener = FloatingEventListener()
        ..downListener = (point) {
          if (audioPlayerFloating!.isShowing) {
            audioPlayerFloating!.close();
          }
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
            return AudioPlayer();
          })).then((_) {
            AudioPlayerProvider audioPlayerProvider = context.read<AudioPlayerProvider>();
            if (audioPlayerProvider.player!.playing && audioPlayerProvider.player!.playerState.processingState != ja.ProcessingState.completed) {
              audioPlayerFloating!.open(context);
            }
          });
        };
      audioPlayerFloating!.addFloatingListener(listener);
      audioPlayerProvider.player!.playerStateStream.forEach((ja.PlayerState playerState) {
        if (playerState.playing == false || playerState.processingState == ja.ProcessingState.completed) {
          audioPlayerFloating!.close();
        }
      });
    }
  }

  Future<List> getVolumes() async {
    var res = await Api.volumes();
    if (res['success']) {
      return res['data']['volumes'];
    } else {
      return [];
    }
  }

  refresh() {
    if (widget.path.isEmpty) {
      getShareList();
    } else {
      getFileList();
    }
  }

  setPaths(String path) {
    setState(() {
      searchResult = false;
      searching = false;
    });
    if (path == "") {
      setState(() {
        paths = [];
      });
    } else {
      if (path.startsWith("/")) {
        List<String> items = path.split("/").sublist(1);
        setState(() {
          paths = items;
        });
      } else {
        List<String> parts = path.split("://");
        String scheme = parts[0];
        String first = "$scheme://${parts[1].split("/").first}";
        // String first = "${uri.scheme}://${uri.userInfo}@${uri.host}";
        List<String> items = path.replaceAll(first, "").split("/");
        items[0] = first;
        setState(() {
          paths = items;
        });
      }
    }
  }

  search(List<String> folders, String pattern, bool searchContent) async {
    setState(() {
      searchResult = true;
      searching = true;
      loading = true;
    });
    var res = await Api.searchTask(folders, pattern, searchContent: searchContent);
    if (res['success']) {
      bool r = await getSearchTaakResult(res['data']['taskid']);
      if (r == false) {
        //搜索未结束
        searchTimer = Timer.periodic(Duration(seconds: 2), (timer) {
          getSearchTaakResult(res['data']['taskid']);
        });
      }
    } else {
      debugPrint("搜索出错");
    }
  }

  downloadFiles(List<FileItem> files) async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      Utils.vibrate(FeedbackType.warning);
      showCupertinoModalBottomSheet(
        context: context,
        // filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        builder: (context) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(22),
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "下载确认",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "您当前正在使用数据网络，下载文件可能会产生流量费用，是否继续下载？",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                          onPressed: () async {
                            Navigator.of(context).pop(true);
                            download(files);
                          },
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(25),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "下载",
                            style: TextStyle(fontSize: 18, color: Colors.redAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CupertinoButton(
                          onPressed: () async {
                            Navigator.of(context).pop(false);
                          },
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(25),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "取消",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          );
        },
      ).then((value) {
        if (value == null || value == false) {
          return;
        }
      });
    } else {
      download(files);
    }
  }

  download(List<FileItem> files) async {
    // 检查权限
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      // if (androidInfo.version.sdkInt >= 30) {
      //   bool permission = false;
      //   permission = await Permission.manageExternalStorage.isGranted;
      //   if (!permission) {
      //     Utils.toast("安卓11以上需授权文件管理权限");
      //     return;
      //   }
      // } else {
      bool permission = false;
      permission = await Permission.storage.request().isGranted;
      if (!permission) {
        Utils.toast("请先授权APP访问存储权限");
        return;
      }
      // }
    }

    for (var file in files) {
      String url = api.Api.dsm.baseUrl! + "/webapi/entry.cgi?api=SYNO.FileStation.Download&version=2&method=download&path=${Uri.encodeComponent(file.path!)}&mode=download&_sid=${api.Api.dsm.sid!}";
      String filename = "";
      if (file.isdir == true) {
        filename = "${file.name}.zip";
      } else {
        filename = file.name!;
      }
      DownloadTask task = await DownloadTask(
        url: url,
        filename: filename,
        displayName: filename,
        directory: 'download',
        updates: Updates.statusAndProgress,
        allowPause: true,
      ).withSuggestedFilename(unique: true);
      bus.fire(DownloadFileEvent(task));
      // await Utils.download(filename, url);
    }
    Utils.toast("已添加${files.length > 1 ? "${files.length}个" : ""}下载任务，请至下载页面查看");
    // Utils.downloadKey.currentState?.getData();
  }

  Future<bool> getSearchTaakResult(String taskId) async {
    var res = await Api.searchResult(taskId);
    if (res['success']) {
      if (res['data']['finished']) {
        searchTimer?.cancel();
      }
      setState(() {
        loading = false;
        searching = !res['data']['finished'];

        if (res['data']['files'] != null) {
          files = res['data']['files'];
        } else {
          // files = [];
        }
      });

      return res['data']['finished'];
    } else {
      return false;
    }
  }

  getSmbFolder() async {
    var res = await Api.smbFolder();
    if (res['success']) {
      setState(() {
        smbFolders = res['data']['folders'];
      });
    }
  }

  getFtpFolder() async {
    var res = await Api.remoteLink("ftp");
    if (res['success']) {
      setState(() {
        ftpFolders = res['data']['folders'];
      });
    }
  }

  getSftpFolder() async {
    var res = await Api.remoteLink("sftp");
    if (res['success']) {
      setState(() {
        sftpFolders = res['data']['folders'];
      });
    }
  }

  getDavFolder() async {
    var res = await Api.remoteLink("davs");
    if (res['success']) {
      setState(() {
        davFolders = res['data']['folders'];
      });
    }
  }

  getShareList() async {
    try {
      files = await FileStationList.shareList(sortBy: sortBy.name, sortDirection: sortDirection.name, additional: ["real_path", "owner", "time", "perm", "mount_point_type", "sync_share", "volume_status", "indexed", "hybrid_share"]);
      setState(() {
        loading = false;
        success = true;
      });
    } catch (e) {
      if (loading) {
        setState(() {
          // msg = res['msg'] ?? "加载失败，code:${res['error']['code']}";
        });
      }
    }
  }

  getFileList() async {
    setState(() {
      loading = true;
    });
    try {
      files = await FileStationList.fileList(path: widget.path, sortBy: sortBy.name, sortDirection: sortDirection.name);
      setState(() {
        loading = false;
        success = true;
      });
    } catch (e) {
      if (loading) {
        setState(() {
          // msg = res['msg'] ?? "加载失败，code:${res['error']['code']}";
        });
      }
    }
  }

  goPath(String path) async {
    Utils.vibrate(FeedbackType.light);
    if (path.isNotEmpty) {
      if (widget.path.startsWith(path) && Navigator.of(context).canPop()) {
        context.popUntil((route) => route.settings.name == path);
      } else {
        context.push(Files(path: path), settings: RouteSettings(name: path));
      }
    } else {
      // context.pushNamed("/", replace: true);
      if (widget.path.isNotEmpty) {
        context.popUntil((route) => route.settings.name == "/");
      }
    }
  }

  openPlainFile(FileItem file) async {
    var hide = showWeuiLoadingToast(context: context, message: Text("文件加载中"));
    var res = await Utils.get(
      api.Api.dsm.baseUrl! + "/webapi/entry.cgi?api=SYNO.FileStation.Download&version=1&method=download&path=${Uri.encodeComponent(file.path!)}&mode=open&_sid=${api.Api.dsm.sid!}",
      decode: false,
      responseType: ResponseType.bytes,
    );
    String content = "";
    try {
      content = utf8.decode(res);
    } on FormatException catch (e) {
      content = gbk_bytes.decode(res);
    }
    hide();
    // print(content);
    context.push(TextEditor(fileName: file.name!, content: content), rootNavigator: true);

    //
    // List<int> gbk_byte_codes = utf8.encode(res);
    // print(gbk_byte_codes);
    // String result = gbk_bytes.decode(res);
    // print(result);
  }

  compressFile() {
    String zipName = "";
    String destPath = "";
    if (selectedFiles.length == 1) {
      zipName = selectedFiles.first.fileName! + ".zip";
    } else {
      zipName = paths.last + ".zip";
    }
    destPath = "/" + paths.join("/") + "/" + zipName;
    showGlassDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "压缩文件",
            textAlign: TextAlign.center,
          ),
          content: Text("确认要压缩到“$zipName？”"),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      var hide = showWeuiLoadingToast(context: context);
                      String taskId = await FileItem.compress(selectedFiles, destFolderPath: destPath);
                      hide();
                      Navigator.of(context).pop();
                      // backgroundProcess[res['data']['taskid']] = {
                      //   "timer": null,
                      //   "data": {
                      //     "dest_folder_path": destPath,
                      //     "progress": 0,
                      //   },
                      //   "path": [file],
                      //   "type": 'compress',
                      // };
                      // setState(() {
                      //   multiSelectMode = false;
                      //   selectedFiles = [];
                      // });
                      // getProcessingTaskResult(res['data']['taskid']);
                    },
                    color: AppTheme.of(context)?.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "开始压缩",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    color: Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "取消",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  openFile(FileItem file, {bool remote = false}) async {
    if (multiSelectMode) {
      setState(() {
        if (selectedFiles.contains(file)) {
          selectedFiles.remove(file);
        } else {
          selectedFiles.add(file);
        }
      });
    } else {
      if (file.isdir!) {
        goPath(file.path!);
        // if (remote) {
        //   Navigator.of(context).pop();
        // }
      } else {
        switch (file.fileType) {
          case FileTypeEnum.image:
            //获取当前目录全部图片文件
            List<String> images = [];
            List<String> thumbs = [];
            List<String> names = [];
            List<String> paths = [];
            int index = 0;
            for (int i = 0; i < files.files!.length; i++) {
              if (file.fileType == FileTypeEnum.image) {
                images.add(api.Api.dsm.baseUrl! + "/webapi/entry.cgi?path=${Uri.encodeComponent(files.files![i].path!)}&size=original&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${api.Api.dsm.sid!}&animate=true");
                thumbs.add(api.Api.dsm.baseUrl! + "/webapi/entry.cgi?path=${Uri.encodeComponent(files.files![i].path!)}&size=small&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${api.Api.dsm.sid!}&animate=true");
                names.add(files.files![i].name!);
                paths.add(files.files![i].path!);
                if (files.files![i].name! == file.name!) {
                  index = images.length - 1;
                }
              }
            }
            Navigator.of(context, rootNavigator: true).push(TransparentPageRoute(
              pageBuilder: (context, _, __) {
                return ImagePreview(
                  images,
                  index,
                  thumbs: thumbs,
                  names: names,
                  paths: paths,
                  tag: images[index],
                  onDelete: () {
                    refresh();
                  },
                );
              },
            ));
            break;
          case FileTypeEnum.movie:
            bool videoPlayer = SpUtil.getBool("video_player", defValue: false)!;
            String url = api.Api.dsm.baseUrl! + "/fbdownload/${Uri.encodeComponent(file.name!)}?dlink=%22${Utils.utf8Encode(file.path!)}%22&_sid=%22${api.Api.dsm.sid!}%22&mode=open";
            // String url = api.Api.dsm.baseUrl! + "/fbdownload/${file['name']}?dlink=%22${Utils.utf8Encode(file['path'])}%22&_sid=%22${api.Api.dsm.sid!}%22&mode=open";
            // print(url);
            // 调用nplayer
            // launchUrlString("nplayer-http://${Uri.encodeComponent(url)}");
            // 调用vlc player
            // launchUrlString("vlc://$url");
            // return;
            if (videoPlayer) {
              AndroidIntent intent = AndroidIntent(
                action: 'action_view',
                data: url,
                arguments: {},
                type: "video/*",
              );
              await intent.launch();
            } else {
              // 获取封面
              // String name = file['name'];
              // name = name.substring(0, name.lastIndexOf('.'));
              // String? cover;
              // String? nfo;
              // try {
              //   cover = files.firstWhere((element) => element['name'].startsWith("$name-fanart") || element['name'].startsWith("fanart"))['path'];
              // } catch (e) {
              //   try {
              //     cover = files.firstWhere((element) => element['name'].startsWith("$name-thumb") || element['name'].startsWith("thumb"))['path'];
              //   } catch (e) {
              //     try {
              //       cover = files.firstWhere((element) => element['name'].startsWith("$name-poster") || element['name'].startsWith("poster"))['path'];
              //     } catch (e) {
              //       try {
              //         cover = files.firstWhere((element) => element['name'].startsWith("$name-cover") || element['name'].startsWith("cover"))['path'];
              //       } catch (e) {
              //         debugPrint("无封面图");
              //       }
              //     }
              //   }
              // }
              // try {
              //   nfo = files.firstWhere((element) => element['name'] == "$name.nfo")['path'];
              // } catch (e) {
              //   debugPrint("无NFO文件");
              // }
              // Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
              //   return VideoPlayer(
              //     url: url,
              //     name: file['name'],
              //     cover: cover,
              //     nfo: nfo,
              //   );
              // }));
            }

            break;
          case FileTypeEnum.music:
            initFloating();
            if (audioPlayerFloating!.isShowing) {
              audioPlayerFloating!.close();
            }
            String url = api.Api.dsm.baseUrl! + "/fbdownload/${Uri.encodeComponent(file.name!)}?dlink=%22${Utils.utf8Encode(file.path!)}%22&_sid=%22${api.Api.dsm.sid!}%22&mode=open";
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
              return AudioPlayer(
                url: url,
                name: file.name,
              );
            })).then((_) {
              AudioPlayerProvider audioPlayerProvider = context.read<AudioPlayerProvider>();
              if (audioPlayerProvider.player!.playing && audioPlayerProvider.player!.playerState.processingState != ja.ProcessingState.completed) {
                audioPlayerFloating!.open(context);
              }
            });
            break;
          // case FileType.music:
          //   AndroidIntent intent = AndroidIntent(
          //     action: 'action_view',
          //     data: api.Api.dsm.baseUrl! + "/webapi/entry.cgi?api=SYNO.FileStation.Download&version=1&method=download&path=${Uri.encodeComponent(file['path'])}&mode=open&_sid=${api.Api.dsm.sid!}",
          //     arguments: {},
          //     type: "audio/*",
          //   );
          //   await intent.launch();
          //   break;
          // case FileType.word:
          //   AndroidIntent intent = AndroidIntent(
          //     action: 'action_view',
          //     data: api.Api.dsm.baseUrl! + "/webapi/entry.cgi?api=SYNO.FileStation.Download&version=1&method=download&path=${Uri.encodeComponent(file['path'])}&mode=open&_sid=${api.Api.dsm.sid!}",
          //     arguments: {},
          //     type: "application/msword|application/vnd.openxmlformats-officedocument.wordprocessingml.document",
          //   );
          //   await intent.launch();
          //   break;
          // case FileType.excel:
          //   AndroidIntent intent = AndroidIntent(
          //     action: 'action_view',
          //     data: api.Api.dsm.baseUrl! + "/webapi/entry.cgi?api=SYNO.FileStation.Download&version=1&method=download&path=${Uri.encodeComponent(file['path'])}&mode=open&_sid=${api.Api.dsm.sid!}",
          //     arguments: {},
          //     type: "application/vnd.ms-excel|application/x-excel|application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
          //   );
          //   await intent.launch();
          //   break;
          // case FileType.ppt:
          //   AndroidIntent intent = AndroidIntent(
          //     action: 'action_view',
          //     data: api.Api.dsm.baseUrl! + "/webapi/entry.cgi?api=SYNO.FileStation.Download&version=1&method=download&path=${Uri.encodeComponent(file['path'])}&mode=open&_sid=${api.Api.dsm.sid!}",
          //     arguments: {},
          //     type: "application/vnd.ms-powerpoint|application/vnd.openxmlformats-officedocument.presentationml.presentation",
          //   );
          //   await intent.launch();
          //   break;
          case FileTypeEnum.code:
            openPlainFile(file);
            break;
          case FileTypeEnum.text:
            openPlainFile(file);
            break;
          case FileTypeEnum.pdf:
            context.push(PdfViewer(api.Api.dsm.baseUrl! + "/fbdownload/${file.name!}?dlink=%22${Utils.utf8Encode(file.path!)}%22&_sid=%22${api.Api.dsm.sid!}%22&mode=open", file.name!), rootNavigator: true);
            break;
          default:
            AndroidIntent intent = AndroidIntent(
              action: 'action_view',
              data: api.Api.dsm.baseUrl! + "/fbdownload/${file.name}?dlink=%22${Utils.utf8Encode(file.path!)}%22&_sid=%22${api.Api.dsm.sid!}%22&mode=open",
              arguments: {},
              // type: "application/vnd.ms-powerpoint|application/vnd.openxmlformats-officedocument.presentationml.presentation",
            );
            await intent.launch();
          // Utils.toast("暂不支持打开此类型文件");
        }
      }
    }
  }

  fileAction(file, {bool remote = false}) async {
    Utils.vibrate(FeedbackType.light);
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "选择操作",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: Wrap(
                        runSpacing: 20,
                        spacing: 20,
                        children: [
                          if (file['additional']['mount_point_type'] == "remote" && file['path'].startsWith("/"))
                            Container(
                              constraints: BoxConstraints(maxWidth: 112),
                              width: (MediaQuery.of(context).size.width - 100) / 4,
                              child: CupertinoButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  var res = await Api.unMountFolder(file['path']);
                                  if (res['success']) {
                                    Utils.toast("卸载成功");
                                    refresh();
                                    getSmbFolder();
                                  } else {
                                    Utils.toast("卸载失败，代码${res['error']['code']}");
                                  }
                                },
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(10),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/eject.png",
                                      width: 30,
                                    ),
                                    Text(
                                      "卸载",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (remote && !file['path'].startsWith("/"))
                            Container(
                              constraints: BoxConstraints(maxWidth: 112),
                              width: (MediaQuery.of(context).size.width - 100) / 4,
                              child: CupertinoButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  var res = await Api.remoteUnConnect(file['path']);
                                  if (res['success']) {
                                    Utils.toast("远程连接已断开");
                                    refresh();
                                    getSmbFolder();
                                  } else {
                                    Utils.toast("断开连接失败，代码${res['error']['code']}");
                                  }
                                },
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(10),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/eject.png",
                                      width: 30,
                                    ),
                                    Text(
                                      "断开连接",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  onFileLongPress(FileItem file) {
    if (multiSelectMode || widget.path.isEmpty) {
      return;
    }
    Utils.vibrate(FeedbackType.light);
    OverlayUtil.show(
      Positioned(
        bottom: 0,
        child: Container(
          width: context.width,
          color: Colors.white,
          child: SafeArea(
            top: false,
            child: DefaultTextStyle(
              style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor, fontWeight: FontWeight.normal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return SelectFolder(
                              multi: false,
                            );
                          },
                        ).then((folder) async {
                          if (folder != null && folder.length == 1) {
                            List<String> files = selectedFiles.map((e) => e.path!).toList();
                            var res = await Api.copyMoveTask(files, folder[0], true);
                            if (res['success']) {
                              setState(() {
                                selectedFiles = [];
                                multiSelectMode = false;
                                backgroundProcess[res['data']['taskid']] = {
                                  "timer": null,
                                  "data": {
                                    "dest_folder_path": folder[0],
                                    "progress": 0,
                                  },
                                  "type": 'move',
                                  "path": files,
                                };
                              });
                              //获取移动进度
                              getProcessingTaskResult(res['data']['taskid']);
                            }
                          }
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icons/move.png",
                              width: 24,
                            ),
                            Text("移动到"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return SelectFolder(
                              multi: false,
                            );
                          },
                        ).then((folder) async {
                          if (folder != null && folder.length == 1) {
                            List<String> files = selectedFiles.map((e) => e.path!).toList();
                            var res = await Api.copyMoveTask(files, folder[0], false);
                            if (res['success']) {
                              setState(() {
                                selectedFiles = [];
                                multiSelectMode = false;
                                backgroundProcess[res['data']['taskid']] = {
                                  "timer": null,
                                  "data": {
                                    "dest_folder_path": folder[0],
                                    "progress": 0,
                                  },
                                  "type": "copy",
                                  "path": files,
                                };
                              });
                              getProcessingTaskResult(res['data']['taskid']);
                            }
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icons/copy.png",
                              width: 24,
                            ),
                            Text("复制到"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        compressFile();
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icons/archive.png",
                            width: 24,
                          ),
                          Text("压缩"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        downloadFiles(selectedFiles);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icons/download_cloud.png",
                              width: 24,
                            ),
                            Text("下载"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        DeleteFileDialog.show(context: context, files: selectedFiles);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icons/delete.png",
                              width: 24,
                            ),
                            Text(
                              "删除",
                              style: TextStyle(color: AppTheme.of(context)?.errorColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    setState(() {
      selectedFiles.add(file);
      multiSelectMode = true;
    });
  }

  Widget _buildPathItem(BuildContext context, int index, {bool isLast = false}) {
    return CupertinoButton(
      onPressed: () {
        if (!isLast) {
          String path = "";
          List<String> items = [];
          if (paths.length > 1 && paths[0].contains("//")) {
            items = paths.getRange(0, index + 1).toList().cast<String>();
            path = items.join("/");
          } else {
            items = paths.getRange(0, index + 1).toList().cast<String>();
            path = "/" + items.join("/");
          }
          goPath(path);
        }
      },
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Text(
        paths[index],
        strutStyle: StrutStyle(forceStrutHeight: true),
        style: TextStyle(fontSize: 16, color: isLast ? AppTheme.of(context)?.primaryColor : Colors.black54),
      ),
    );
  }

  Widget _buildProcessList() {
    List<Widget> children = [];
    Map<String, String> types = {
      "copy": "复制：",
      "move": "移动：",
      "delete": "删除：",
      "extract": "解压：",
      "compress": "压缩：",
    };
    backgroundProcess.forEach((key, task) {
      var value = task['data'];
      children.add(
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: types["${task['type'] ?? ''}"],
                      ),
                      TextSpan(
                        text: task['path'].map((e) => e.split("/").last).join(","),
                        style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                      ),
                      if (['copy', 'move', 'achieve', 'compress'].contains(task['type']) && value != null) ...[
                        TextSpan(
                          text: " 至 ",
                        ),
                        TextSpan(
                          text: value['dest_folder_path'] ?? '',
                          style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                        ),
                      ],
                    ],
                  ),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                if (value != null)
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FAProgressBar(
                      backgroundColor: Colors.transparent,
                      changeColorValue: 100,
                      changeProgressColor: Colors.green,
                      progressColor: Colors.blue,
                      size: 20,
                      currentValue: (num.parse("${value['progress']}") * 100).toInt(),
                      displayText: '%',
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      key: _scaffoldKey,
      appBar: GlassAppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: multiSelectMode
            ? Row(
                children: [
                  CupertinoButton(
                    onPressed: () async {
                      OverlayUtil.hide();
                      setState(() {
                        multiSelectMode = false;
                        selectedFiles = [];
                      });
                    },
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "已选${selectedFiles.length}项",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      if (selectedFiles.length == files.files!.length) {
                        selectedFiles = [];
                      } else {
                        selectedFiles = files.files!;
                      }

                      setState(() {});
                    },
                    child: Image.asset(
                      "assets/icons/select_all.png",
                      width: 24,
                      height: 24,
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  CupertinoButton(
                    onPressed: () async {
                      FavoritePopup.show(context: context).then((res) {
                        if (res != null) {
                          goPath(res.path!);
                        }
                      });
                    },
                    child: Image.asset("assets/icons/star.png", width: 24),
                  ),
                  CupertinoButton(
                    onPressed: () async {
                      RemoteFolderPopup.show(context: context);
                    },
                    child: Image.asset(
                      "assets/icons/remote.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  if (Utils.notReviewAccount && paths.length > 0)
                    CupertinoButton(
                      onPressed: () async {
                        context.push(Upload(widget.path), name: "upload", rootNavigator: true).then((res) {
                          refresh();
                        });
                      },
                      child: Image.asset(
                        "assets/icons/upload_cloud.png",
                        width: 24,
                      ),
                    ),
                  if (backgroundProcess.isNotEmpty)
                    CupertinoButton(
                      onPressed: () async {
                        setState(() {
                          // showProcessList = !showProcessList;
                        });
                      },
                      child: Image.asset(
                        "assets/icons/bgtask.gif",
                        width: 24,
                      ),
                    ),
                  Spacer(),
                  if (paths.length > 0)
                    CupertinoButton(
                      onPressed: () async {
                        context.push(Search(widget.path), name: "search", rootNavigator: true).then((res) => {
                              if (res != null)
                                {
                                  // search(res['folders'], res['pattern'], res['search_content']);
                                }
                            });
                      },
                      child: Image.asset(
                        "assets/icons/search.png",
                        width: 24,
                      ),
                    ),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        listType = listType == ListType.list ? ListType.grid : ListType.list;
                      });
                      SpUtil.putString("file_list_type", listType.name);
                    },
                    child: Image.asset(
                      listType == ListType.list ? "assets/icons/file_grid.png" : "assets/icons/file_list.png",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  CupertinoButton(
                    key: sortButtonKey,
                    onPressed: () {
                      showPopupWindow(
                        context,
                        gravity: KumiPopupGravity.leftBottom,
                        //curve: Curves.elasticOut,
                        bgColor: Colors.transparent,
                        clickOutDismiss: true,
                        clickBackDismiss: true,
                        customAnimation: false,
                        customPop: false,
                        customPage: false,
                        //targetRenderBox: (btnKey.currentContext.findRenderObject() as RenderBox),
                        //needSafeDisplay: true,
                        underStatusBar: false,
                        underAppBar: false,
                        offsetX: 40,
                        offsetY: -40,
                        duration: Duration(milliseconds: 200),
                        targetRenderBox: moreButtonKey.currentContext!.findRenderObject() as RenderBox,
                        childFun: (pop) {
                          return BackdropFilter(
                            key: GlobalKey(),
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              width: 186,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(23),
                              ),
                              child: Column(
                                children: SortByEnum.values.map((e) {
                                  return PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        if (sortBy != e) {
                                          sortBy = e;
                                        } else {
                                          sortDirection = sortDirection == SortDirectionEnum.ASC ? SortDirectionEnum.DESC : SortDirectionEnum.ASC;
                                        }
                                        SpUtil.putString("file_sort_by", sortBy.name);
                                        SpUtil.putString("file_sort_direction", sortDirection.name);
                                      });
                                      refresh();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.label,
                                            style: TextStyle(color: sortBy == e ? AppTheme.of(context)?.primaryColor : null),
                                          ),
                                          if (sortBy == e)
                                            Text(
                                              sortDirection.label,
                                              style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 12),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Image.asset(sortDirection.icon, width: 24, height: 24),
                  ),
                  CupertinoButton(
                    key: moreButtonKey,
                    onPressed: () {
                      showPopupWindow(
                        context,
                        gravity: KumiPopupGravity.leftBottom,
                        bgColor: Colors.transparent,
                        clickOutDismiss: true,
                        clickBackDismiss: true,
                        customAnimation: false,
                        customPop: false,
                        customPage: false,
                        underStatusBar: false,
                        underAppBar: false,
                        offsetX: 40,
                        offsetY: -40,
                        duration: Duration(milliseconds: 200),
                        targetRenderBox: moreButtonKey.currentContext!.findRenderObject() as RenderBox,
                        childFun: (pop) {
                          return BackdropFilter(
                            key: GlobalKey(),
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              width: 186,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(23),
                              ),
                              child: Column(
                                children: [
                                  PopupMenuItem(
                                    onTap: () async {
                                      bool? res = await CreateFolderDialog.show(context: context, path: widget.path);
                                      if (res == true) {
                                        refresh();
                                      }
                                    },
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/folder_plus.png",
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("新建文件夹"),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      context.push(AddSharedFolders([]), name: "add_shared_folders", rootNavigator: true);
                                    },
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/folder_plus.png",
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("新建共享文件夹"),
                                      ],
                                    ),
                                  ),
                                  if (widget.path.isNotEmpty)
                                    PopupMenuItem(
                                      onTap: () {
                                        context.push(Share(paths: [widget.path], fileRequest: true), name: "share", rootNavigator: true);
                                      },
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/upload_cloud.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("文件请求"),
                                        ],
                                      ),
                                    ),
                                  PopupMenuItem(
                                    onTap: () {
                                      context.push(RemoteFolder(), name: "remote_folder", rootNavigator: true);
                                    },
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/remote.png",
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("装载远程"),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      context.push(ShareManager(), name: "share_manager", rootNavigator: true);
                                    },
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/link.png",
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("共享链接管理"),
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
                    child: Image.asset(
                      "assets/icons/more_vertical.png",
                      width: 24,
                      height: 24,
                    ),
                  )
                ],
              ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: context.padding.top + 50,
          ),
          // if (searchResult)
          //   Container(
          //     height: 45,
          //     color: Theme.of(context).scaffoldBackgroundColor,
          //     alignment: Alignment.centerLeft,
          //     child: Row(
          //       children: [
          //         Container(
          //           margin: EdgeInsets.only(left: 20),
          //           padding: const EdgeInsets.symmetric(vertical: 10),
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color: Theme.of(context).scaffoldBackgroundColor,
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          //             child: Text(
          //               "搜索结果",
          //               style: TextStyle(fontSize: 12),
          //             ),
          //           ),
          //         ),
          //         Spacer(),
          //         GestureDetector(
          //           onTap: () {
          //             searchTimer?.cancel();
          //             setState(() {
          //               searching = false;
          //               searchResult = false;
          //               refresh();
          //             });
          //           },
          //           child: Container(
          //             margin: EdgeInsets.only(right: 20),
          //             padding: const EdgeInsets.symmetric(vertical: 10),
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 color: Theme.of(context).scaffoldBackgroundColor,
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          //               child: searching
          //                   ? Row(
          //                       children: [
          //                         Text(
          //                           "搜索中",
          //                           style: TextStyle(fontSize: 12),
          //                         ),
          //                         SizedBox(
          //                           width: 5,
          //                         ),
          //                         CupertinoActivityIndicator(
          //                           radius: 6,
          //                         ),
          //                       ],
          //                     )
          //                   : Text(
          //                       "退出搜索",
          //                       style: TextStyle(fontSize: 12),
          //                     ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   )
          // else
          Container(
            height: 55,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    goPath("");
                  },
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(
                    "本机",
                    style: TextStyle(fontSize: 16, color: widget.path.isEmpty ? AppTheme.of(context)?.primaryColor : Colors.black54),
                  ),
                  // child: Image.asset(
                  //   "assets/icons/home_line.png",
                  //   width: 20,
                  //   height: 20,
                  //   color: widget.path.isEmpty ? AppTheme.of(context)?.primaryColor : null,
                  // ),
                ),
                if (paths.length > 0)
                  Container(
                    child: Icon(
                      CupertinoIcons.right_chevron,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                Expanded(
                  child: ListView.separated(
                    controller: _pathScrollController,
                    itemBuilder: (context, i) {
                      return _buildPathItem(context, i, isLast: i == paths.length - 1);
                    },
                    itemCount: paths.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, i) {
                      return Icon(
                        CupertinoIcons.right_chevron,
                        size: 16,
                        color: Colors.black54,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // if (backgroundProcess.isNotEmpty && showProcessList) _buildProcessList(),
          Expanded(
            child: loading
                ? LoadingWidget(
                    size: 30,
                  )
                : success
                    ? files.files!.length == 0
                        ? EmptyWidget(
                            text: "暂无文件",
                          )
                        : listType == ListType.list
                            ? DraggableScrollbar.arrows(
                                backgroundColor: AppTheme.of(context)?.placeholderColor ?? Colors.black54,
                                scrollbarTimeToFade: Duration(seconds: 1),
                                controller: _fileScrollController,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  controller: _fileScrollController,
                                  itemBuilder: (context, i) {
                                    FileItem file = files.files![i];
                                    return FileListItemWidget(
                                      file,
                                      onTap: () {
                                        openFile(file);
                                      },
                                      shareFolder: widget.path.isEmpty,
                                      multiSelectMode: multiSelectMode,
                                      selected: selectedFiles.contains(file),
                                      onLongPress: () {
                                        onFileLongPress(file);
                                      },
                                    );
                                  },
                                  itemCount: files.files!.length,
                                ),
                              )
                            : DraggableScrollbar.arrows(
                                scrollbarTimeToFade: Duration(seconds: 1),
                                controller: _fileScrollController,
                                backgroundColor: AppTheme.of(context)?.placeholderColor ?? Colors.black54,
                                child: GridView.builder(
                                  controller: _fileScrollController,
                                  padding: EdgeInsets.zero,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: context.width ~/ 80),
                                  itemBuilder: (context, i) {
                                    FileItem file = files.files![i];
                                    return FileGridItemWidget(
                                      file,
                                      onTap: () {
                                        openFile(file);
                                      },
                                      shareFolder: widget.path.isEmpty,
                                      multiSelectMode: multiSelectMode,
                                      selected: selectedFiles.contains(file),
                                      onLongPress: () {
                                        onFileLongPress(file);
                                      },
                                    );
                                  },
                                  itemCount: files.files!.length,
                                ),
                              )
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "$msg",
                              style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 200,
                              child: CupertinoButton(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(20),
                                onPressed: () {
                                  refresh();
                                },
                                child: Text(
                                  ' 刷新 ',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: getBackgroundTask,
      //   child: Icon(Icons.refresh),
      // ),
    );
  }
}
