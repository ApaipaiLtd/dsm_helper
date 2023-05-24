import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/hero_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:vibrate/vibrate.dart';

class ImagePreview extends StatefulWidget {
  final List<String> images;
  final List<String> thumbs;
  final List<String> names;
  final List<String> paths;
  final int index;
  final bool network;
  final Object tag;
  final Function onDelete;
  final PageController pageController;

  ImagePreview(this.images, this.index, {this.network = true, this.tag, this.thumbs: const [], this.names: const [], this.paths: const [], this.onDelete}) : this.pageController = PageController(initialPage: index);

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  var rebuildIndex = StreamController<int>.broadcast();
  var rebuildSwiper = StreamController<bool>.broadcast();
  Function animationListener;
  bool _showSwiper = true;
  List<double> doubleTapScales = <double>[1.0, 2.0];
  int currentIndex = 0;
  bool blackBackground = false;
  GlobalKey<ExtendedImageSlidePageState> slidePageKey = GlobalKey<ExtendedImageSlidePageState>();
  double initScale({Size imageSize, Size size, double initialScale}) {
    var n1 = imageSize.height / imageSize.width;
    var n2 = size.height / size.width;
    if (n1 > n2) {
      final FittedSizes fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      Size destinationSize = fittedSizes.destination;
      return size.width / destinationSize.width;
    } else if (n1 / n2 < 1 / 10) {
      final FittedSizes fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      Size destinationSize = fittedSizes.destination;
      return size.height / destinationSize.height;
    }

    return initialScale;
  }

