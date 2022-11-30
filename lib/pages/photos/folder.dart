import 'package:dsm_helper/models/photos/folder_model.dart';
import 'package:flutter/material.dart';

class Folder extends StatefulWidget {
  const Folder(this.isTeam, {Key key}) : super(key: key);
  final bool isTeam;
  @override
  State<Folder> createState() => FolderState();
}

class FolderState extends State<Folder> {
  bool loading = true;
  FolderModel root;
  bool isTeam = false;
  @override
  void initState() {
    isTeam = widget.isTeam;
    getData(isTeam: isTeam);
    super.initState();
  }

  Future getData({bool isTeam: false}) async {
    this.isTeam = isTeam;
    try {
      root = await FolderModel.fetch(additional: ['access_permission'], isTeam: isTeam);
      await root.fetchFolders(additional: ["thumbnail"], isTeam: isTeam);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
