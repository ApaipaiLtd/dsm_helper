import 'package:dsm_helper/util/api.dart';

/// maxVersion : 6
/// minVersion : 1
/// path : "auth.cgi"

class ApiModel {
  ApiModel({
    this.maxVersion,
    this.minVersion,
    this.path,
  });
  static Future<Map<String, ApiModel>> fetch() async {
    Map<String, ApiModel> apis = {};
    Map res = await Api.api();
    if (res['success']) {
      res['data'].forEach((key, value) {
        apis[key] = ApiModel.fromJson(value);
      });
    }

    return apis;
  }

  ApiModel.fromJson(dynamic json) {
    maxVersion = json['maxVersion'];
    minVersion = json['minVersion'];
    path = json['path'];
  }
  num maxVersion;
  num minVersion;
  String path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maxVersion'] = maxVersion;
    map['minVersion'] = minVersion;
    map['path'] = path;
    return map;
  }
}
