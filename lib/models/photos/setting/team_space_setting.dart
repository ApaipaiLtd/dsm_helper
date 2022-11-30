import 'package:dsm_helper/util/function.dart';

class TeamSpaceSetting {
  TeamSpaceSetting({
    this.allowRootFolderPublic,
    this.enablePerson,
    this.enabled,
    this.teamSpaceDisabledByShareFolderDisabled,
  });

  static Future<TeamSpaceSetting> fetch() async {
    Map<String, dynamic> data = {
      "api": '"SYNO.${Util.version == 7 ? "Foto" : "Photo"}.Setting.TeamSpace',
      "method": "get",
      "version": 1,
      "_sid": Util.sid,
    };
    var res = await Util.post("entry.cgi", data: data);
    if (res['success']) {
      return TeamSpaceSetting.fromJson(res['data']);
    } else {
      throw Exception();
    }
  }

  TeamSpaceSetting.fromJson(dynamic json) {
    allowRootFolderPublic = json['allow_root_folder_public'];
    enablePerson = json['enable_person'];
    enabled = json['enabled'];
    teamSpaceDisabledByShareFolderDisabled = json['team_space_disabled_by_share_folder_disabled'];
  }
  bool allowRootFolderPublic;
  bool enablePerson;
  bool enabled;
  bool teamSpaceDisabledByShareFolderDisabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allow_root_folder_public'] = allowRootFolderPublic;
    map['enable_person'] = enablePerson;
    map['enabled'] = enabled;
    map['team_space_disabled_by_share_folder_disabled'] = teamSpaceDisabledByShareFolderDisabled;
    return map;
  }
}
