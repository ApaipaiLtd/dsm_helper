import 'package:dsm_helper/models/photos/additional.dart';

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

  GeocodingModel.fromJson(dynamic json) {
    additional = json['additional'] != null ? Additional.fromJson(json['additional']) : null;
    country = json['country'];
    countryId = json['country_id'];
    firstLevel = json['first_level'];
    id = json['id'];
    itemCount = json['item_count'];
    name = json['name'];
    secondLevel = json['second_level'];
  }
  Additional additional;
  String country;
  num countryId;
  String firstLevel;
  num id;
  num itemCount;
  String name;
  String secondLevel;
  GeocodingModel copyWith({
    Additional additional,
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
