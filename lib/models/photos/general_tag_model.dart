import 'dart:convert';

import 'package:dsm_helper/models/photos/photo_model.dart';
import 'package:dsm_helper/util/function.dart';

class GeneralTagModel {
  GeneralTagModel({
    this.additional,
    this.id,
    this.itemCount,
    this.name,
  });
  static Future<List<GeneralTagModel>> fetch({List<String> additional, int limit = 5000, bool isTeam = false}) async {
    var res = await Util.post("entry.cgi", data: {
      // "folder_id": id,
      "api": 'SYNO.Foto${isTeam ? 'Team' : ''}.Browse.GeneralTag',
      "method": 'list',
      "version": 1,
      "_sid": Util.sid,
      "additional": jsonEncode(additional),
      "offset": 0,
      "limit": limit,
    });
    if (res['success']) {
      List list = res['data']['list'];
      List<GeneralTagModel> generalTags = [];
      list.forEach((element) {
        generalTags.add(GeneralTagModel.fromJson(element));
      });
      return generalTags;
    } else {
      throw Exception();
    }
  }

  GeneralTagModel.fromJson(dynamic json) {
    additional = json['additional'] != null ? PhotoAdditional.fromJson(json['additional']) : null;
    id = json['id'];
    itemCount = json['item_count'];
    name = json['name'];
  }
  PhotoAdditional additional;
  int id;
  int itemCount;
  String name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (additional != null) {
      map['additional'] = additional.toJson();
    }
    map['id'] = id;
    map['item_count'] = itemCount;
    map['name'] = name;
    return map;
  }
}
