import 'package:dsm_helper/utils/utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoExtendedImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final BoxShape boxShape;
  final BorderRadius borderRadius;
  final Widget? placeholder;
  CupertinoExtendedImage(
    this.url, {
    this.fit,
    this.width,
    this.height,
    this.boxShape = BoxShape.rectangle,
    this.borderRadius = BorderRadius.zero,
    this.placeholder,
  });
  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      fit: fit,
      width: width,
      height: height,
      cache: true,
      // enableMemoryCache: false,
      // cacheHeight: height == null ? null : height ~/ 2,
      // cacheWidth: width == null ? null : width ~/ 2,
      shape: boxShape,
      borderRadius: borderRadius,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return placeholder ??
                Container(
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/image.png",
                    width: 40,
                    height: 40,
                  ),
                );
          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              width: width,
              height: height,
              fit: fit,
            );
          case LoadState.failed:
            return placeholder ??
                Container(
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/image.png",
                    width: 40,
                    height: 40,
                  ),
                );
          default:
            return Container();
        }
      },
    );
  }
}

class CupertinoCircleAvatar extends StatelessWidget {
  final String url;
  final String text;
  final Color backgroundColor;
  final double fontSize;
  final double size;
  final Color foregroundColor;
  CupertinoCircleAvatar({
    required this.url,
    this.backgroundColor = Colors.blue,
    this.size = 30,
    this.text = "",
    this.fontSize = 18,
    this.foregroundColor = CupertinoColors.white,
  });
  @override
  Widget build(BuildContext context) {
    return url.isBlank
        ? Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            width: size,
            height: size,
            child: Text(
              text,
              style: TextStyle(fontSize: fontSize, color: foregroundColor),
            ),
          )
        : CupertinoExtendedImage(
            Utils.baseUrl + url,
            width: size,
            height: size,
            fit: BoxFit.contain,
            boxShape: BoxShape.circle,
          );
  }
}
