import 'package:dio/dio.dart';

class HttpUtil {
  Dio? dio;

  bool isShowLoginDialog = false;

  init(String baseUrl, {String? deviceId, String? sid}) {
    // final Directory appDocDir = await getApplicationDocumentsDirectory();
    // final String appDocPath = appDocDir.path;
    // final cookieJar = PersistCookieJar(
    //   ignoreExpires: true,
    //   storage: FileStorage(appDocPath + "/.cookies/"),
    // );
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 60),
      contentType: Headers.formUrlEncodedContentType,
      headers: {},
    );
    dio = Dio(options);
    // if (kDebugMode) {
    //   (dio?.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    //     client.findProxy = (uri) {
    //       return "PROXY 192.168.0.107:8888";
    //     };
    //     return client;
    //   }; //
    // }
    // CookieJar cookieJar = CookieJar();
    dio?.interceptors
      ?..add(InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
        options.headers['did'] = deviceId;
        options.headers['sid'] = sid;
        options.headers['Accept-Language'] = "zh-CN,zh;q=0.9,en;q=0.8";
        return handler.next(options);
      }, onResponse: (Response response, handler) async {
        return handler.next(response);
      }, onError: (DioException error, handler) async {
        return handler.reject(error);
      }))
      ..add(LogInterceptor(request: false, requestBody: true, responseBody: true, responseHeader: false, requestHeader: false));
    // ..add(CookieManager(cookieJar));
  }

  Future get(String url, {Map<String, dynamic>? parameters, Options? options}) async {
    Response response = await dio!.get(url, queryParameters: parameters, options: options);
    return response.data;
  }

  Future post(String url, {dynamic data, Map<String, dynamic>? parameters, Options? options}) async {
    Response response = await dio!.post(url, data: data, queryParameters: parameters, options: options);
    return response.data;
  }

  Future put(String url, {dynamic data, Map<String, dynamic>? parameters, Options? options}) async {
    Response response = await dio!.put(url, data: data, queryParameters: parameters, options: options);
    return response.data;
  }

  Future delete(String url, {dynamic data, Map<String, dynamic>? parameters, Options? options}) async {
    Response response = await dio!.delete(url, data: data, queryParameters: parameters, options: options);
    return response.data;
  }

  Future<String> upload(String url, {required MultipartFile file, String fileName = "uploadFile", dynamic data, Map<String, dynamic>? parameters, Options? options}) async {
    data = data ?? <String, dynamic>{};
    data[fileName] = file;
    FormData formData = FormData.fromMap(data);

    Response response = await dio!.post(url, data: formData, queryParameters: parameters, options: options);
    if (response.data != null && response.data['code'] == 200) {
      return response.data['data']['uploadFilePath'];
    } else {
      return "";
    }
  }
}
