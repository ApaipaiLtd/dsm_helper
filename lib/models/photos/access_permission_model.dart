class AccessPermissionModel {
  AccessPermissionModel({
    this.download,
    this.manage,
    this.own,
    this.upload,
    this.view,
  });

  AccessPermissionModel.fromJson(dynamic json) {
    download = json['download'];
    manage = json['manage'];
    own = json['own'];
    upload = json['upload'];
    view = json['view'];
  }
  bool download;
  bool manage;
  bool own;
  bool upload;
  bool view;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['download'] = download;
    map['manage'] = manage;
    map['own'] = own;
    map['upload'] = upload;
    map['view'] = view;
    return map;
  }
}
