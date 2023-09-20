class DsmResponse<T> {
  bool? success;
  T? data;
  Map? error;
  DsmResponse({this.success, this.data});
  DsmResponse.fromJson(dynamic json, [T Function(dynamic)? parser]) {
    success = json['success'];
    if (json['data'] != null && parser != null) {
      data = parser(json['data']);
    } else {
      data = json['data'];
    }
    error = json['error'];
  }
}
