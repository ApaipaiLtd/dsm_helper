abstract class BaseModel {
  String? api;
  Map<String, dynamic>? data;
  String? method;
  int? version;

  BaseModel({this.api, this.method, this.data, this.version = 1});

  fromJson(dynamic json);
}
