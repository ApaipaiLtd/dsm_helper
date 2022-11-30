import 'additional.dart';

class GeneralTagModel {
  GeneralTagModel({
    this.additional,
    this.id,
    this.itemCount,
    this.name,
  });

  GeneralTagModel.fromJson(dynamic json) {
    additional = json['additional'] != null ? Additional.fromJson(json['additional']) : null;
    id = json['id'];
    itemCount = json['item_count'];
    name = json['name'];
  }
  Additional additional;
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
