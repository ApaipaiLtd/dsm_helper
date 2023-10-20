import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_exception.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_response.dart';
import 'package:dsm_helper/models/api_model.dart';
import 'package:dsm_helper/models/base_model.dart';
import 'package:dsm_helper/utils/http_util.dart';
import 'package:dsm_helper/utils/log.dart';

class DsmApi extends HttpUtil {
  String? baseUrl;
  String? deviceId;
  String? sid;
  DsmApi({String baseUrl = "", String? deviceId, String? sid}) {
    this.baseUrl = baseUrl;
    this.deviceId = deviceId;
    this.sid = sid;
    super.init(baseUrl, deviceId: deviceId, sid: sid);
  }

  Future<DsmResponse> entry<T>(
    String api,
    String method, {
    bool post = true,
    dynamic data,
    String? path,
    int? version,
    Map<String, dynamic>? parameters,
    Options? options,
    T Function(dynamic)? parser,
  }) async {
    late Response response;

    if (post) {
      Map<String, dynamic> body = {};
      if (data != null) {
        body.addAll(data);
      }
      body['version'] = version ?? ApiModel.apiInfo[api]?.version ?? 1;
      body['api'] = api;
      body['method'] = method;
      body['_sid'] = sid;
      response = await dio!.post("/webapi/entry.cgi${path == null ? '' : "/$path"}", data: body, queryParameters: parameters, options: options);
    } else {
      Map<String, dynamic> query = {};
      if (parameters != null) {
        query.addAll(parameters);
      }
      query['version'] = version ?? ApiModel.apiInfo[api]?.version ?? 1;
      query['api'] = api;
      query['method'] = method;
      query['_sid'] = sid;
      response = await dio!.get("/webapi/entry.cgi${path == null ? '' : "/$path"}", queryParameters: query, options: options);
    }
    if (response.data['success']) {
      DsmResponse res = DsmResponse.fromJson(response.data, parser);
      return res;
    } else {
      throw DsmException(response.data['error']['code']);
    }
  }

  Future<List<DsmResponse>> batch({
    required List<BaseModel> apis,
    String mode = "sequential", // parallel
    Map<String, dynamic>? parameters,
    Options? options,
    bool stopWhenError = false,
  }) async {
    Map<String, dynamic> data = {};
    data['version'] = 1;
    data['api'] = 'SYNO.Entry.Request';
    data['method'] = 'request';
    data['mode'] = '"$mode"';
    data['stop_when_error'] = stopWhenError;
    data['compound'] = jsonEncode(apis.map((e) {
      Map<String, dynamic> data = {
        "api": e.api,
        "method": e.method,
        "version": e.version,
      };
      if (e.data != null) {
        data.addAll(e.data!);
      }
      return data;
    }).toList());
    data['_sid'] = sid;
    Response response = await dio!.post("/webapi/entry.cgi", data: data, queryParameters: parameters, options: options);
    List<DsmResponse> res = [];
    Log.logger.info(response.data);
    if (response.data['success']) {
      for (int i = 0; i < apis.length; i++) {
        res.add(DsmResponse.fromJson(response.data['data']['result'][i], apis[i].fromJson));
      }
    }
    return res;
  }
}
