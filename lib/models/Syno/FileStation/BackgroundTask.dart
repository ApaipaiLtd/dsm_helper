/// offset : 0
/// tasks : [{"api":"SYNO.FileStation.CopyMove","background":{"cancel":{"api":"SYNO.FileStation.CopyMove","method":"stop","params":{"taskid":"FileStation_1696901220D794357E"},"version":3},"id":"FileStation_1696901220D794357E","query":{"api":"SYNO.FileStation.CopyMove","method":"status","params":{"taskid":"FileStation_1696901220D794357E"},"version":3},"title":["{0}: {1}","filebrowser:filetable_move","又又酱"]},"crtime":1696901220,"finished":false,"method":"start","params":{"accurate_progress":true,"dest_folder_path":"/下载","overwrite":true,"path":["/home/Photos/又又酱"],"remove_src":true},"path":"","processed_size":0,"processing_path":"","progress":-1,"taskid":"FileStation_1696901220D794357E","total":0,"version":3}]
/// total : 1

class BackgroundTask {
  BackgroundTask({
    this.offset,
    this.tasks,
    this.total,
  });

  BackgroundTask.fromJson(dynamic json) {
    offset = json['offset'];
    if (json['tasks'] != null) {
      tasks = [];
      json['tasks'].forEach((v) {
        tasks?.add(Tasks.fromJson(v));
      });
    }
    total = json['total'];
  }
  num? offset;
  List<Tasks>? tasks;
  num? total;
  BackgroundTask copyWith({
    num? offset,
    List<Tasks>? tasks,
    num? total,
  }) =>
      BackgroundTask(
        offset: offset ?? this.offset,
        tasks: tasks ?? this.tasks,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offset'] = offset;
    if (tasks != null) {
      map['tasks'] = tasks?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    return map;
  }
}

/// api : "SYNO.FileStation.CopyMove"
/// background : {"cancel":{"api":"SYNO.FileStation.CopyMove","method":"stop","params":{"taskid":"FileStation_1696901220D794357E"},"version":3},"id":"FileStation_1696901220D794357E","query":{"api":"SYNO.FileStation.CopyMove","method":"status","params":{"taskid":"FileStation_1696901220D794357E"},"version":3},"title":["{0}: {1}","filebrowser:filetable_move","又又酱"]}
/// crtime : 1696901220
/// finished : false
/// method : "start"
/// params : {"accurate_progress":true,"dest_folder_path":"/下载","overwrite":true,"path":["/home/Photos/又又酱"],"remove_src":true}
/// path : ""
/// processed_size : 0
/// processing_path : ""
/// progress : -1
/// taskid : "FileStation_1696901220D794357E"
/// total : 0
/// version : 3

class Tasks {
  Tasks({
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

  Tasks.fromJson(dynamic json) {
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
  Tasks copyWith({
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
      Tasks(
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
/// dest_folder_path : "/下载"
/// overwrite : true
/// path : ["/home/Photos/又又酱"]
/// remove_src : true

class Params {
  Params({
    this.accurateProgress,
    this.destFolderPath,
    this.overwrite,
    this.path,
    this.removeSrc,
  });

  Params.fromJson(dynamic json) {
    accurateProgress = json['accurate_progress'];
    destFolderPath = json['dest_folder_path'];
    overwrite = json['overwrite'];
    path = json['path'] != null ? json['path'].cast<String>() : [];
    removeSrc = json['remove_src'];
  }
  bool? accurateProgress;
  String? destFolderPath;
  bool? overwrite;
  List<String>? path;
  bool? removeSrc;
  Params copyWith({
    bool? accurateProgress,
    String? destFolderPath,
    bool? overwrite,
    List<String>? path,
    bool? removeSrc,
  }) =>
      Params(
        accurateProgress: accurateProgress ?? this.accurateProgress,
        destFolderPath: destFolderPath ?? this.destFolderPath,
        overwrite: overwrite ?? this.overwrite,
        path: path ?? this.path,
        removeSrc: removeSrc ?? this.removeSrc,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accurate_progress'] = accurateProgress;
    map['dest_folder_path'] = destFolderPath;
    map['overwrite'] = overwrite;
    map['path'] = path;
    map['remove_src'] = removeSrc;
    return map;
  }
}

/// cancel : {"api":"SYNO.FileStation.CopyMove","method":"stop","params":{"taskid":"FileStation_1696901220D794357E"},"version":3}
/// id : "FileStation_1696901220D794357E"
/// query : {"api":"SYNO.FileStation.CopyMove","method":"status","params":{"taskid":"FileStation_1696901220D794357E"},"version":3}
/// title : ["{0}: {1}","filebrowser:filetable_move","又又酱"]

class Background {
  Background({
    this.cancel,
    this.id,
    this.query,
    this.title,
  });

  Background.fromJson(dynamic json) {
    cancel = json['cancel'] != null ? Action.fromJson(json['cancel']) : null;
    id = json['id'];
    query = json['query'] != null ? Action.fromJson(json['query']) : null;
    title = json['title'] != null ? json['title'].cast<String>() : [];
  }
  Action? cancel;
  String? id;
  Action? query;
  List<String>? title;
  Background copyWith({
    Action? cancel,
    String? id,
    Action? query,
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
/// method : "stop"
/// params : {"taskid":"FileStation_1696901220D794357E"}
/// version : 3

class Action {
  Action({
    this.api,
    this.method,
    this.params,
    this.version,
  });

  Action.fromJson(dynamic json) {
    api = json['api'];
    method = json['method'];
    params = json['params'];
    version = json['version'];
  }
  String? api;
  String? method;
  Map? params;
  num? version;
  Action copyWith({
    String? api,
    String? method,
    Map? params,
    num? version,
  }) =>
      Action(
        api: api ?? this.api,
        method: method ?? this.method,
        params: params ?? this.params,
        version: version ?? this.version,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['api'] = api;
    map['method'] = method;
    map['params'] = params;
    map['version'] = version;
    return map;
  }
}
