import 'package:dsm_helper/pages/control_panel/task_scheduler/task_record.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskSchedulerManage extends StatefulWidget {
  @override
  _TaskSchedulerManageState createState() => _TaskSchedulerManageState();
}

class _TaskSchedulerManageState extends State<TaskSchedulerManage> {
  bool loading = true;
  List tasks = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var res = await Api.taskScheduler();
    if (res['success']) {
      setState(() {
        loading = false;
        tasks = res['data']['tasks'];
      });
    } else {
      Utils.toast("加载失败");
      Navigator.of(context).pop();
    }
  }

  Widget _buildTaskItem(task) {
    task['running'] = task['running'] ?? false;
    task['set'] = task['set'] ?? false;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Label(task['owner'], Colors.lightBlueAccent),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          task['name'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(task['app_name'] != null ? task['app_name'] : "用户定义的脚本"),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "下次：${task['type'] == 'script' ? task['next_trigger_time'] : (task['next_trigger_time'] == 'bootup' ? '开机' : task['next_trigger_time'] == 'shutdown' ? '关机' : task['next_trigger_time'])} ",
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    task['action'],
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      task['set'] = true;
                    });
                    var res = await Api.taskEnable(task['id'], !task['enable']);
                    setState(() {
                      task['set'] = false;
                    });
                    if (res['success']) {
                      setState(() {
                        task['enable'] = !task['enable'];
                      });
                    } else {
                      Utils.toast("操作失败，code：${res['error']['code']}");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(5),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: task['set']
                          ? CupertinoActivityIndicator()
                          : task['enable']
                              ? Icon(
                                  CupertinoIcons.checkmark_alt,
                                  color: Color(0xffff9813),
                                )
                              : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                if (task['type'] == 'script')
                  CupertinoButton(
                    onPressed: () async {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) {
                            return TaskRecord(task['id']);
                          },
                          settings: RouteSettings(name: "task_record")));
                    },
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    padding: EdgeInsets.all(5),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        CupertinoIcons.list_bullet,
                        color: Color(0xffff9813),
                        size: 16,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 5,
                ),
                CupertinoButton(
                  onPressed: () async {
                    if (task['running']) {
                      return;
                    }
                    setState(() {
                      task['running'] = true;
                    });
                    var res;
                    if (task['type'] == 'script') {
                      res = await Api.taskRun([task['id']]);
                    } else if (task['type'] == 'event_script') {
                      res = await Api.eventRun([task['name']]);
                    } else {
                      Utils.toast("暂不支持此类型任务");
                      return;
                    }

                    setState(() {
                      task['running'] = false;
                    });
                    if (res['success']) {
                      Utils.toast("任务计划执行成功");
                    } else {
                      Utils.toast("任务计划执行失败，code：${res['error']['code']}");
                    }
                  },
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  padding: EdgeInsets.all(5),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: task['running']
                        ? CupertinoActivityIndicator()
                        : Icon(
                            CupertinoIcons.play_arrow_solid,
                            color: Color(0xffff9813),
                            size: 16,
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("任务计划"),
      ),
      body: loading
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CupertinoActivityIndicator(
                    radius: 14,
                  ),
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemBuilder: (context, i) {
                return _buildTaskItem(tasks[i]);
              },
              itemCount: tasks.length,
            ),
    );
  }
}
