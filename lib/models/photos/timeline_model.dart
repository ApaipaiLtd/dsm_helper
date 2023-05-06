import 'package:dsm_helper/models/photos/photo_model.dart';
import 'package:dsm_helper/util/function.dart';

/// limit : 102
/// list : [{"day":22,"item_count":2,"month":10,"year":2022},{"day":21,"item_count":6,"month":10,"year":2022},{"day":23,"item_count":43,"month":9,"year":2022},{"day":7,"item_count":4,"month":8,"year":2022},{"day":28,"item_count":2,"month":6,"year":2022},{"day":22,"item_count":1,"month":5,"year":2022},{"day":20,"item_count":5,"month":5,"year":2022},{"day":10,"item_count":1,"month":5,"year":2022},{"day":25,"item_count":12,"month":4,"year":2022},{"day":27,"item_count":26,"month":3,"year":2022}]
/// offset : 0

class TimelineModel {
  TimelineModel({
    this.limit,
    this.days,
    this.offset,
  });
  static Future<List<TimelineModel>> fetch({bool isTeam = false, String type, int geocodingId, int generalTagId, bool recentlyAdd: false, List<int> itemTypes = const []}) async {
    Map<String, dynamic> data = {
      "timeline_group_unit": "day",
      "api": "SYNO.Foto${isTeam ? 'Team' : ''}.Browse.${recentlyAdd ? 'RecentlyAdded' : 'Timeline'}",
      "method": recentlyAdd ? "get_timeline" : 'get',
      "version": 2,
      "_sid": Util.sid,
    };
    if (type != null) {
      data['type'] = type;
    }
    if (geocodingId != null) {
      data['geocoding_id'] = geocodingId;
    }
    if (generalTagId != null) {
      data['general_tag_id'] = generalTagId;
    }
    // if (itemTypes != null && itemTypes.length > 0) {
    //   data['item_type'] = jsonEncode(itemTypes);
    //   data['method'] = "get_with_filter";
    // }
    print(data);
    var res = await Util.post("entry.cgi", data: data);
    print(res);
    if (res['success']) {
      List data = res['data']['section'];
      List<TimelineModel> timeline = [];
      data.forEach((e) {
        timeline.add(TimelineModel.fromJson(e));
      });
      return timeline;
    } else {
      throw Exception();
    }
  }

  TimelineModel.fromJson(dynamic json) {
    limit = json['limit'];
    if (json['list'] != null) {
      days = [];
      json['list'].forEach((v) {
        days.add(Day.fromJson(v));
      });
    }
    offset = json['offset'];
  }
  num limit;
  List<Day> days;
  num offset;
  TimelineModel copyWith({
    num limit,
    List<List> list,
    num offset,
  }) =>
      TimelineModel(
        limit: limit ?? this.limit,
        days: list ?? this.days,
        offset: offset ?? this.offset,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['limit'] = limit;
    if (days != null) {
      map['list'] = days.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    return map;
  }
}

/// day : 22
/// item_count : 2
/// month : 10
/// year : 2022

class Day {
  Day({
    this.day,
    this.itemCount,
    this.month,
    this.year,
  });

  Day.fromJson(dynamic json) {
    day = json['day'];
    itemCount = json['item_count'];
    month = json['month'];
    year = json['year'];
  }
  num day;
  num itemCount;
  num month;
  num year;
  num startPosition;
  num endPosition;
  List<PhotoModel> photos;

  Future fetchPhotos({bool isTeam = false, String type, int geocodingId, int generalTagId, bool recentlyAdd: false, List<int> itemTypes = const []}) async {
    Map<String, dynamic> data = {
      "offset": 0,
      "limit": itemCount,
      "additional": '["thumbnail","resolution","orientation","video_convert","video_meta","address"]',
      "api": "SYNO.Foto${isTeam ? 'Team' : ''}.Browse.${recentlyAdd ? 'RecentlyAdded' : 'Item'}",
      "method": 'list',
      "version": 1,
      "_sid": Util.sid,
      "timeline_group_unit": "day",
    };
    if (type != null) {
      data['type'] = type;
    }
    if (geocodingId != null) {
      data['geocoding_id'] = geocodingId;
    }
    if (generalTagId != null) {
      data['general_tag_id'] = generalTagId;
    }
    // if (itemTypes != null && itemTypes.length > 0) {
    //   data['item_type'] = jsonEncode(itemTypes);
    //   data['method'] = "list_with_filter";
    // }
    if (year != null && month != null && day != null) {
      int start = DateTime(year, month, day, 8).secondsSinceEpoch;
      int end = start + 60 * 60 * 24 - 1;
      data['start_time'] = start;
      data['end_time'] = end;
      // if (itemTypes != null) {
      //   data['time'] = jsonEncode([
      //     {"start_time": start, "end_time": end}
      //   ]);
      // }
    }
    var res = await Util.post("entry.cgi", data: data);
    // print(res);
    if (res['success']) {
      photos = [];
      res['data']['list'].forEach((e) {
        photos.add(PhotoModel.fromJson(e));
      });
    } else {
      throw Exception();
    }
  }

  static Future<Map> fetchLocation(int year, int month, int day) async {
    int start = DateTime(year, month, day, 8).secondsSinceEpoch;
    int end = start + 60 * 60 * 24 - 1;
    Map<String, dynamic> data = {
      "start_time": start,
      "end_time": end,
      "api": '"SYNO.${Util.version == 7 ? "Foto" : "Photo"}.Browse.Timeline"',
      "method": '"get_geocoding"',
      "version": 1,
      "_sid": Util.sid,
    };
    var res = await Util.post("entry.cgi", data: data);
    return res;
  }

  Day copyWith({
    num day,
    num itemCount,
    num month,
    num year,
  }) =>
      Day(
        day: day ?? this.day,
        itemCount: itemCount ?? this.itemCount,
        month: month ?? this.month,
        year: year ?? this.year,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['item_count'] = itemCount;
    map['month'] = month;
    map['year'] = year;
    return map;
  }
}
