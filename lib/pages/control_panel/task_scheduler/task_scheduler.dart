import 'dart:ui';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_exception.dart';
import 'package:dsm_helper/models/Syno/Core/TaskScheduler.dart';
import 'package:dsm_helper/pages/control_panel/task_scheduler/dialogs/delete_task_dialog.dart';
import 'package:dsm_helper/pages/control_panel/task_scheduler/task_result.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/dot_widget.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class TaskSchedulerManage extends StatefulWidget {
  @override
  _TaskSchedulerManageState createState() => _TaskSchedulerManageState();
}

class _TaskSchedulerManageState extends State<TaskSchedulerManage> {
  bool loading = true;
  TaskScheduler taskScheduler = TaskScheduler();
  List tasks = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    try {
      taskScheduler = await TaskScheduler.list();
      setState(() {
        loading = false;
      });
    } catch (e) {
      Utils.toast("加载失败");
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("任务计划"),
      ),
      body: loading
          ? Center(
              child: LoadingWidget(
                size: 30,
              ),
            )
          : taskScheduler.tasks != null && taskScheduler.tasks!.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, i) {
                    return TaskSchedulerItem(
                      taskScheduler.tasks![i],
                      onRefresh: getData,
                    );
                  },
                  itemCount: taskScheduler.tasks!.length,
                )
              : EmptyWidget(text: "暂无计划任务"),
    );
  }
}

class TaskSchedulerItem extends StatefulWidget {
  final Tasks task;
  final Function()? onRefresh;
  const TaskSchedulerItem(this.task, {this.onRefresh, super.key});

  @override
  State<TaskSchedulerItem> createState() => _TaskSchedulerItemState();
}

class _TaskSchedulerItemState extends State<TaskSchedulerItem> {
  GlobalKey actionButtonKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.of(context)?.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${widget.task.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${widget.task.action}",
                      style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    DotWidget(
                      size: 10,
                      color: widget.task.enable == true ? AppTheme.of(context)?.successColor : AppTheme.of(context)?.placeholderColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "已${widget.task.enable == true ? '启用' : '禁用'}",
                      style: TextStyle(color: widget.task.enable == true ? AppTheme.of(context)?.successColor : AppTheme.of(context)?.placeholderColor, fontSize: 12),
                    ),
                    SizedBox(width: 10),
                    Label(widget.task.typeEnum.label, AppTheme.of(context)?.primaryColor ?? Colors.blue),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "下次运行：${widget.task.nextTriggerTime == 'bootup' ? '开机' : widget.task.nextTriggerTime == 'shutdown' ? '关机' : widget.task.nextTriggerTime}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0x7F000000), fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          CupertinoButton(
            onPressed: widget.task.canRun == true
                ? () async {
                    if (widget.task.running) {
                      return;
                    }
                    setState(() {
                      widget.task.running = true;
                    });
                    try {
                      bool? res = await widget.task.run();
                      if (res == true) {
                        Utils.vibrate(FeedbackType.success);
                        Utils.toast("任务计划执行成功");
                        widget.onRefresh?.call();
                      }
                    } on DsmException catch (e) {
                      if (e.code == -1) {
                        Utils.vibrate(FeedbackType.warning);
                        Utils.toast(e.message);
                      } else {
                        Utils.vibrate(FeedbackType.error);
                        Utils.toast("计划任务执行失败，代码：${e.code}");
                      }
                    }
                    setState(() {
                      widget.task.running = false;
                    });

                    // var res = await Api.taskRun([task.id!]);
                    // setState(() {
                    //   task.running = false;
                    // });
                    // if (res['success']) {
                    //   Utils.toast("任务计划执行成功");
                    // } else {
                    //   Utils.toast("任务计划执行失败，code：${res['error']['code']}");
                    // }
                  }
                : null,
            padding: EdgeInsets.zero,
            child: SizedBox(
              width: 30,
              height: 30,
              child: widget.task.running
                  ? LoadingWidget(
                      size: 24,
                    )
                  : Image.asset(
                      "assets/icons/play_circle_fill.png",
                      width: 30,
                      height: 30,
                    ),
            ),
          ),
          CupertinoButton(
            key: actionButtonKey,
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
                underStatusBar: true,
                underAppBar: true,
                needSafeDisplay: true,
                offsetX: 30,
                offsetY: -80,
                // curve: Curves.easeInSine,
                duration: Duration(milliseconds: 200),
                targetRenderBox: actionButtonKey.currentContext!.findRenderObject() as RenderBox,
                childFun: (pop) {
                  return BackdropFilter(
                    key: GlobalKey(),
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      width: 220,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      margin: EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // PopupMenuItem(
                          //   onTap: () {},
                          //   child: Row(
                          //     children: [
                          //       Image.asset(
                          //         "assets/icons/pencil.png",
                          //         width: 20,
                          //         height: 20,
                          //       ),
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //       Text("编辑"),
                          //     ],
                          //   ),
                          // ),
                          if (['script', 'event_script'].contains(widget.task.type))
                            PopupMenuItem(
                              onTap: () {
                                context.push(TaskResult(widget.task.id!), name: "task_record");
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/info_file.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("查看结果"),
                                ],
                              ),
                            ),
                          PopupMenuItem(
                            onTap: () async {
                              var hide = showWeuiLoadingToast(context: context);
                              try {
                                bool? res = await widget.task.setEnable();
                                if (res == true) {
                                  Utils.vibrate(FeedbackType.success);
                                  Utils.toast("${widget.task.enable == true ? '禁用' : '启用'}成功");
                                  widget.onRefresh?.call();
                                }
                              } catch (e) {}
                              hide();
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/${widget.task.enable == true ? 'close_circle' : 'check'}.png",
                                  width: 20,
                                  height: 20,
                                  color: widget.task.enable == true ? AppTheme.of(context)!.warningColor! : Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${widget.task.enable == true ? '禁用' : '启用'}",
                                  style: TextStyle(color: widget.task.enable == true ? AppTheme.of(context)?.warningColor : null),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () async {
                              bool? delete = await DeleteTaskDialog.show(context: context, task: widget.task);
                              if (delete == true) {
                                var hide = showWeuiLoadingToast(context: context);
                                try {
                                  bool? res = await widget.task.delete();
                                  if (res == true) {
                                    Utils.vibrate(FeedbackType.success);
                                    Utils.toast("删除成功");
                                    widget.onRefresh?.call();
                                  }
                                } catch (e) {}
                                hide();
                              }
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/delete.png",
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "删除",
                                  style: TextStyle(color: AppTheme.of(context)?.errorColor),
                                ),
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
            padding: EdgeInsets.zero,
            child: Image.asset(
              "assets/icons/more_vertical.png",
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
