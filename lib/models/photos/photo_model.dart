import 'dart:convert';

import 'package:dsm_helper/models/photos/thumbnail_model.dart';
import 'package:dsm_helper/util/function.dart';

import 'folder_model.dart';

/// id : 684388
/// filename : "P8.jpg"
/// filesize : 3331582
/// time : 1666427282
/// indexed_time : 1666647788000
/// owner_user_id : 1
/// folder_id : 22804
/// type : "photo"
/// additional : {"resolution":{"width":4064,"height":2032},"orientation":1,"orientation_original":1,"thumbnail":{"m":"ready","xl":"ready","preview":"broken","sm":"ready","cache_key":"684388_1666619080","unit_id":684388}}

class PhotoModel {
  PhotoModel({
    this.id,
    this.filename,
    this.filesize,
    this.time,
    this.indexedTime,
    this.ownerUserId,
    this.folderId,
    this.type,
    this.additional,
  });
  static Future<List<PhotoModel>> fetch({List<String> additional = const [], bool isTeam = false, int albumId, int geocodingId, String folderId, String type, int limit}) async {
    Map<String, dynamic> data = {
      "api": 'SYNO.Foto${isTeam ? 'Team' : ''}.Browse.Item',
      "method": 'list',
      "version": 1,
      "_sid": Util.sid,
      "additional": jsonEncode(additional),
      "sort_by": "takentime",
      "sort_direction": "asc",
      "offset": 0,
      "limit": limit ?? 5000,
    };
    if (albumId != null) {
      data['album_id'] = albumId;
    }
    if (geocodingId != null) {
      data['geocoding_id'] = geocodingId;
    }
    if (folderId != null) {
      data['folderId'] = folderId;
    }
    if (type != null) {
      data['type'] = type;
    }
    var res = await Util.post("entry.cgi", data: data);
    if (res['success']) {
      List list = res['data']['list'];
      List<PhotoModel> photos = [];
      list.forEach((element) {
        photos.add(PhotoModel.fromJson(element));
      });
      return photos;
    } else {
      throw Exception();
    }
  }

  static Future<List<PhotoModel>> recentlyAdd({List<String> additional = const [], bool isTeam = false, String folderId, String type, int limit}) async {
    Map<String, dynamic> data = {
      "api": 'SYNO.Foto${isTeam ? 'Team' : ''}.Browse.RecentlyAdded',
      "method": 'list',
      "version": 1,
      "_sid": Util.sid,
      "additional": jsonEncode(additional),
      "offset": 0,
      "limit": limit ?? 5000,
    };
    print(data);
    var res = await Util.post("entry.cgi", data: data);
    print(res);
    if (res['success']) {
      List list = res['data']['list'];
      List<PhotoModel> photos = [];
      list.forEach((element) {
        photos.add(PhotoModel.fromJson(element));
      });
      return photos;
    } else {
      throw Exception();
    }
  }

  PhotoModel.fromJson(dynamic json) {
    id = json['id'];
    filename = json['filename'];
    filesize = json['filesize'];
    time = json['time'];
    indexedTime = json['indexed_time'];
    ownerUserId = json['owner_user_id'];
    folderId = json['folder_id'];
    type = json['type'];
    additional = json['additional'] != null ? PhotoAdditional.fromJson(json['additional']) : null;
  }
  num id;
  String filename;
  num filesize;
  num time;
  num indexedTime;
  num ownerUserId;
  num folderId;
  String type;
  PhotoAdditional additional;

  String videoUrl({bool isTeam = false}) {
    return '${Util.baseUrl}/webapi/entry.cgi?item_id=%5B$id%5D&api=%22SYNO.Foto${isTeam ? 'Team' : ''}.Download%22&method=%22download%22&version=1&_sid=${Util.sid}';
  }

  String thumbUrl({String size = 'sm', bool isTeam = false}) {
    return '${Util.baseUrl}/webapi/entry.cgi?id=${additional.thumbnail.unitId}&cache_key="${additional.thumbnail.cacheKey}"&type="unit"&size="$size"&api="SYNO.Foto${isTeam ? 'Team' : ''}.Thumbnail"&method="get"&version=1&_sid=${Util.sid}';
  }

