import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/file_icon.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class FileListItemWidget extends StatelessWidget {
  final FileItem file;
  final bool remote;
  final bool multiSelectMode;
  final bool selected;
  final Function()? onLongPress;
  final Function()? onTap;
  const FileListItemWidget(
    this.file, {
    this.remote = false,
    this.multiSelectMode = false,
    this.selected = false,
    this.onLongPress,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget actionButton = multiSelectMode
        ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(5),
            child: SizedBox(
              width: 20,
              height: 20,
              child: selected
                  ? Icon(
                      CupertinoIcons.checkmark_alt,
                      color: Color(0xffff9813),
                    )
                  : null,
            ),
          )
        : CupertinoButton(
            onPressed: () {
              // fileAction(file, remote: remote);
            },
            child: Image.asset(
              "assets/icons/more_horizontal.png",
              width: 20,
              height: 20,
            ),
          );
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: onLongPress,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Hero(
                tag: Api.dsm.baseUrl! + "/webapi/entry.cgi?path=${Uri.encodeComponent(file.path!)}&size=original&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${Api.dsm.sid!}&animate=true",
                child: FileIcon(
                  file.isdir == true ? FileTypeEnum.folder : file.fileType,
                  thumb: file.path!,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExtendedText(
                      file.name!,
                      style: TextStyle(fontSize: 16, color: file.additional?.mountPointType == "remotefail" ? AppTheme.of(context)?.placeholderColor : null),
                      overflowWidget: TextOverflowWidget(
                        position: TextOverflowPosition.middle,
                        align: TextOverflowAlign.right,
                        child: Text(
                          "…",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          if (file.additional != null || (file.additional?.time != null && file.additional?.time?.mtime != null))
                            TextSpan(
                              text: DateTime.fromMillisecondsSinceEpoch(file.additional!.time!.mtime! * 1000).format("Y/m/d H:i:s"),
                            ),
                          if (file.isdir == false) TextSpan(text: " · ${Utils.formatSize(file.additional!.size!, showByte: true)}"),
                        ],
                        style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.placeholderColor),
                      ),
                    ),
                    if (remote)
                      Text(
                        file.path!,
                        style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              actionButton,
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
