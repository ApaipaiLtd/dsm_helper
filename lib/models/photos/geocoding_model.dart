import 'dart:convert';

import 'package:dsm_helper/models/photos/photo_model.dart';
import 'package:dsm_helper/util/function.dart';

/// additional : {"thumbnail":{"cache_key":"611178_1665630275","m":"ready","preview":"broken","sm":"ready","unit_id":611178,"xl":"ready"}}
/// country : "中国大陆"
/// country_id : 1
/// first_level : "青岛市"
/// id : 70
/// item_count : 172
/// name : "青岛市"
/// second_level : ""

class GeocodingModel {
  GeocodingModel({
    this.additional,
    this.country,
    this.countryId,
    this.firstLevel,
    this.id,
    this.itemCount,
    this.name,
    this.secondLevel,
  });
  static Future<List<GeocodingModel>> fetch({List<String> additional, int limit = 5000, bool isTeam = false}) async {
    var res = await Util.post("entry.cgi", data: {
      // "folder_id": id,
      "api": 'SYNO.Foto${isTeam ? 'Team' : ''}.Browse.Geocoding',
      "method": 'list',
      "version": 1,
      "_sid": Util.sid,
      "additional": jsonEncode(additional),
      "offset": 0,
      "limit": limit,
    });
    if (res['success']) {
      List list = res['data']['list'];
      List<GeocodingModel> geocodings = [];
      list.forEach((element) {
        geocodings.add(GeocodingModel.fromJson(element));
      });
      return geocodings;
    } else {
      throw Exception();
    }
  }

  GeocodingModel.fromJson(dynamic json) {
    additional = json['additional'] != null ? PhotoAdditional.fromJson(json['additional']) : null;
    country = json['country'];
    countryId = json['country_id'];
    firstLevel = json['first_level'];
    id = json['id'];
    itemCount = json['item_count'];
    name = json['name'];
    secondLevel = json['second_level'];
  }
  PhotoAdditional additional;
  String country;
  num countryId;
  String firstLevel;
  num id;
  num itemCount;
  String name;
  String secondLevel;
  GeocodingModel copyWith({
    PhotoAdditional additional,
    String country,
    num countryId,
    String firstLevel,
    num id,
    num itemCount,
    String name,
    String secondLevel,
  }) =>
      GeocodingModel(
        additional: additional ?? this.additional,
        country: country ?? this.country,
        countryId: countryId ?? this.countryId,
        firstLevel: firstLevel ?? this.firstLevel,
        id: id ?? this.id,
        itemCount: itemCount ?? this.itemCount,
        name: name ?? this.name,
        secondLevel: secondLevel ?? this.secondLevel,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (additional != null) {
      map['additional'] = additional.toJson();
    }
    map['country'] = country;
    map['country_id'] = countryId;
    map['first_level'] = firstLevel;
    map['id'] = id;
    map['item_count'] = itemCount;
    map['name'] = name;
    map['second_level'] = secondLevel;
    return map;
  }
}