  PhotoModel copyWith({
    num id,
    String filename,
    num filesize,
    num time,
    num indexedTime,
    num ownerUserId,
    num folderId,
    String type,
    PhotoAdditional additional,
  }) =>
      PhotoModel(
        id: id ?? this.id,
        filename: filename ?? this.filename,
        filesize: filesize ?? this.filesize,
        time: time ?? this.time,
        indexedTime: indexedTime ?? this.indexedTime,
        ownerUserId: ownerUserId ?? this.ownerUserId,
        folderId: folderId ?? this.folderId,
        type: type ?? this.type,
        additional: additional ?? this.additional,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['filename'] = filename;
    map['filesize'] = filesize;
    map['time'] = time;
    map['indexed_time'] = indexedTime;
    map['owner_user_id'] = ownerUserId;
    map['folder_id'] = folderId;
    map['type'] = type;
    if (additional != null) {
      map['additional'] = additional.toJson();
    }
    return map;
  }
}

/// resolution : {"width":4064,"height":2032}
/// orientation : 1
/// orientation_original : 1
/// thumbnail : {"m":"ready","xl":"ready","preview":"broken","sm":"ready","cache_key":"684388_1666619080","unit_id":684388}

class PhotoAdditional {
  PhotoAdditional({
    this.sharingInfo,
    this.resolution,
    this.orientation,
    this.orientationOriginal,
    this.thumbnail,
    this.address,
    this.videoMeta,
    this.videoConvert,
  });

  PhotoAdditional.fromJson(dynamic json) {
    resolution = json['resolution'] != null ? Resolution.fromJson(json['resolution']) : null;
    orientation = json['orientation'];
    orientationOriginal = json['orientation_original'];
    thumbnail = json['thumbnail'] != null ? ThumbnailModel.fromJson(json['thumbnail']) : null;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    videoMeta = json['video_meta'] != null ? VideoMeta.fromJson(json['video_meta']) : null;
    sharingInfo = json['sharing_info'] != null ? SharingInfo.fromJson(json['sharing_info']) : null;
    if (json['video_convert'] != null) {
      videoConvert = [];
      json['video_convert'].forEach((e) {
        videoConvert.add(VideoConvert.fromJson(e));
      });
    }
  }
  SharingInfo sharingInfo;
  Resolution resolution;
  num orientation;
  num orientationOriginal;
  ThumbnailModel thumbnail;
  Address address;
  VideoMeta videoMeta;
  List<VideoConvert> videoConvert;
  PhotoAdditional copyWith({
    SharingInfo sharingInfo,
    Resolution resolution,
    num orientation,
    num orientationOriginal,
    ThumbnailModel thumbnail,
    Address address,
    VideoMeta videoMeta,
    List<VideoConvert> videoConvert,
  }) =>
      PhotoAdditional(
        sharingInfo: sharingInfo ?? this.sharingInfo,
        resolution: resolution ?? this.resolution,
        orientation: orientation ?? this.orientation,
        orientationOriginal: orientationOriginal ?? this.orientationOriginal,
        thumbnail: thumbnail ?? this.thumbnail,
        address: address ?? this.address,
        videoMeta: videoMeta ?? this.videoMeta,
        videoConvert: videoConvert ?? this.videoConvert,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (resolution != null) {
      map['resolution'] = resolution.toJson();
    }
    map['orientation'] = orientation;
    map['orientation_original'] = orientationOriginal;
    if (thumbnail != null) {
      map['thumbnail'] = thumbnail.toJson();
    }
    return map;
  }
}

/// width : 4064
/// height : 2032

class Resolution {
  Resolution({
    this.width,
    this.height,
  });

  Resolution.fromJson(dynamic json) {
    width = json['width'];
    height = json['height'];
  }
  num width;
  num height;
  Resolution copyWith({
    num width,
    num height,
  }) =>
      Resolution(
        width: width ?? this.width,
        height: height ?? this.height,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['width'] = width;
    map['height'] = height;
    return map;
  }
}

