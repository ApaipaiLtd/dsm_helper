import 'package:dsm_helper/apis/api.dart';

/// script_in : ""
/// script_out : ""

class EventResultFile {
  EventResultFile({
    this.scriptIn,
    this.scriptOut,
  });

  static Future<EventResultFile> getFile(num id) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.EventScheduler",
      "result_get_file",
      version: 1,
      data: {
        "result_id": id,
      },
      parser: EventResultFile.fromJson,
    );
    return res.data;
  }

  EventResultFile.fromJson(dynamic json) {
    scriptIn = json['script_in'];
    scriptOut = json['script_out'];
  }
  String? scriptIn;
  String? scriptOut;
  EventResultFile copyWith({
    String? scriptIn,
    String? scriptOut,
  }) =>
      EventResultFile(
        scriptIn: scriptIn ?? this.scriptIn,
        scriptOut: scriptOut ?? this.scriptOut,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['script_in'] = scriptIn;
    map['script_out'] = scriptOut;
    return map;
  }
}
