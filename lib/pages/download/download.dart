import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:android_intent_plus/android_intent.dart';
import 'package:dsm_helper/pages/common/video_player.dart';
import 'package:dsm_helper/pages/download/download_setting.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/transparent_router.dart';
import 'package:dsm_helper/pages/common/image_preview.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/file_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class DownloadInfo {
//   String taskId;
//   DownloadTaskStatus status;
//   int progress;
//   String url;
//   String filename;
//   String savedDir;
//   int timeCreated;
//
//   DownloadInfo({@required this.taskId, @required this.status, @required this.progress, @required this.url, @required this.filename, @required this.savedDir, @required this.timeCreated});
//   factory DownloadInfo.formTask(DownloadTask task) {
//     return DownloadInfo(taskId: task.taskId, status: task.status, progress: task.progress, url: task.url, filename: task.filename, savedDir: task.savedDir, timeCreated: task.timeCreated);
//   }
//   @override
//   String toString() => "DownloadInfo(taskId: $taskId, status: $status, progress: $progress, url: $url, filename: $filename, savedDir: $savedDir, timeCreated: $timeCreated)";
// }

class Download extends StatefulWidget {
  Download({key}) : super(key: key);
  @override
  DownloadState createState() => DownloadState();
}

class DownloadState extends State<Download> {
  @override
  Widget build(BuildContext context) {
    return GlassScaffold();
  }
  // List<DownloadInfo> tasks = [];
  // bool loading = true;
  // List<DownloadInfo> selectedTasks = [];
  // Timer timer;
  // bool multiSelect = false;
  // String downloadPath = '';
  //
  // ReceivePort _receiverPort = ReceivePort();
  // @override
  // void initState() {
  //   Utils.getDownloadPath().then((value) {
  //     setState(() {
  //       downloadPath = value;
  //     });
  //   });
  //   _bindBackgroundIsolate();
  //   FlutterDownloader.registerCallback(downloadCallback, step: 1);
  //   getData();
  //   super.initState();
  // }
  //
  // static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  //   debugPrint('Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
  //   IsolateNameServer.lookupPortByName('downloader_send_port')?.send([id, status.value, progress]);
  // }
  //
  // void _bindBackgroundIsolate() {
  //   bool isSuccess = IsolateNameServer.registerPortWithName(_receiverPort.sendPort, 'downloader_send_port');
  //   if (!isSuccess) {
  //     _unbindBackgroundIsolate();
  //     _bindBackgroundIsolate();
  //     return;
  //   }
  //   _receiverPort.listen((dynamic data) {
  //     debugPrint('UI Isolate Callback: $data');
  //     String id = data[0];
  //     DownloadTaskStatus status = DownloadTaskStatus(data[1]);
  //     int progress = data[2];
  //
  //     if (tasks != null && tasks.isNotEmpty) {
  //       tasks.forEach((task) {
  //         if (task.taskId == id) {
  //           setState(() {
  //             task.status = status;
  //             task.progress = progress;
  //           });
  //         }
  //       });
  //     }
  //   });
  // }
  //
  // void _unbindBackgroundIsolate() {
  //   IsolateNameServer.removePortNameMapping('downloader_send_port');
  // }
  //
  // @override
  // void dispose() {
  //   _unbindBackgroundIsolate();
  //   super.dispose();
  // }
  //
  // getData() async {
  //   List<DownloadTask> downloadTasks = await FlutterDownloader.loadTasks();
  //   tasks = downloadTasks.map((e) => DownloadInfo.formTask(e)).toList();
  //   setState(() {
  //     loading = false;
  //   });
  //   // 如果存在下载中任务，每秒刷新一次
  //   if (tasks.where((task) => task.status == DownloadTaskStatus.running || task.status == DownloadTaskStatus.enqueued || task.status == DownloadTaskStatus.undefined).length > 0) {
  //     if (timer == null) {
  //       timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //         getData();
  //       });
  //     }
  //   } else {
  //     timer?.cancel();
  //   }
  // }
  //
  // Future<bool> onWillPop() {
  //   if (multiSelect) {
  //     setState(() {
  //       multiSelect = false;
  //       selectedTasks = [];
  //     });
  //   } else {
  //     debugPrint("可以返回");
  //     return Future.value(true);
  //   }
  //
  //   return Future.value(false);
  // }
  //
  // Widget _buildDownloadStatus(DownloadTaskStatus status, int progress) {
  //   if (status == DownloadTaskStatus.complete) {
  //     return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //       margin: EdgeInsets.only(bottom: 3),
  //       bevel: 0,
  //       decoration: BoxDecoration(
  //         color: Colors.lightGreen,
  //         borderRadius: BorderRadius.circular(4),
  //       ),
  //       child: Text(
  //         "下载完成",
  //         style: TextStyle(fontSize: 10, color: Colors.white),
  //       ),
  //     );
  //   } else if (status == DownloadTaskStatus.failed) {
  //     return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //       margin: EdgeInsets.only(bottom: 3),
  //       bevel: 0,
  //       decoration: BoxDecoration(
  //         color: Colors.redAccent,
  //         borderRadius: BorderRadius.circular(4),
  //       ),
  //       child: Text(
  //         "下载失败",
  //         style: TextStyle(fontSize: 10, color: Colors.white),
  //       ),
  //     );
  //   } else if (status == DownloadTaskStatus.canceled) {
  //     return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //       margin: EdgeInsets.only(bottom: 3),
  //       bevel: 0,
  //       decoration: BoxDecoration(
  //         color: Colors.redAccent,
  //         borderRadius: BorderRadius.circular(4),
  //       ),
  //       child: Text(
  //         "取消下载",
  //         style: TextStyle(fontSize: 10, color: Colors.white),
  //       ),
  //     );
  //   } else if (status == DownloadTaskStatus.paused) {
  //     return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //       margin: EdgeInsets.only(bottom: 3),
  //       bevel: 0,
  //       decoration: BoxDecoration(
  //         color: Colors.amber,
  //         borderRadius: BorderRadius.circular(4),
  //       ),
  //       child: Text(
  //         "暂停下载",
  //         style: TextStyle(fontSize: 10, color: Colors.white),
  //       ),
  //     );
  //   } else if (status == DownloadTaskStatus.running) {
  //     return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //       margin: EdgeInsets.only(bottom: 3),
  //       bevel: 0,
  //       decoration: BoxDecoration(
  //         color: Colors.lightBlueAccent,
  //         borderRadius: BorderRadius.circular(4),
  //       ),
  //       child: Text(
  //         "$progress%",
  //         style: TextStyle(fontSize: 10, color: Colors.white),
  //       ),
  //     );
  //   } else if (status == DownloadTaskStatus.enqueued) {
  //     return Container(
  //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  //       margin: EdgeInsets.only(bottom: 3),
  //       bevel: 0,
  //       decoration: BoxDecoration(
  //         color: Colors.redAccent,
  //         borderRadius: BorderRadius.circular(4),
  //       ),
  //       child: Text(
  //         "等待下载",
  //         style: TextStyle(fontSize: 10, color: Colors.white),
  //       ),
  //     );
  //   } else {
  //     return Container();
  //   }
  // }
  //
  // Widget _buildTaskItem(DownloadInfo task) {
  //   FileTypeEnum fileType = Utils.fileType(task.filename);
  //   // String path = file['path'];
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20, right: 20),
  //     child: CupertinoButton(
  //       onLongPress: () {
  //         Utils.vibrate(FeedbackType.light);
  //         setState(() {
  //           multiSelect = true;
  //           selectedTasks.add(task);
  //         });
  //       },
  //       onPressed: () async {
  //         // print(task.savedDir + "/" + task.filename);
  //         // return;
  //         if (multiSelect) {
  //           setState(() {
  //             if (selectedTasks.contains(task)) {
  //               selectedTasks.remove(task);
  //             } else {
  //               selectedTasks.add(task);
  //             }
  //           });
  //         } else {
  //           if (fileType == FileTypeEnum.image) {
  //             //获取当前目录全部图片文件
  //             List<String> images = [];
  //             int index = 0;
  //             for (int i = 0; i < tasks.length; i++) {
  //               if (task.status == DownloadTaskStatus.complete && Utils.fileType(task.filename) == FileTypeEnum.image) {
  //                 images.add(tasks[i].savedDir + "/" + tasks[i].filename);
  //                 if (tasks[i] == task) {
  //                   index = images.length - 1;
  //                 }
  //               }
  //             }
  //             Navigator.of(context).push(TransparentPageRoute(
  //                 pageBuilder: (context, _, __) {
  //                   return ImagePreview(
  //                     images,
  //                     index,
  //                     network: false,
  //                   );
  //                 },
  //                 settings: RouteSettings(name: "preview_image")));
  //           } else if (fileType == FileTypeEnum.movie) {
  //             String videoPlayer = await Utils.getStorage("video_player");
  //             debugPrint(videoPlayer);
  //             if (videoPlayer != null && videoPlayer == '1') {
  //               AndroidIntent intent = AndroidIntent(
  //                 action: 'action_view',
  //                 data: task.savedDir + "/" + task.filename,
  //                 arguments: {},
  //                 type: "video/*",
  //               );
  //               await intent.launch();
  //             } else {
  //               Navigator.of(context).push(
  //                 CupertinoPageRoute(
  //                     builder: (context) {
  //                       return VideoPlayer(
  //                         url: task.savedDir + "/" + task.filename,
  //                         name: task.filename,
  //                       );
  //                     },
  //                     settings: RouteSettings(name: "preview_image")),
  //               );
  //             }
  //           } else {
  //             var result = await FlutterDownloader.open(taskId: task.taskId);
  //             if (!result) {
  //               Utils.toast("不支持打开此文件");
  //             }
  //           }
  //         }
  //       },
  //       // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //       padding: EdgeInsets.symmetric(vertical: 20),
  //       decoration: BoxDecoration(
  //         color: Theme.of(context).scaffoldBackgroundColor,
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       bevel: 8,
  //       child: Row(
  //         children: [
  //           SizedBox(
  //             width: 20,
  //           ),
  //           Hero(
  //             tag: task.savedDir + "/" + task.filename,
  //             child: FileIcon(
  //               fileType,
  //               thumb: fileType == FileTypeEnum.image && task.status == DownloadTaskStatus.complete ? task.savedDir + "/" + task.filename : null,
  //               network: false,
  //             ),
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   task.filename,
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   DateTime.fromMillisecondsSinceEpoch(task.timeCreated).format("Y/m/d H:i:s"),
  //                   style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.headline5.color),
  //                 ),
  //                 SizedBox(
  //                   height: 5,
  //                 ),
  //                 _buildDownloadStatus(task.status, task.progress),
  //               ],
  //             ),
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           multiSelect
  //               ? Container(
  //                   decoration: BoxDecoration(
  //                     color: Theme.of(context).scaffoldBackgroundColor,
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   curveType: selectedTasks.contains(task) ? CurveType.emboss : CurveType.flat,
  //                   padding: EdgeInsets.all(5),
  //
  //                   child: SizedBox(
  //                     width: 20,
  //                     height: 20,
  //                     child: selectedTasks.contains(task)
  //                         ? Icon(
  //                             CupertinoIcons.checkmark_alt,
  //                             color: Color(0xffff9813),
  //                           )
  //                         : null,
  //                   ),
  //                 )
  //               : CupertinoButton(
  //                   onPressed: () {
  //                     showCupertinoModalPopup(
  //                       context: context,
  //                       builder: (context) {
  //                         return Material(
  //                           color: Colors.transparent,
  //                           child: Container(
  //                             width: double.infinity,
  //                             padding: EdgeInsets.all(22),
  //
  //                             curveType: CurveType.emboss,
  //                             decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
  //                             child: SafeArea(
  //                               top: false,
  //                               child: Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 children: <Widget>[
  //                                   Text(
  //                                     "选择操作",
  //                                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 22,
  //                                   ),
  //                                   if (task.status == DownloadTaskStatus.failed)
  //                                     CupertinoButton(
  //                                       onPressed: () async {
  //                                         Navigator.of(context).pop();
  //                                         await FlutterDownloader.retry(taskId: task.taskId);
  //                                         await getData();
  //                                       },
  //                                       decoration: BoxDecoration(
  //                                         color: Theme.of(context).scaffoldBackgroundColor,
  //                                         borderRadius: BorderRadius.circular(25),
  //                                       ),
  //
  //                                       padding: EdgeInsets.symmetric(vertical: 10),
  //                                       child: Text(
  //                                         "重试",
  //                                         style: TextStyle(fontSize: 18),
  //                                       ),
  //                                     ),
  //                                   if (task.status == DownloadTaskStatus.running)
  //                                     CupertinoButton(
  //                                       onPressed: () async {
  //                                         Navigator.of(context).pop();
  //                                         await FlutterDownloader.pause(taskId: task.taskId);
  //                                         await getData();
  //                                       },
  //                                       decoration: BoxDecoration(
  //                                         color: Theme.of(context).scaffoldBackgroundColor,
  //                                         borderRadius: BorderRadius.circular(25),
  //                                       ),
  //
  //                                       padding: EdgeInsets.symmetric(vertical: 10),
  //                                       child: Text(
  //                                         "暂停",
  //                                         style: TextStyle(fontSize: 18),
  //                                       ),
  //                                     ),
  //                                   if (task.status == DownloadTaskStatus.paused)
  //                                     CupertinoButton(
  //                                       onPressed: () async {
  //                                         Navigator.of(context).pop();
  //                                         debugPrint(task.taskId);
  //                                         var res = await FlutterDownloader.resume(taskId: task.taskId);
  //                                         debugPrint(res);
  //                                         await getData();
  //                                       },
  //                                       decoration: BoxDecoration(
  //                                         color: Theme.of(context).scaffoldBackgroundColor,
  //                                         borderRadius: BorderRadius.circular(25),
  //                                       ),
  //
  //                                       padding: EdgeInsets.symmetric(vertical: 10),
  //                                       child: Text(
  //                                         "继续下载",
  //                                         style: TextStyle(fontSize: 18),
  //                                       ),
  //                                     ),
  //                                   if ([DownloadTaskStatus.paused, DownloadTaskStatus.running, DownloadTaskStatus.failed].contains(task.status))
  //                                     SizedBox(
  //                                       height: 16,
  //                                     ),
  //                                   CupertinoButton(
  //                                     onPressed: () async {
  //                                       Navigator.of(context).pop();
  //                                       Utils.vibrate(FeedbackType.warning);
  //                                       showCupertinoModalPopup(
  //                                         context: context,
  //                                         builder: (context) {
  //                                           return Material(
  //                                             color: Colors.transparent,
  //                                             child: Container(
  //                                               width: double.infinity,
  //                                               padding: EdgeInsets.all(22),
  //
  //                                               curveType: CurveType.emboss,
  //                                               decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
  //                                               child: SafeArea(
  //                                                 top: false,
  //                                                 child: Column(
  //                                                   mainAxisSize: MainAxisSize.min,
  //                                                   children: <Widget>[
  //                                                     Text(
  //                                                       "确认删除",
  //                                                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  //                                                     ),
  //                                                     SizedBox(
  //                                                       height: 12,
  //                                                     ),
  //                                                     Text(
  //                                                       "确认要删除文件？",
  //                                                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
  //                                                     ),
  //                                                     SizedBox(
  //                                                       height: 22,
  //                                                     ),
  //                                                     CupertinoButton(
  //                                                       onPressed: () async {
  //                                                         Navigator.of(context).pop();
  //                                                         await FlutterDownloader.remove(taskId: task.taskId, shouldDeleteContent: true);
  //                                                         await getData();
  //                                                       },
  //                                                       decoration: BoxDecoration(
  //                                                         color: Theme.of(context).scaffoldBackgroundColor,
  //                                                         borderRadius: BorderRadius.circular(25),
  //                                                       ),
  //
  //                                                       padding: EdgeInsets.symmetric(vertical: 10),
  //                                                       child: Text(
  //                                                         "同时删除已下载文件",
  //                                                         style: TextStyle(fontSize: 18, color: Colors.redAccent),
  //                                                       ),
  //                                                     ),
  //                                                     SizedBox(
  //                                                       height: 22,
  //                                                     ),
  //                                                     Row(
  //                                                       children: [
  //                                                         Expanded(
  //                                                           child: CupertinoButton(
  //                                                             onPressed: () async {
  //                                                               Navigator.of(context).pop();
  //                                                               await FlutterDownloader.remove(taskId: task.taskId, shouldDeleteContent: false);
  //                                                               await getData();
  //                                                             },
  //                                                             decoration: BoxDecoration(
  //                                                               color: Theme.of(context).scaffoldBackgroundColor,
  //                                                               borderRadius: BorderRadius.circular(25),
  //                                                             ),
  //
  //                                                             padding: EdgeInsets.symmetric(vertical: 10),
  //                                                             child: Text(
  //                                                               "确认删除",
  //                                                               style: TextStyle(fontSize: 18, color: Colors.redAccent),
  //                                                             ),
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(
  //                                                           width: 20,
  //                                                         ),
  //                                                         Expanded(
  //                                                           child: CupertinoButton(
  //                                                             onPressed: () async {
  //                                                               Navigator.of(context).pop();
  //                                                             },
  //                                                             decoration: BoxDecoration(
  //                                                               color: Theme.of(context).scaffoldBackgroundColor,
  //                                                               borderRadius: BorderRadius.circular(25),
  //                                                             ),
  //
  //                                                             padding: EdgeInsets.symmetric(vertical: 10),
  //                                                             child: Text(
  //                                                               "取消",
  //                                                               style: TextStyle(fontSize: 18),
  //                                                             ),
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                     SizedBox(
  //                                                       height: 8,
  //                                                     ),
  //                                                   ],
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           );
  //                                         },
  //                                       );
  //                                     },
  //                                     decoration: BoxDecoration(
  //                                       color: Theme.of(context).scaffoldBackgroundColor,
  //                                       borderRadius: BorderRadius.circular(25),
  //                                     ),
  //
  //                                     padding: EdgeInsets.symmetric(vertical: 10),
  //                                     child: Text(
  //                                       "删除",
  //                                       style: TextStyle(fontSize: 18, color: Colors.redAccent),
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 16,
  //                                   ),
  //                                   CupertinoButton(
  //                                     onPressed: () async {
  //                                       Navigator.of(context).pop();
  //                                     },
  //                                     decoration: BoxDecoration(
  //                                       color: Theme.of(context).scaffoldBackgroundColor,
  //                                       borderRadius: BorderRadius.circular(25),
  //                                     ),
  //
  //                                     padding: EdgeInsets.symmetric(vertical: 10),
  //                                     child: Text(
  //                                       "取消",
  //                                       style: TextStyle(fontSize: 18),
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 8,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                     );
  //                   },
  //                   padding: EdgeInsets.only(left: 5, right: 3, top: 4, bottom: 4),
  //                   decoration: BoxDecoration(
  //                     color: Theme.of(context).scaffoldBackgroundColor,
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   bevel: 2,
  //                   child: Icon(
  //                     CupertinoIcons.right_chevron,
  //                     size: 18,
  //                   ),
  //                 ),
  //           SizedBox(
  //             width: 20,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       leading: multiSelect
  //           ? GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   multiSelect = false;
  //                   selectedTasks = [];
  //                 });
  //               },
  //               child: Icon(Icons.close),
  //             )
  //           : null,
  //       title: Column(
  //         children: [
  //           Text(
  //             "下载",
  //           ),
  //           if (Platform.isAndroid)
  //             Text(
  //               downloadPath,
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //         ],
  //       ),
  //       actions: [
  //         if (multiSelect)
  //           Padding(
  //             padding: EdgeInsets.only(right: 10, top: 8, bottom: 8),
  //             child: CupertinoButton(
  //               decoration: BoxDecoration(
  //                 color: Theme.of(context).scaffoldBackgroundColor,
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               padding: EdgeInsets.all(10),
  //
  //               onPressed: () {
  //                 if (selectedTasks.length == tasks.length) {
  //                   selectedTasks = [];
  //                 } else {
  //                   selectedTasks = [];
  //                   tasks.forEach((task) {
  //                     selectedTasks.add(task);
  //                   });
  //                 }
  //
  //                 setState(() {});
  //               },
  //               child: Image.asset(
  //                 "assets/icons/select_all.png",
  //                 width: 20,
  //                 height: 20,
  //               ),
  //             ),
  //           ),
  //         if (Platform.isAndroid)
  //           Padding(
  //             padding: EdgeInsets.only(right: 10, top: 8, bottom: 8),
  //             child: CupertinoButton(
  //               decoration: BoxDecoration(
  //                 color: Theme.of(context).scaffoldBackgroundColor,
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               padding: EdgeInsets.all(10),
  //
  //               onPressed: () {
  //                 Navigator.of(context).push(
  //                   CupertinoPageRoute(
  //                     builder: (context) {
  //                       return DownloadSetting();
  //                     },
  //                     settings: RouteSettings(name: "download_setting"),
  //                   ),
  //                 );
  //               },
  //               child: Image.asset(
  //                 "assets/icons/setting.png",
  //                 width: 20,
  //                 height: 20,
  //               ),
  //             ),
  //           ),
  //       ],
  //     ),
  //     body: loading
  //         ? Center(
  //             child: CupertinoActivityIndicator(),
  //           )
  //         : tasks.length > 0
  //             ? Stack(
  //                 children: [
  //                   ListView.builder(
  //                     itemCount: tasks.length,
  //                     itemBuilder: (context, i) {
  //                       return _buildTaskItem(tasks.reversed.toList()[i]);
  //                     },
  //                   ),
  //                   AnimatedPositioned(
  //                     bottom: selectedTasks.length > 0 ? 0 : -100,
  //                     duration: Duration(milliseconds: 200),
  //                     child: Container(
  //                       margin: EdgeInsets.all(20),
  //                       padding: EdgeInsets.all(10),
  //                       width: MediaQuery.of(context).size.width - 40,
  //                       height: 62,
  //
  //
  //                       decoration: BoxDecoration(
  //                         color: Theme.of(context).scaffoldBackgroundColor,
  //                         borderRadius: BorderRadius.circular(20),
  //                       ),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                         children: [
  //                           GestureDetector(
  //                             onTap: () async {
  //                               Utils.vibrate(FeedbackType.warning);
  //                               showCupertinoModalPopup(
  //                                 context: context,
  //                                 builder: (context) {
  //                                   return Material(
  //                                     color: Colors.transparent,
  //                                     child: Container(
  //                                       width: double.infinity,
  //                                       padding: EdgeInsets.all(22),
  //
  //                                       curveType: CurveType.emboss,
  //                                       decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
  //                                       child: SafeArea(
  //                                         top: false,
  //                                         child: Column(
  //                                           mainAxisSize: MainAxisSize.min,
  //                                           children: <Widget>[
  //                                             Text(
  //                                               "确认删除",
  //                                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  //                                             ),
  //                                             SizedBox(
  //                                               height: 12,
  //                                             ),
  //                                             Text(
  //                                               "确认要删除${selectedTasks.length}个下载任务？",
  //                                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
  //                                             ),
  //                                             SizedBox(
  //                                               height: 22,
  //                                             ),
  //                                             Row(
  //                                               children: [
  //                                                 Expanded(
  //                                                   child: CupertinoButton(
  //                                                     onPressed: () async {
  //                                                       Navigator.of(context).pop();
  //                                                       for (DownloadInfo task in selectedTasks) {
  //                                                         await FlutterDownloader.remove(taskId: task.taskId, shouldDeleteContent: true);
  //                                                       }
  //                                                       getData();
  //                                                       setState(() {
  //                                                         multiSelect = false;
  //                                                         selectedTasks = [];
  //                                                       });
  //                                                     },
  //                                                     decoration: BoxDecoration(
  //                                                       color: Theme.of(context).scaffoldBackgroundColor,
  //                                                       borderRadius: BorderRadius.circular(25),
  //                                                     ),
  //
  //                                                     padding: EdgeInsets.symmetric(vertical: 10),
  //                                                     child: Text(
  //                                                       "确认删除",
  //                                                       style: TextStyle(fontSize: 18, color: Colors.redAccent),
  //                                                     ),
  //                                                   ),
  //                                                 ),
  //                                                 SizedBox(
  //                                                   width: 20,
  //                                                 ),
  //                                                 Expanded(
  //                                                   child: CupertinoButton(
  //                                                     onPressed: () async {
  //                                                       Navigator.of(context).pop();
  //                                                     },
  //                                                     decoration: BoxDecoration(
  //                                                       color: Theme.of(context).scaffoldBackgroundColor,
  //                                                       borderRadius: BorderRadius.circular(25),
  //                                                     ),
  //
  //                                                     padding: EdgeInsets.symmetric(vertical: 10),
  //                                                     child: Text(
  //                                                       "取消",
  //                                                       style: TextStyle(fontSize: 18),
  //                                                     ),
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             SizedBox(
  //                                               height: 8,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   );
  //                                 },
  //                               );
  //                             },
  //                             child: Column(
  //                               children: [
  //                                 Image.asset(
  //                                   "assets/icons/delete.png",
  //                                   width: 25,
  //                                 ),
  //                                 Text(
  //                                   "删除",
  //                                   style: TextStyle(fontSize: 12),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             : Center(
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Text(
  //                       "暂无下载任务",
  //                       style: TextStyle(color: AppTheme.of(context).placeholderColor),
  //                     ),
  //                     SizedBox(
  //                       height: 5,
  //                     ),
  //                     Text(
  //                       "可在[文件]中点击文件右侧 > 将文件下载到手机",
  //                       style: TextStyle(fontSize: 12, color: Colors.grey),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //   );
  // }
}
