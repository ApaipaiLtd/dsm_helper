import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/widgets/button.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/glass/glass_modal_popup.dart';
import 'package:dsm_helper/widgets/glass/popup_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RemoteFolderPopupContent extends StatefulWidget {
  const RemoteFolderPopupContent({super.key});

  @override
  State<RemoteFolderPopupContent> createState() => _RemoteFolderPopupContentState();
}

class _RemoteFolderPopupContentState extends State<RemoteFolderPopupContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        PopupHeader(
          title: "远程文件夹",
          action: CupertinoButton(
            onPressed: () async {
              // Utils.toast("重新加载远程连接中");
              // Navigator.of(context).pop();
              // getFtpFolder();
              // getSftpFolder();
              // getSmbFolder();
              // getDavFolder();
            },
            padding: EdgeInsets.all(5),
            minSize: 0,
            child: Icon(
              Icons.refresh,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: EmptyWidget(
            text: "未装载远程文件夹",
          ),
        ),
      ],
    );
  }
}

class RemoteFolderPopup {
  static show({required BuildContext context}) {
    showGlassModalPopup(context, content: RemoteFolderPopupContent(), buttons: [
      Button(
        onPressed: () async {
          context.pop();
        },
        color: Theme.of(context).disabledColor,
        child: Text("关闭"),
      ),
    ]);
  }
}
