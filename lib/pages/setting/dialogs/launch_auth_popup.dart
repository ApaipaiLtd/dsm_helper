import 'dart:ui';

import 'package:dsm_helper/utils/extensions/media_query_ext.dart';
import 'package:dsm_helper/widgets/button.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaunchAuthPopup {
  static show(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      // barrierColor: Colors.black12,
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "安全启动",
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 100,
                        maxHeight: context.height * 0.8,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // if ((smbFolders + ftpFolders + sftpFolders + davFolders).length > 0) ...[
                            //   ...(smbFolders + ftpFolders + sftpFolders + davFolders).map((folder) {
                            //     return FileListItemWidget(folder, remote: true);
                            //   }).toList(),
                            // ] else
                            EmptyWidget(
                              size: 150,
                              text: "未挂载远程文件夹",
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Button(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      color: Theme.of(context).disabledColor,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "关闭",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 8,
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
}
