import 'package:dsm_helper/apis/api.dart';

/// tag : "latest"

class RegistryTag {
  RegistryTag({
    this.tag,
  });

  static Future<List<RegistryTag>> tags({required String repo}) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Docker.Registry",
      "tags",
      version: 1,
      parser: (json) {
        List<RegistryTag> tags = [];
        json.forEach((item) {
          tags.add(RegistryTag.fromJson(item));
        });
        return tags;
      },
      data: {
        "repo": '"$repo"',
        "aliInfo": '""',
      },
    );
    return res.data;
  }

  RegistryTag.fromJson(dynamic json) {
    tag = json['tag'];
  }
  String? tag;
  RegistryTag copyWith({
    String? tag,
  }) =>
      RegistryTag(
        tag: tag ?? this.tag,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tag'] = tag;
    return map;
  }
}
