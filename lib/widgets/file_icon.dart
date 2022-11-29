import 'dart:io';

import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/cupertino_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class FileIcon extends StatelessWidget {
  final FileTypeEnum fileType;
  final String thumb;
  final bool network;
  final double width;
  final double height;
  final BoxFit fit;
  FileIcon(this.fileType, {this.thumb, this.network: true, this.width: 40, this.height: 40, this.fit: BoxFit.contain});
  @override
  Widget build(BuildContext context) {
    if (fileType == FileTypeEnum.folder) {
      return Image.asset(
        "assets/icons/folder.png",
        width: 40,
        height: 60,
      );
    } else if (fileType == FileTypeEnum.music) {
      return Image.asset(
        "assets/icons/music.png",
        width: 40,
        height: 60,
      );
    } else if (fileType == FileTypeEnum.movie) {
      print(thumb);
      return thumb == null
          ? Image.asset(
              "assets/icons/movie.png",
              width: 40,
              height: 60,
            )
          : network
              ? CupertinoExtendedImage(
                  Util.baseUrl + "/webapi/entry.cgi?path=${Uri.encodeComponent(thumb)}&size=medium&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${Util.sid}&animate=true",
                  width: width,
                  height: height,
                  fit: fit,
                  placeholder: Container(
                    width: 40,
                    height: 60,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/icons/movie.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                )
              : ExtendedImage.file(
                  File(thumb),
                  width: width,
                  height: height,
                  fit: fit,
                );
    } else if (fileType == FileTypeEnum.image) {
      return thumb == null
          ? Image.asset(
              "assets/icons/image.png",
              width: 40,
              height: 60,
            )
          : network
              ? CupertinoExtendedImage(
                  Util.baseUrl + "/webapi/entry.cgi?path=${Uri.encodeComponent(thumb)}&size=small&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${Util.sid}&animate=true",
                  width: width,
                  height: height,
                  fit: fit,
                )
              : ExtendedImage.file(
                  File(thumb),
                  width: width,
                  height: height,
                  fit: fit,
                );
    } else if (fileType == FileTypeEnum.word) {
      return Image.asset(
        "assets/icons/word.png",
        width: 40,
        height: 60,
      );
    } else if (fileType == FileTypeEnum.ppt) {
      return Image.asset(
        "assets/icons/ppt.png",
        width: 40,
        height: 60,
      );
    } else if (fileType == FileTypeEnum.excel) {
      return Image.asset(
        "assets/icons/excel.png",
        width: 40,
        height: 60,
      );
    } else if (fileType == FileTypeEnum.pdf) {
      return Image.asset(
        "assets/icons/pdf.png",
        width: 40,
        height: 60,
      );
    } else if (fileType == FileTypeEnum.zip) {
      return Image.asset(
        "assets/icons/zip.png",
        width: 40,
        height: 60,
      );
    } else if (fileType == FileTypeEnum.ps) {
      return Image.asset(
        "assets/icons/psd.png",
        width: 40,
        height: 60,
      );
    } else if (fileType == FileTypeEnum.text) {
      return Image.asset(
        "assets/icons/txt.png",
        width: 40,
        height: 60,
      );
    } else if (fileType == FileTypeEnum.code) {
      return Image.asset(
        "assets/icons/code.png",
        width: 40,
        height: 60,
      );
    } else if (fileType == FileTypeEnum.apk) {
      return Image.asset(
        "assets/icons/apk.png",
        width: 40,
        height: 60,
      );
    } else if (fileType == FileTypeEnum.iso) {
      return Image.asset(
        "assets/icons/iso.png",
        width: 40,
        height: 60,
      );
    } else {
      return Image.asset(
        "assets/icons/other.png",
        width: 40,
        height: 60,
      );
    }
  }
}
