import 'package:dsm_helper/pages/transfer/bus/download_file_bus.dart';
import 'package:dsm_helper/utils/bus/bus.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:background_downloader/background_downloader.dart';

class DownloadTab extends StatefulWidget {
  const DownloadTab({super.key});

  @override
  State<DownloadTab> createState() => _DownloadTabState();
}

class _DownloadTabState extends State<DownloadTab> {
  List<TaskRecord> downloads = [];
  FileDownloader downloader = FileDownloader();
  @override
  void initState() {
    initDownloader();

    bus.on<DownloadFileEvent>().listen((event) async {
      print(event.task.filename);
      // setState(() {
      //   downloads.add(event.task);
      // });
      await downloader.enqueue(event.task);
      getDownloadTasks();
    });
    super.initState();
  }

  initDownloader() async {
    await downloader.trackTasks();
    getDownloadTasks();
    downloader
        .registerCallbacks(taskNotificationTapCallback: myNotificationTapCallback)
        .configureNotificationForGroup(
          FileDownloader.defaultGroup,
          // For the main download button
          // which uses 'enqueue' and a default group
          // {filename} {displayName} {progress} {networkSpeed} {timeRemaining} {metadata}
          running: const TaskNotification('{filename}', '{progress} - {networkSpeed}  剩余{timeRemaining}'),
          complete: const TaskNotification('{filename}', '下载完成'),
          error: const TaskNotification('{filename}', '下载失败'),
          paused: const TaskNotification('{filename}', '暂停下载'),
          progressBar: true,
        )
        .configureNotification(
          // for the 'Download & Open' dog picture
          // which uses 'download' which is not the .defaultGroup
          // but the .await group so won't use the above config
          running: const TaskNotification('{filename}', '{progress} - {networkSpeed}  剩余{timeRemaining}'),
          complete: const TaskNotification('{filename}', '下载完成'),
          error: const TaskNotification('{filename}', '下载失败'),
          paused: const TaskNotification('{filename}', '暂停下载'),
          tapOpensFile: true,
        ); // dog can also open directly from tap
    downloader.updates.listen((update) {
      // print(update.status);
      getDownloadTasks();
      switch (update) {
        case TaskStatusUpdate _:
          // process the TaskStatusUpdate, e.g.
          switch (update.status) {
            case TaskStatus.complete:
              print('Task ${update.task.taskId} success!');

            case TaskStatus.canceled:
              print('Download was canceled');

            case TaskStatus.paused:
              print('Download was paused');

            default:
              print('Download not successful');
          }

        case TaskProgressUpdate _:
          // process the TaskProgressUpdate, e.g.
          print("${update.task.filename}: ${update.progress * 100}% ${update.networkSpeedAsString} ${update.task.creationTime} 剩余：${update.timeRemainingAsString}");
        // update.networkSpeed;
      }
    });
  }

  void myNotificationTapCallback(Task task, NotificationType notificationType) {
    debugPrint('Tapped notification $notificationType for taskId ${task.taskId}');
  }

  getDownloadTasks() async {
    downloads = await downloader.database.allRecords();
    print(downloads);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return downloads.isEmpty
        ? Column(
            children: [
              EmptyWidget(
                text: "暂无下载任务",
              ),
              CupertinoButton(
                  child: Text("加载"),
                  onPressed: () {
                    getDownloadTasks();
                  })
            ],
          )
        : ListView.builder(
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () async {
                  TaskRecord? taskRecord = await downloader.database.recordForId(downloads[i].taskId);
                  List<TaskRecord>? taskRecords = await downloader.database.allRecords();
                  print(taskRecord?.toJsonMap());
                  print(taskRecords);
                },
                child: Container(
                  child: Column(
                    children: [
                      Text(downloads[i].task.displayName),
                      Text(downloads[i].status.name),
                      Text("进度：${downloads[i].progress}"),
                      Text(Utils.formatSize(downloads[i].expectedFileSize)),
                    ],
                  ),
                ),
              );
            },
            itemCount: downloads.length,
          );
  }
}
