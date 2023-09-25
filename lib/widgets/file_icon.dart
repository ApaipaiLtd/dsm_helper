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
  final double width;
  final double height;
  final BoxFit fit;
  FileIcon(this.fileType, {this.thumb, this.network = true, this.width = 40, this.height = 40, this.fit = BoxFit.contain});
  @override
  Widget build(BuildContext context) {
    if (fileType == FileTypeEnum.movie && thumb != null) {
      return network
          ? CupertinoExtendedImage(
              api.Api.dsm.baseUrl! + "/webapi/entry.cgi?path=${Uri.encodeComponent(thumb!)}&size=medium&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${api.Api.dsm.sid!}&animate=true",
              width: width,
              height: height,
              fit: fit,
              placeholder: Container(
                width: 40,
                height: 60,
                alignment: Alignment.center,
                child: Image.asset(fileType.icon, width: 40, height: 60),
              ),
            )
          : ExtendedImage.file(
              File(thumb!),
              width: width,
              height: height,
              fit: fit,
            );
    } else if (fileType == FileTypeEnum.image && thumb != null) {
      return network
          ? CupertinoExtendedImage(
              api.Api.dsm.baseUrl! + "/webapi/entry.cgi?path=${Uri.encodeComponent(thumb!)}&size=small&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${api.Api.dsm.sid!}&animate=true",
              width: width,
              height: height,
              fit: fit,
              placeholder: Container(
                width: 40,
                height: 60,
                alignment: Alignment.center,
                child: Image.asset(fileType.icon, width: 40, height: 60),
              ),
            )
          : ExtendedImage.file(File(thumb!), width: width, height: height, fit: fit);
    } else {
      return Image.asset(fileType.icon, width: 40, height: 60);
    }
  }
}