class Address {
  Address({
    this.country,
    this.countryId,
    this.state,
    this.stateId,
    this.county,
    this.countyId,
    this.city,
    this.cityId,
    this.town,
    this.townId,
    this.district,
    this.districtId,
    this.village,
    this.villageId,
    this.route,
    this.routeId,
    this.landmark,
    this.landmarkId,
  });

  Address.fromJson(dynamic json) {
    country = json['country'];
    countryId = json['country_id'];
    state = json['state'];
    stateId = json['state_id'];
    county = json['county'];
    countyId = json['county_id'];
    city = json['city'];
    cityId = json['city_id'];
    town = json['town'];
    townId = json['town_id'];
    district = json['district'];
    districtId = json['district_id'];
    village = json['village'];
    villageId = json['village_id'];
    route = json['route'];
    routeId = json['route_id'];
    landmark = json['landmark'];
    landmarkId = json['landmark_id'];
  }
  String country;
  String countryId;
  String state;
  String stateId;
  String county;
  String countyId;
  String city;
  String cityId;
  String town;
  String townId;
  String district;
  String districtId;
  String village;
  String villageId;
  String route;
  String routeId;
  String landmark;
  String landmarkId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country'] = country;
    map['country_id'] = countryId;
    map['state'] = state;
    map['state_id'] = stateId;
    map['county'] = county;
    map['county_id'] = countyId;
    map['city'] = city;
    map['city_id'] = cityId;
    map['town'] = town;
    map['town_id'] = townId;
    map['district'] = district;
    map['district_id'] = districtId;
    map['village'] = village;
    map['village_id'] = villageId;
    map['route'] = route;
    map['route_id'] = routeId;
    map['landmark'] = landmark;
    map['landmark_id'] = landmarkId;
    return map;
  }
}

class VideoConvert {
  VideoConvert({
    this.quality,
    this.metadata,
  });

  VideoConvert.fromJson(dynamic json) {
    quality = json['quality'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }
  String quality;
  Metadata metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quality'] = quality;
    if (metadata != null) {
      map['metadata'] = metadata.toJson();
    }
    return map;
  }
}

class Metadata {
  Metadata({
    this.duration,
    this.orientation,
    this.frameBitrate,
    this.videoBitrate,
    this.audioBitrate,
    this.framerate,
    this.resolutionX,
    this.resolutionY,
    this.videoCodec,
    this.audioCodec,
    this.containerType,
    this.videoProfile,
    this.videoLevel,
    this.audioFrequency,
    this.audioChannel,
  });

  Metadata.fromJson(dynamic json) {
    duration = json['duration'];
    orientation = json['orientation'];
    frameBitrate = json['frame_bitrate'];
    videoBitrate = json['video_bitrate'];
    audioBitrate = json['audio_bitrate'];
    framerate = json['framerate'];
    resolutionX = json['resolution_x'];
    resolutionY = json['resolution_y'];
    videoCodec = json['video_codec'];
    audioCodec = json['audio_codec'];
    containerType = json['container_type'];
    videoProfile = json['video_profile'];
    videoLevel = json['video_level'];
    audioFrequency = json['audio_frequency'];
    audioChannel = json['audio_channel'];
  }
  int duration;
  int orientation;
  int frameBitrate;
  int videoBitrate;
  int audioBitrate;
  double framerate;
  int resolutionX;
  int resolutionY;
  String videoCodec;
  String audioCodec;
  String containerType;
  int videoProfile;
  int videoLevel;
  int audioFrequency;
  int audioChannel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duration'] = duration;
    map['orientation'] = orientation;
    map['frame_bitrate'] = frameBitrate;
    map['video_bitrate'] = videoBitrate;
    map['audio_bitrate'] = audioBitrate;
    map['framerate'] = framerate;
    map['resolution_x'] = resolutionX;
    map['resolution_y'] = resolutionY;
    map['video_codec'] = videoCodec;
    map['audio_codec'] = audioCodec;
    map['container_type'] = containerType;
    map['video_profile'] = videoProfile;
    map['video_level'] = videoLevel;
    map['audio_frequency'] = audioFrequency;
    map['audio_channel'] = audioChannel;
    return map;
  }
}

