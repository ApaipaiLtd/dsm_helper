import 'package:dsm_helper/models/Syno/Core/SyslogClient/Log.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FileChangeLogWidget extends StatelessWidget {
  final SyslogClientLog fileLogs;
  const FileChangeLogWidget(this.fileLogs, {super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      icon: Image.asset(
        "assets/icons/file_change.png",
        width: 26,
        height: 26,
      ),
      title: "文件更改日志",
      body: SizedBox(
        height: 300,
        child: fileLogs.items != null && fileLogs.items!.isNotEmpty
            ? CupertinoScrollbar(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, i) {
                    return _buildFileLogItem(fileLogs.items![i]);
                  },
                  itemCount: fileLogs.items!.length,
                ),
              )
            : Center(
                child: Text(
                  "暂无日志",
                  style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                ),
              ),
      ),
    );
  }

  Widget _buildFileLogItem(SyslogClientLogItem log) {
    Map<String, IconData> icons = {
      "delete": Icons.delete,
      "copy": Icons.copy,
      "edit": Icons.edit,
      "move": Icons.drive_file_move_outline,
      "download": Icons.download_outlined,
      "upload": Icons.upload_outlined,
      "rename": Icons.drive_file_rename_outline,
      "write": Icons.edit,
      "create": Icons.add,
    };
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icons[log.cmd] ?? Icons.device_unknown,
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "${log.time}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Text(
            "${log.descr}",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
