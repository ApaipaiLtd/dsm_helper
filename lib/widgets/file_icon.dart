import 'dart:io';

import 'package:dsm_helper/pages/file/enums/file_type_enums.dart';
import 'package:dsm_helper/widgets/cupertino_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:dsm_helper/apis/api.dart' as api;

class FileIcon extends StatelessWidget {
  final FileTypeEnum fileType;
  final String? thumb;
  final bool network;
  final double size;
  final double thumbSize;
  final BoxFit fit;
  FileIcon(this.fileType, {this.thumb, this.network = true, this.size = 40, this.thumbSize = 40, this.fit = BoxFit.contain});
  @override
  Widget build(BuildContext context) {
    if ([FileTypeEnum.movie, FileTypeEnum.image].contains(fileType) && thumb != null) {
      return network
          ? CupertinoExtendedImage(
              api.Api.dsm.baseUrl! + "/webapi/entry.cgi?path=${Uri.encodeComponent(thumb!)}&size=small&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${api.Api.dsm.sid!}&animate=true",
              width: thumbSize,
              height: thumbSize,
              fit: fit,
              placeholder: Container(width: thumbSize, height: thumbSize, alignment: Alignment.center, child: Image.asset(fileType.icon, width: size, height: size)),
            )
          : ExtendedImage.file(
              File(thumb!),
              width: thumbSize,
              height: thumbSize,
              fit: fit,
            );
    } else {
      return Container(width: thumbSize, height: thumbSize, alignment: Alignment.center, child: Image.asset(fileType.icon, width: size, height: size));
    }
  }
}