/// duration : 225000
/// orientation : 1
/// frame_bitrate : 7447439
/// video_bitrate : 7311323
/// audio_bitrate : 127194
/// framerate : 30.0
/// resolution_x : 1280
/// resolution_y : 720
/// video_codec : "h264"
/// audio_codec : "aac_lc"
/// container_type : "mp4"
/// video_profile : 2
/// video_level : 31
/// audio_frequency : 48000
/// audio_channel : 2

class VideoMeta {
  VideoMeta({
    this.duration,
    this.orientation,
    this.frameBitrate,
    this.videoBitrate,
    this.audioBitrate,
    this.framerate,
    this.resolutionX,
    this.resolutionY,
    this.videoCodec,
    this.audioCodec,
    this.containerType,
    this.videoProfile,
    this.videoLevel,
    this.audioFrequency,
    this.audioChannel,
  });

  VideoMeta.fromJson(dynamic json) {
    duration = json['duration'];
    orientation = json['orientation'];
    frameBitrate = json['frame_bitrate'];
    videoBitrate = json['video_bitrate'];
    audioBitrate = json['audio_bitrate'];
    framerate = json['framerate'];
    resolutionX = json['resolution_x'];
    resolutionY = json['resolution_y'];
    videoCodec = json['video_codec'];
    audioCodec = json['audio_codec'];
    containerType = json['container_type'];
    videoProfile = json['video_profile'];
    videoLevel = json['video_level'];
    audioFrequency = json['audio_frequency'];
    audioChannel = json['audio_channel'];
  }
  num duration;
  int get hours => duration ~/ 1000 ~/ 60 ~/ 60;
  int get minutes => duration ~/ 1000 ~/ 60 % 60;
  int get seconds => duration ~/ 1000 % 60;
  num orientation;
  num frameBitrate;
  num videoBitrate;
  num audioBitrate;
  num framerate;
  num resolutionX;
  num resolutionY;
  String videoCodec;
  String audioCodec;
  String containerType;
  num videoProfile;
  num videoLevel;
  num audioFrequency;
  num audioChannel;
  VideoMeta copyWith({
    num duration,
    num orientation,
    num frameBitrate,
    num videoBitrate,
    num audioBitrate,
    num framerate,
    num resolutionX,
    num resolutionY,
    String videoCodec,
    String audioCodec,
    String containerType,
    num videoProfile,
    num videoLevel,
    num audioFrequency,
    num audioChannel,
  }) =>
      VideoMeta(
        duration: duration ?? this.duration,
        orientation: orientation ?? this.orientation,
        frameBitrate: frameBitrate ?? this.frameBitrate,
        videoBitrate: videoBitrate ?? this.videoBitrate,
        audioBitrate: audioBitrate ?? this.audioBitrate,
        framerate: framerate ?? this.framerate,
        resolutionX: resolutionX ?? this.resolutionX,
        resolutionY: resolutionY ?? this.resolutionY,
        videoCodec: videoCodec ?? this.videoCodec,
        audioCodec: audioCodec ?? this.audioCodec,
        containerType: containerType ?? this.containerType,
        videoProfile: videoProfile ?? this.videoProfile,
        videoLevel: videoLevel ?? this.videoLevel,
        audioFrequency: audioFrequency ?? this.audioFrequency,
        audioChannel: audioChannel ?? this.audioChannel,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duration'] = duration;
    map['orientation'] = orientation;
    map['frame_bitrate'] = frameBitrate;
    map['video_bitrate'] = videoBitrate;
    map['audio_bitrate'] = audioBitrate;
    map['framerate'] = framerate;
    map['resolution_x'] = resolutionX;
    map['resolution_y'] = resolutionY;
    map['video_codec'] = videoCodec;
    map['audio_codec'] = audioCodec;
    map['container_type'] = containerType;
    map['video_profile'] = videoProfile;
    map['video_level'] = videoLevel;
    map['audio_frequency'] = audioFrequency;
    map['audio_channel'] = audioChannel;
    return map;
  }
}
