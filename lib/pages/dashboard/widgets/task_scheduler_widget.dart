import 'package:dsm_helper/models/Syno/Core/TaskScheduler.dart';
import 'package:dsm_helper/pages/control_panel/task_scheduler/task_scheduler.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskSchedulerWidget extends StatelessWidget {
  final TaskScheduler taskScheduler;
  const TaskSchedulerWidget(this.taskScheduler, {super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
          return TaskSchedulerManage();
        }));
      },
      title: "计划任务",
      // icon: Image.asset(
      //   "assets/icons/task.png",
      //   width: 26,
      //   height: 26,
      // ),
      body: Column(
        children: taskScheduler.tasks!.map((task) => TaskSchedulerItem(task)).toList(),
      ),
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
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
                  style: TextStyle(color: Color(0x7F000000), fontSize: 12),
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
            padding: EdgeInsets.all(5),
            child: SizedBox(
              width: 30,
              height: 30,
              child: widget.task.running
                  ? CupertinoActivityIndicator()
                  : Image.asset(
                      "assets/icons/play_fill.png",
                      width: 30,
                      height: 30,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
