import 'package:dsm_helper/extensions/list.dart';
import 'package:dsm_helper/models/Syno/Core/TaskScheduler.dart';
import 'package:dsm_helper/pages/control_panel/task_scheduler/task_scheduler.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/providers/setting.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskSchedulerWidget extends StatefulWidget {
  const TaskSchedulerWidget({super.key});

  @override
  State<TaskSchedulerWidget> createState() => _TaskSchedulerWidgetState();
}

class _TaskSchedulerWidgetState extends State<TaskSchedulerWidget> {
  bool loading = true;
  bool error = false;
  TaskScheduler taskScheduler = TaskScheduler();
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData({bool loop = true}) async {
    try {
      taskScheduler = await TaskScheduler.list();
      setState(() {
        loading = false;
      });
    } catch (e) {
      // 如果首次加载失败，则显示错误信息，否则不显示
      if (loading) {
        setState(() {
          error = true;
        });
      }
    }
    if (loop && mounted) {
      int refreshDuration = context.read<SettingProvider>().refreshDuration;
      Future.delayed(Duration(seconds: refreshDuration)).then((_) {
        getData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    late Widget cardBody;
    if (loading) {
      cardBody = SizedBox(height: 100, child: Center(child: LoadingWidget(size: 30)));
    } else if (error) {
      cardBody = EmptyWidget(
        text: "数据加载失败",
        size: 100,
      );
    } else {
      List<Widget> children = taskScheduler.tasks?.map((task) => TaskSchedulerItem(task)).toList() ?? [];
      if (children.isEmpty) {
        cardBody = EmptyWidget(
          text: "暂无计划任务",
          size: 100,
        );
      } else {
        cardBody = Column(
          children: children.expand((element) => [element, if (element != children.last) Divider()]).toList(),
        );
      }
    }
    return WidgetCard(
      title: "任务计划",
      // icon: Image.asset(
      //   "assets/icons/task.png",
      //   width: 26,
      //   height: 26,
      // ),
      body: cardBody,
    );
  }
}

class TaskSchedulerItem extends StatefulWidget {
  final Tasks task;
  const TaskSchedulerItem(this.task, {super.key});

  @override
  State<TaskSchedulerItem> createState() => _TaskSchedulerItemState();
}

class _TaskSchedulerItemState extends State<TaskSchedulerItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.task.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "${widget.task.nextTriggerTime}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0x7F000000), fontSize: 14),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        CupertinoButton(
          onPressed: () async {
            if (widget.task.running) {
              return;
            }
            setState(() {
              widget.task.running = true;
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
          },
          padding: EdgeInsets.zero,
          child: SizedBox(
            width: 30,
            height: 30,
            child: widget.task.running
                ? CupertinoActivityIndicator()
                : Image.asset(
                    "assets/icons/play_circle_fill.png",
                    width: 30,
                    height: 30,
                  ),
          ),
        ),
      ],
    );
  }
}
