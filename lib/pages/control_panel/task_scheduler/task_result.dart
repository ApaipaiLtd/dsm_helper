import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskResult extends StatefulWidget {
  final int id;
  TaskResult(this.id);
  @override
  _TaskResultState createState() => _TaskResultState();
}

class _TaskResultState extends State<TaskResult> {
  List records = [];
  bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var res = await Api.taskRecord(widget.id);
    if (res['success']) {
      setState(() {
        loading = false;
        records = res['data'];
      });
    } else {
      Utils.toast("加载失败");
      Navigator.of(context).pop();
    }
  }

  Widget _buildRecordItem(record) {
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
                  Text(
                    "${record['start_time']} 至 ${record['stop_time']}",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "脚本：",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${record['script_in'].trim()}",
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      if (record['exit_type'] == 'normal') Label("正常", Colors.green) else Label("中断(${record['exit_code']})", Colors.red),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "标准输出/结果：",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${record['script_out'].trim()}",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
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
        title: Text("查看结果"),
      ),
      body: loading
          ? Center(
              child: LoadingWidget(size: 30),
            )
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemBuilder: (context, i) {
                return _buildRecordItem(records[i]);
              },
              itemCount: records.length,
            ),
    );
  }
}
