import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/file_icon.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';

class FileGridItemWidget extends StatelessWidget {
  final FileItem file;
  final bool remote;
  final bool shareFolder;
  final bool multiSelectMode;
  final bool selected;
  final Function()? onLongPress;
  final Function()? onTap;
  const FileGridItemWidget(
    this.file, {
    this.remote = false,
    this.multiSelectMode = false,
    this.selected = false,
    this.shareFolder = false,
    this.onLongPress,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: onLongPress,
        onTap: onTap,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Hero(
                    tag: Api.dsm.baseUrl! + "/webapi/entry.cgi?path=${Uri.encodeComponent(file.path!)}&size=original&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${Api.dsm.sid!}&animate=true",
                    child: FileIcon(
                      file.isdir == true ? FileTypeEnum.folder : file.fileType,
                      thumb: file.path!,
                      size: 40,
                      thumbSize: 60,
                    ),
                  ),
                  ExtendedText(
                    file.name!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflowWidget: TextOverflowWidget(
                      position: TextOverflowPosition.middle,
                      align: TextOverflowAlign.right,
                      child: Text(
                        "…",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (multiSelectMode)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: selected ? AppTheme.of(context)?.primaryColor : Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  child: selected
                      ? Image.asset(
                          "assets/icons/check.png",
                          width: 13,
                          height: 13,
                        )
                      : null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
