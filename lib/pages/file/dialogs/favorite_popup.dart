import 'dart:ui';

import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/pages/file/widgets/file_list_item_widget.dart';
import 'package:dsm_helper/utils/extensions/media_query_ext.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteFolder extends StatefulWidget {
  const FavoriteFolder({super.key});

  @override
  State<FavoriteFolder> createState() => _FavoriteFolderState();
}

class _FavoriteFolderState extends State<FavoriteFolder> {
  bool loading = false;
  FileStationList favorites = FileStationList();
  @override
  void initState() {
    getFavorites();
    super.initState();
  }

  getFavorites() async {
    setState(() {
      loading = true;
    });
    favorites = await FileStationList.favoriteList();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
        padding: EdgeInsets.symmetric(vertical: 14),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Text(
                      "收藏夹",
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: CupertinoButton(
                      onPressed: () async {
                        getFavorites();
                      },
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      minSize: 0,
                      child: Icon(
                        Icons.refresh,
                        size: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: context.height * 0.7,
                child: loading
                    ? Center(
                        child: LoadingWidget(),
                      )
                    : favorites.files != null && favorites.files!.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: favorites.files!.length,
                            itemBuilder: (context, i) {
                              return FileListItemWidget(
                                favorites.files![i],
                                favorite: true,
                                onTap: () {
                                  context.pop(favorites.files![i]);
                                },
                              );
                            },
                          )
                        : EmptyWidget(
                            size: 150,
                            text: "暂无收藏文件夹",
                          ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CupertinoButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  color: Theme.of(context).disabledColor,
                  borderRadius: BorderRadius.circular(15),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "关闭",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoritePopup {
  static Future<FileItem?> show({required BuildContext context}) async {
    return await showCupertinoModalPopup(
      context: context,
      // barrierColor: Colors.black12,
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      builder: (context) {
        return FavoriteFolder();
      },
    );
  }
}