  deleteFile(int index) {
    Util.vibrate(FeedbackType.warning);
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: NeuCard(
            width: double.infinity,
            padding: EdgeInsets.all(22),
            bevel: 5,
            curveType: CurveType.emboss,
            decoration: NeumorphicDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "确认删除",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "确认要删除文件？",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: NeuButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            var res = await Api.deleteTask([widget.paths[index]]);
                            if (res['success']) {
                              Util.toast("文件删除成功");
                              if (widget.thumbs != null && widget.thumbs.length > index) {
                                widget.thumbs?.removeAt(index);
                              }

                              if (widget.images != null && widget.images.length > index) {
                                widget.images?.removeAt(index);
                              }
                              if (widget.paths != null && widget.paths.length > index) {
                                widget.paths?.removeAt(index);
                              }
                              if (widget.names != null && widget.names.length > index) {
                                widget.names?.removeAt(index);
                              }
                              setState(() {});
                              widget.onDelete?.call();
                            }
                          },
                          decoration: NeumorphicDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          bevel: 5,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "确认删除",
                            style: TextStyle(fontSize: 18, color: Colors.redAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: NeuButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          decoration: NeumorphicDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          bevel: 5,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "取消",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _animationController = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    setState(() {
      currentIndex = widget.index;
    });
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    rebuildIndex.close();
    rebuildSwiper.close();
    _animationController?.dispose();
    clearGestureDetailsCache();
    //cancelToken?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Widget result = Material(
      color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.transparent,
      shadowColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ExtendedImageGesturePageView.builder(
            itemBuilder: (BuildContext context, int index) {
              var item = widget.images[index];
              Widget image;
              if (widget.network) {
                image = ExtendedImage.network(
                  item,
                  fit: BoxFit.contain,
                  enableSlideOutPage: true,
                  mode: ExtendedImageMode.gesture,
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        final ImageChunkEvent loadingProgress = state.loadingProgress;
                        final double progress = loadingProgress?.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null;
                        if (widget.thumbs.length > index + 1) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              ExtendedImage.network(
                                widget.thumbs[index],
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                              CircularProgressIndicator(
                                value: progress,
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: progress,
                            ),
                          );
                        }
                        break;
                      case LoadState.completed:
                        return null;
                      case LoadState.failed:
                        //remove memory cached
                        state.imageProvider.evict();
                        return Center(
                          child: Text("图片加载失败"),
                        );
                      default:
                        return Container();
                    }
                  },
                  // heroBuilderForSlidingPage: (Widget result) {
                  //   return Hero(
                  //     tag: widget.tag ?? item,
                  //     child: result,
                  //     flightShuttleBuilder: (BuildContext flightContext, Animation<double> animation, HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext) {
                  //       final Hero hero = (flightDirection == HeroFlightDirection.pop ? fromHeroContext.widget : toHeroContext.widget) as Hero;
                  //       return hero.child;
                  //     },
                  //   );
                  // },
                  initGestureConfigHandler: (state) {
                    double initialScale = 1.0;
                    if (state.extendedImageInfo != null && state.extendedImageInfo.image != null) {
                      initialScale = initScale(size: size, initialScale: initialScale, imageSize: Size(state.extendedImageInfo.image.width.toDouble(), state.extendedImageInfo.image.height.toDouble()));
                    }
                    return GestureConfig(
                        inPageView: true,
                        initialScale: initialScale,
                        maxScale: max(initialScale, 5.0),
                        animationMaxScale: max(initialScale, 5.0),
                        //you can cache gesture state even though page view page change.
                        //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                        cacheGesture: false);
                  },
                  onDoubleTap: (ExtendedImageGestureState state) {
                    ///you can use define pointerDownPosition as you can,
                    ///default value is double tap pointer down postion.
                    var pointerDownPosition = state.pointerDownPosition;
                    double begin = state.gestureDetails.totalScale;
                    double end;
                    _animation?.removeListener(animationListener);
                    _animationController.stop();
                    _animationController.reset();
                    if (begin == doubleTapScales[0]) {
                      end = doubleTapScales[1];
                    } else {
                      end = doubleTapScales[0];
                    }
                    animationListener = () {
                      state.handleDoubleTap(scale: _animation.value, doubleTapPosition: pointerDownPosition);
                    };
                    _animation = _animationController.drive(Tween<double>(begin: begin, end: end));
                    _animation.addListener(animationListener);
                    _animationController.forward();
                  },
                );
              } else {
                image = ExtendedImage.file(
                  File(widget.images[index]),
                  fit: BoxFit.contain,
                  enableSlideOutPage: true,
                  mode: ExtendedImageMode.gesture,
                  // heroBuilderForSlidingPage: (Widget result) {
                  //   return Hero(
                  //     tag: widget.tag ?? item,
                  //     child: result,
                  //     flightShuttleBuilder: (BuildContext flightContext, Animation<double> animation, HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext) {
                  //       final Hero hero = flightDirection == HeroFlightDirection.pop ? fromHeroContext.widget : toHeroContext.widget;
                  //       return hero.child;
                  //     },
                  //   );
                  // },
                  initGestureConfigHandler: (state) {
                    double initialScale = 1.0;
                    if (state.extendedImageInfo != null && state.extendedImageInfo.image != null) {
                      initialScale = initScale(size: size, initialScale: initialScale, imageSize: Size(state.extendedImageInfo.image.width.toDouble(), state.extendedImageInfo.image.height.toDouble()));
                    }
                    return GestureConfig(
                        inPageView: true,
                        initialScale: initialScale,
                        maxScale: max(initialScale, 5.0),
                        animationMaxScale: max(initialScale, 5.0),
                        //you can cache gesture state even though page view page change.
                        //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                        cacheGesture: false);
                  },
                  onDoubleTap: (ExtendedImageGestureState state) {
                    ///you can use define pointerDownPosition as you can,
                    ///default value is double tap pointer down postion.
                    var pointerDownPosition = state.pointerDownPosition;
                    double begin = state.gestureDetails.totalScale;
                    double end;
                    _animation?.removeListener(animationListener);
                    _animationController.stop();
                    _animationController.reset();
                    if (begin == doubleTapScales[0]) {
                      end = doubleTapScales[1];
                    } else {
                      end = doubleTapScales[0];
                    }
                    animationListener = () {
                      state.handleDoubleTap(scale: _animation.value, doubleTapPosition: pointerDownPosition);
                    };
                    _animation = _animationController.drive(Tween<double>(begin: begin, end: end));
                    _animation.addListener(animationListener);
                    _animationController.forward();
                  },
                );
              }

              image = GestureDetector(
                child: HeroWidget(
                  tag: widget.tag ?? item,
                  child: image,
                  slidePagekey: slidePageKey,
                  // flightShuttleBuilder: (BuildContext flightContext, Animation<double> animation, HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext) {
                  //   final Hero hero = (flightDirection == HeroFlightDirection.pop ? fromHeroContext.widget : toHeroContext.widget) as Hero;
                  //   return hero.child;
                  // },
                ),
                onTap: () {
                  slidePageKey.currentState.popPage();
                  Navigator.pop(context);
                },
              );

              return image;
            },
            itemCount: widget.images.length,
            onPageChanged: (int index) {
              currentIndex = index;
              rebuildIndex.add(index);
            },
            controller: ExtendedPageController(
              initialPage: currentIndex,
            ),
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
          ),
          StreamBuilder<bool>(
            builder: (c, d) {
              if (d.data == null || !d.data) return Container();

              return Column(
                children: [
                  if (Util.isWechatInstalled)
                    SafeArea(
                      child: Container(
                        height: 56,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            Expanded(
                              child: widget.names != null ? FileName(widget.names, currentIndex, rebuildIndex) : Container(),
                            ),
                            GestureDetector(
                              onTap: () {
                                WeChatImage wechatImage;
                                if (widget.images[currentIndex].startsWith("http")) {
                                  wechatImage = WeChatImage.network(widget.images[currentIndex]);
                                } else if (widget.images[currentIndex].startsWith("/")) {
                                  wechatImage = WeChatImage.file(File(widget.images[currentIndex]));
                                } else {
                                  Util.toast("暂不支持分享此图片");
                                  return;
                                }
                                shareToWeChat(
                                  WeChatShareImageModel(wechatImage, scene: WeChatScene.SESSION),
                                );
                              },
                              child: Image.asset(
                                "assets/icons/wechat.png",
                                width: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  Spacer(),
                  MySwiperPlugin(
                    widget.images,
                    currentIndex,
                    rebuildIndex,
                    onDelete: widget.paths != null && widget.paths.length > currentIndex
                        ? (index) {
                            deleteFile(index);
                          }
                        : null,
                  ),
                ],
              );
            },
            initialData: true,
            stream: rebuildSwiper.stream,
          )
        ],
      ),
    );

    result = ExtendedImageSlidePage(
      key: slidePageKey,
      child: result,
      slideAxis: SlideAxis.both,
      slideType: SlideType.onlyImage,
      onSlidingPage: (state) {
        ///you can change other widgets' state on page as you want
        ///base on offset/isSliding etc
        //var offset= state.offset;
        var showSwiper = !state.isSliding;
        if (showSwiper != _showSwiper) {
          // do not setState directly here, the image state will change,
          // you should only notify the widgets which are needed to change
          // setState(() {
          // _showSwiper = showSwiper;
          // });

          _showSwiper = showSwiper;
          rebuildSwiper.add(_showSwiper);
        }
      },
    );

    return result;
  }
}

class FileName extends StatelessWidget {
  final List names;
  final int index;
  final StreamController<int> reBuild;
  FileName(this.names, this.index, this.reBuild);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      builder: (BuildContext context, data) {
        return Text(data.data < names.length ? names[data.data] : "");
      },
      initialData: index,
      stream: reBuild.stream,
    );
  }
}

class MySwiperPlugin extends StatelessWidget {
  final List pics;
  final int index;
  final StreamController<int> reBuild;
  final Function(int) onDelete;
  MySwiperPlugin(this.pics, this.index, this.reBuild, {this.onDelete});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      builder: (BuildContext context, data) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: <Widget>[
                NeuButton(
                  decoration: NeumorphicDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  bevel: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  onPressed: () {
                    Util.saveImage(pics[data.data], context: context).then((res) {
                      if (res['code'] == 1) {
                        Util.toast("已保存到相册");
                      } else {
                        Util.toast("图片下载失败");
                      }
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.file_download,
                        size: 13,
                      ),
                      Text(
                        " 保存图片",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                if (onDelete != null)
                  NeuButton(
                    decoration: NeumorphicDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    bevel: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onPressed: () {
                      onDelete?.call(data.data);
                    },
                    child: Icon(
                      Icons.delete_forever,
                      size: 13,
                    ),
                  ),
                SizedBox(
                  width: 10,
                ),
                NeuCard(
                  decoration: NeumorphicDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  curveType: CurveType.flat,
                  bevel: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "${data.data + 1} / ${pics.length}",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      initialData: index,
      stream: reBuild.stream,
    );
  }
}
