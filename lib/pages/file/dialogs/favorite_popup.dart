import 'dart:ui';

import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/pages/file/widgets/file_list_item_widget.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/widgets/button.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/glass/glass_modal_popup.dart';
import 'package:dsm_helper/widgets/glass/popup_header.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        PopupHeader(
          title: "收藏夹",
          action: CupertinoButton(
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
        ),
        SizedBox(height: 10),
        Expanded(
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
      ],
    );
  }
}

class FavoritePopup {
  static Future<FileItem?> show({required BuildContext context}) async {
    return await showGlassModalPopup(
      context,
      content: FavoriteFolder(),
      buttons: [
        Button(
          onPressed: () async {
            context.pop();
          },
          color: Theme.of(context).disabledColor,
          child: Text("关闭"),
        ),
      ],
    );
  }
}
