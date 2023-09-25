import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/media_query_ext.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/file_icon.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class FileGridItemWidget extends StatelessWidget {
  final FileItem file;
  final bool remote;
  final bool multiSelectMode;
  final bool selected;
  final Function()? onLongPress;
  final Function()? onTap;
  const FileGridItemWidget(
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
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Text(
                    file.name!,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // if (multiSelectMode)
            //   Align(
            //     alignment: Alignment.topRight,
            //     child: Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: actionButton,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
