/// api : "SYNO.FileStation.CopyMove"
/// background : {"cancel":{"api":"SYNO.FileStation.CopyMove","method":"stop","params":{"taskid":"FileStation_169725454647E00CB1"},"version":3},"id":"FileStation_169725454647E00CB1","query":{"api":"SYNO.FileStation.CopyMove","method":"status","params":{"taskid":"FileStation_169725454647E00CB1"},"version":3},"title":["{0}: {1}","filebrowser:filetable_move","明日花绮罗"]}
/// crtime : 1697254861
/// finished : false
/// method : "start"
/// params : {"accurate_progress":true,"dest_folder_path":"/T14","overwrite":true,"path":["/下载/明日花绮罗"],"remove_src":true}
/// path : "/下载/明日花绮罗"
/// processed_size : 18152947712
/// processing_path : "/下载/明日花绮罗"
/// progress : 0.015545164234936237
/// taskid : "FileStation_169725454647E00CB1"
/// total : 1167755274383
/// version : 3

class BackgroundTask {
  BackgroundTask({
    this.api,
    this.background,
    this.crtime,
    this.finished,
    this.method,
    this.params,
    this.path,
    this.processedSize,
    this.processingPath,
    this.progress,
    this.taskid,
    this.total,
    this.version,
  });

  BackgroundTask.fromJson(dynamic json) {
    api = json['api'];
    background = json['background'] != null ? Background.fromJson(json['background']) : null;
    crtime = json['crtime'];
    finished = json['finished'];
    method = json['method'];
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    path = json['path'];
    processedSize = json['processed_size'];
    processingPath = json['processing_path'];
    progress = json['progress'];
    taskid = json['taskid'];
    total = json['total'];
    version = json['version'];
  }
  String? api;
  Background? background;
  num? crtime;
  bool? finished;
  String? method;
  Params? params;
  String? path;
  num? processedSize;
  String? processingPath;
  num? progress;
  String? taskid;
  num? total;
  num? version;
  BackgroundTask copyWith({
    String? api,
    Background? background,
    num? crtime,
    bool? finished,
    String? method,
    Params? params,
    String? path,
    num? processedSize,
    String? processingPath,
    num? progress,
    String? taskid,
    num? total,
    num? version,
  }) =>
      BackgroundTask(
        api: api ?? this.api,
        background: background ?? this.background,
        crtime: crtime ?? this.crtime,
        finished: finished ?? this.finished,
        method: method ?? this.method,
        params: params ?? this.params,
        path: path ?? this.path,
        processedSize: processedSize ?? this.processedSize,
        processingPath: processingPath ?? this.processingPath,
        progress: progress ?? this.progress,
        taskid: taskid ?? this.taskid,
        total: total ?? this.total,
        version: version ?? this.version,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['api'] = api;
    if (background != null) {
      map['background'] = background?.toJson();
    }
    map['crtime'] = crtime;
    map['finished'] = finished;
    map['method'] = method;
    if (params != null) {
      map['params'] = params?.toJson();
    }
    map['path'] = path;
    map['processed_size'] = processedSize;
    map['processing_path'] = processingPath;
    map['progress'] = progress;
    map['taskid'] = taskid;
    map['total'] = total;
    map['version'] = version;
    return map;
  }
}

/// accurate_progress : true
/// dest_folder_path : "/T14"
/// overwrite : true
/// path : ["/下载/明日花绮罗"]
/// remove_src : true

class Params {
  Params({
    this.accurateProgress,
    this.destFolderPath,
    this.overwrite,
    this.path,
    this.removeSrc,
    this.taskid,
  });

  Params.fromJson(dynamic json) {
    accurateProgress = json['accurate_progress'];
    destFolderPath = json['dest_folder_path'];
    overwrite = json['overwrite'];
    path = json['path'] != null ? json['path'].cast<String>() : [];
    removeSrc = json['remove_src'];
    taskid = json['taskid'];
  }
  bool? accurateProgress;
  String? destFolderPath;
  bool? overwrite;
  List<String>? path;
  bool? removeSrc;
  String? taskid;
  Params copyWith({
    bool? accurateProgress,
    String? destFolderPath,
    bool? overwrite,
    List<String>? path,
    bool? removeSrc,
    String? taskid,
  }) =>
      Params(
        accurateProgress: accurateProgress ?? this.accurateProgress,
        destFolderPath: destFolderPath ?? this.destFolderPath,
        overwrite: overwrite ?? this.overwrite,
        path: path ?? this.path,
        removeSrc: removeSrc ?? this.removeSrc,
        taskid: taskid ?? this.taskid,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accurate_progress'] = accurateProgress;
    map['dest_folder_path'] = destFolderPath;
    map['overwrite'] = overwrite;
    map['path'] = path;
    map['remove_src'] = removeSrc;
    map['taskid'] = taskid;
    return map;
  }
}

/// cancel : {"api":"SYNO.FileStation.CopyMove","method":"stop","params":{"taskid":"FileStation_169725454647E00CB1"},"version":3}
/// id : "FileStation_169725454647E00CB1"
/// query : {"api":"SYNO.FileStation.CopyMove","method":"status","params":{"taskid":"FileStation_169725454647E00CB1"},"version":3}
/// title : ["{0}: {1}","filebrowser:filetable_move","明日花绮罗"]

class Background {
  Background({
    this.cancel,
    this.id,
    this.query,
    this.title,
  });

  Background.fromJson(dynamic json) {
    cancel = json['cancel'] != null ? Query.fromJson(json['cancel']) : null;
    id = json['id'];
    query = json['query'] != null ? Query.fromJson(json['query']) : null;
    title = json['title'] != null ? json['title'].cast<String>() : [];
  }
  Query? cancel;
  String? id;
  Query? query;
  List<String>? title;
  Background copyWith({
    Query? cancel,
    String? id,
    Query? query,
    List<String>? title,
  }) =>
      Background(
        cancel: cancel ?? this.cancel,
        id: id ?? this.id,
        query: query ?? this.query,
        title: title ?? this.title,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cancel != null) {
      map['cancel'] = cancel?.toJson();
    }
    map['id'] = id;
    if (query != null) {
      map['query'] = query?.toJson();
    }
    map['title'] = title;
    return map;
  }
}

/// api : "SYNO.FileStation.CopyMove"
/// method : "status"
/// params : {"taskid":"FileStation_169725454647E00CB1"}
/// version : 3

class Query {
  Query({
    this.api,
    this.method,
    this.params,
    this.version,
  });

  Query.fromJson(dynamic json) {
    api = json['api'];
    method = json['method'];
    params = json['params'] != null ? Params.fromJson(json['params']) : null;
    version = json['version'];
  }
  String? api;
  String? method;
  Params? params;
  num? version;
  Query copyWith({
    String? api,
    String? method,
    Params? params,
    num? version,
  }) =>
      Query(
        api: api ?? this.api,
        method: method ?? this.method,
        params: params ?? this.params,
        version: version ?? this.version,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['api'] = api;
    map['method'] = method;
    if (params != null) {
      map['params'] = params?.toJson();
    }
    map['version'] = version;
    return map;
  }
}
