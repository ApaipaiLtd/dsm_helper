/// tasks : [{"action":"清空所有的回收站","can_delete":true,"can_edit":true,"can_run":true,"enable":true,"id":3,"name":"recycle","next_trigger_time":"2023-09-17 02:00","owner":"root","type":"recycle"}]
/// total : 1

class TaskScheduler {
  TaskScheduler({
    this.tasks,
    this.total,
  });

  TaskScheduler.fromJson(dynamic json) {
    if (json['tasks'] != null) {
      tasks = [];
      json['tasks'].forEach((v) {
        tasks?.add(Tasks.fromJson(v));
      });
    }
    total = json['total'];
  }
  List<Tasks>? tasks;
  num? total;
  TaskScheduler copyWith({
    List<Tasks>? tasks,
    num? total,
  }) =>
      TaskScheduler(
        tasks: tasks ?? this.tasks,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tasks != null) {
      map['tasks'] = tasks?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    return map;
  }
}

/// action : "清空所有的回收站"
/// can_delete : true
/// can_edit : true
/// can_run : true
/// enable : true
/// id : 3
/// name : "recycle"
/// next_trigger_time : "2023-09-17 02:00"
/// owner : "root"
/// type : "recycle"

class Tasks {
  Tasks({
    this.action,
    this.canDelete,
    this.canEdit,
    this.canRun,
    this.enable,
    this.id,
    this.name,
    this.nextTriggerTime,
    this.owner,
    this.type,
  });

  Tasks.fromJson(dynamic json) {
    action = json['action'];
    canDelete = json['can_delete'];
    canEdit = json['can_edit'];
    canRun = json['can_run'];
    enable = json['enable'];
    id = json['id'];
    name = json['name'];
    nextTriggerTime = json['next_trigger_time'];
    owner = json['owner'];
    type = json['type'];
  }
  String? action;
  bool? canDelete;
  bool? canEdit;
  bool? canRun;
  bool? enable;
  num? id;
  String? name;
  String? nextTriggerTime;
  String? owner;
  String? type;
  Tasks copyWith({
    String? action,
    bool? canDelete,
    bool? canEdit,
    bool? canRun,
    bool? enable,
    num? id,
    String? name,
    String? nextTriggerTime,
    String? owner,
    String? type,
  }) =>
      Tasks(
        action: action ?? this.action,
        canDelete: canDelete ?? this.canDelete,
        canEdit: canEdit ?? this.canEdit,
        canRun: canRun ?? this.canRun,
        enable: enable ?? this.enable,
        id: id ?? this.id,
        name: name ?? this.name,
        nextTriggerTime: nextTriggerTime ?? this.nextTriggerTime,
        owner: owner ?? this.owner,
        type: type ?? this.type,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action'] = action;
    map['can_delete'] = canDelete;
    map['can_edit'] = canEdit;
    map['can_run'] = canRun;
    map['enable'] = enable;
    map['id'] = id;
    map['name'] = name;
    map['next_trigger_time'] = nextTriggerTime;
    map['owner'] = owner;
    map['type'] = type;
    return map;
  }
}
