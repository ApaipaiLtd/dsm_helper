import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cool_ui/cool_ui.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dsm_helper/models/setting/group_model.dart';
import 'package:dsm_helper/pages/download/download.dart';
import 'package:dsm_helper/pages/update/update.dart';
import 'package:dsm_helper/util/api.dart';
import 'package:dsm_helper/util/log.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:oktoast/oktoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibrate/vibrate.dart';

export 'package:dsm_helper/extensions/datetime.dart';
export 'package:dsm_helper/extensions/int.dart';
export 'package:dsm_helper/extensions/int.dart';
export 'package:dsm_helper/extensions/string.dart';
export 'package:dsm_helper/util/api.dart';

enum FileTypeEnum {
  folder,
  image,
  movie,
  music,
  ps,
  html,
  word,
  ppt,
  excel,
  text,
  zip,
  code,
  other,
  pdf,
  apk,
  iso,
}

enum UploadStatus {
  running,
  complete,
  failed,
  canceled,
  wait,
}

class Util {
  static GroupsModel groups = GroupsModel(
    qq: [
      GroupModel(name: "交流群①", no: "240557031", key: "4woOsiYfPZO4lZ08fX4el43n926mj1r5", status: "已满"),
      GroupModel(name: "交流群②", no: "97137990", key: "qp8XE0Ts1b_qR4wt5PThPJqhdWkBT2u5", status: "已满"),
      GroupModel(name: "交流群③", no: "133302624", key: "rOqv_Fq8g4W_Xaa95B7f0AmN_xxlvHu-", status: ""),
    ],
    channel: [
      GroupModel(name: "QQ频道", no: "群晖助手交流反馈", key: "https://qun.qq.com/qqweb/qunpro/share?_wv=3&_wwv=128&appChannel=share&biz=ka&businessType=5&from=246611&inviteCode=206Vc8vi4fl&mainSourceId=qr_code&subSourceId=pic4&jumpsource=shorturl#/out", status: ""),
    ],
    wechat: [
      GroupModel(name: "群晖助手", no: "", key: "", status: "受限"),
      GroupModel(name: "群晖助手APP", no: "", key: "", status: ""),
    ],
  );
  static bool isWechatInstalled = false;
  static DateTime vipExpireTime = DateTime.now();
  static bool vipForever = false;
  static String appUrl = "https://dsm.apaipai.top";
  static String sid = "";
  static String account = "";
  static String baseUrl = "https://dsm.apaipai.top";
  static String hostname = "";
  static int version = 6;
  static bool checkSsl = true;
  static bool vibrateOn = true;
  static bool vibrateWarning = true;
  static bool vibrateNormal = true;
  static String cookie = "";
  static Map strings = {};
  static Map notifyStrings = {};
  static bool isAuthPage = false;
  static GlobalKey<DownloadState> downloadKey = GlobalKey<DownloadState>();
  static String appName = "";

  static String downloadSavePath = "";
  static bool downloadWifiOnly = true;

  static bool get notReviewAccount => account != "jinx";
  static toast(String text) {
    showToast(text ?? "", dismissOtherToast: true, textPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8));
  }

  static String systemVersion(String version) {
    version = version.replaceAll("DSM ", "");
    Util.version = int.parse(version.split(".").first);
    return version;
  }

  static vibrate(FeedbackType type) async {
    if (vibrateOn) {
      bool canVibrate = await Vibrate.canVibrate;
      if (canVibrate) {
        if (type == FeedbackType.warning) {
          if (vibrateWarning) {
            Vibrate.feedback(type);
          }
        } else {
          if (vibrateNormal) {
            Vibrate.feedback(type);
          }
        }
      }
    }
  }

  static int versionCompare(String v1, String v2) {
    String versionName1;
    String buildNumber1;
    String versionName2;
    String buildNumber2;
    List version1 = v1.split("-");
    versionName1 = version1[0];
    if (version1.length > 1) {
      buildNumber1 = version1[1];
    }
    List version2 = v2.split("-");
    versionName2 = version2[0];
    if (version2.length > 1) {
      buildNumber2 = version2[1];
    }
    //对比build
    if (buildNumber1 != null && buildNumber2 != null) {
      return int.parse(buildNumber1).compareTo(int.parse(buildNumber2));
    } else {
      //对比version
      List versionNames1 = versionName1.split(".");
      List versionNames2 = versionName2.split(".");
      int minLength = min(versionNames1.length, versionNames2.length);
      int position = 0;
      int diff = 0;

      while (position < minLength) {
        diff = int.parse(versionNames1[position]) - int.parse(versionNames2[position]);
        if (diff != 0) {
          break;
        }
        position++;
      }
      return diff;
    }
  }

  static String parseOpTime(String optime) {
    List items = optime.split(":");
    int days = int.parse(items[0]) ~/ 24;
    items[0] = (int.parse(items[0]) % 24).toString().padLeft(2, "0");
    items[1] = items[1].toString().padLeft(2, "0");
    items[2] = items[2].toString().padLeft(2, "0");
    return "${days > 0 ? "$days天" : ""} ${items.join(":")}";
  }

  static Map timeLong(int ticket) {
    int seconds = ticket % 60;
    int minutes = ticket ~/ 60 % 60;
    int hours = ticket ~/ 60 ~/ 60;
    return {
      "hours": hours,
      "minutes": minutes,
      "seconds": seconds,
    };
  }

  static String utf8Encode(String data) {
    List<int> utf8Str = utf8.encode(data);
    String encoded = utf8Str.map((e) => e.toRadixString(16)).join("");
    return encoded;
  }

  static Color getAdjustColor(Color baseColor, double amount) {
    Map<String, int> colors = {'r': baseColor.red, 'g': baseColor.green, 'b': baseColor.blue};

    colors = colors.map((key, value) {
      if (value + amount < 0) {
        return MapEntry(key, 0);
      }
      if (value + amount > 255) {
        return MapEntry(key, 255);
      }
      return MapEntry(key, (value + amount).floor());
    });
    return Color.fromRGBO(colors['r'], colors['g'], colors['b'], 1);
  }

  static FileTypeEnum fileType(String name) {
    List<String> image = ["png", "jpg", "jpeg", "gif", "bmp", "ico", "tiff", "tif"];
    List<String> movie = [
      "3gp",
      "3g2",
      "asf",
      "dat",
      "divx",
      "dvr-ms",
      "m2t",
      "m2ts",
      "m4v",
      "mkv",
      "mp4",
      "mts",
      "mov",
      "qt",
      "tp",
      "trp",
      "ts",
      "vob",
      "wmv",
      "xvid",
      "ac3",
      "amr",
      "rm",
      "rmvb",
      "ifo",
      "mpeg",
      "mpg",
      "mpe",
      "m1v",
      "m2v",
      "mpeg1",
      "mpeg2",
      "mpeg4",
      "ogv",
      "webm",
      "flv",
      "avi",
      "swf",
      "f4v"
    ];
    List<String> music = ["aac", "flac", "m4a", "m4b", "aif", "ogg", "pcm", "wav", "cda", "mid", "mp2", "mka", "mpc", "ape", "ra", "ac3", "dts", "wma", "mp3", "mp1", "mp2", "mpa", "ram", "m4p", "aiff", "dsf", "dff", "m3u", "wpl", "aiff"];
    List<String> ps = ["psd"];
    List<String> html = ["html", "htm", "shtml", "url"];
    List<String> word = ["doc", "docx"];
    List<String> ppt = ["ppt", "pptx"];
    List<String> excel = ["xls", "xlsx"];
    List<String> text = ["txt", "log"];
    List<String> zip = ["zip", "gz", "tar", "tgz", "tbz", "bz2", "rar", "7z"];
    List<String> code = ["py", "php", "c", "java", "jsp", "js", "css", "sql", "nfo", "xml", "kt", "conf", "json", "md", "sh"];
    List<String> pdf = ["pdf"];
    List<String> apk = ["apk"];
    List<String> iso = ["iso"];
    String ext = name.split(".").last.toLowerCase();
    if (image.contains(ext)) {
      return FileTypeEnum.image;
    } else if (movie.contains(ext)) {
      return FileTypeEnum.movie;
    } else if (music.contains(ext)) {
      return FileTypeEnum.music;
    } else if (ps.contains(ext)) {
      return FileTypeEnum.ps;
    } else if (html.contains(ext)) {
      return FileTypeEnum.code;
    } else if (word.contains(ext)) {
      return FileTypeEnum.word;
    } else if (ppt.contains(ext)) {
      return FileTypeEnum.ppt;
    } else if (excel.contains(ext)) {
      return FileTypeEnum.excel;
    } else if (text.contains(ext)) {
      return FileTypeEnum.text;
    } else if (zip.contains(ext)) {
      return FileTypeEnum.zip;
    } else if (code.contains(ext)) {
      return FileTypeEnum.code;
    } else if (pdf.contains(ext)) {
      return FileTypeEnum.pdf;
    } else if (apk.contains(ext)) {
      return FileTypeEnum.apk;
    } else if (iso.contains(ext)) {
      return FileTypeEnum.iso;
    } else {
      return FileTypeEnum.other;
    }
  }

  static Future<dynamic> get(String url, {Map<String, dynamic> data, bool login: true, String host, Map<String, dynamic> headers, CancelToken cancelToken, bool checkSsl, String cookie, int timeout = 20, bool decode: true}) async {
    headers = headers ?? {};
    headers['Cookie'] = cookie ?? Util.cookie;

    headers["Accept-Language"] = "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6,zh-TW;q=0.5";
    headers['origin'] = host ?? baseUrl;
    headers['referer'] = host ?? baseUrl;
    Dio dio = new Dio(
      BaseOptions(
        baseUrl: url.startsWith("http") ? "" : ((host ?? baseUrl) + "/webapi/"),
        headers: headers,
        // connectTimeout: timeout,
      ),
    );
    // if (kDebugMode) {
    //   (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    //     client.findProxy = (uri) {
    //       return "PROXY 192.168.0.107:7890";
    //     };
    //     return client;
    //   }; //
    // }
    //忽略Https校验
    if (!(checkSsl ?? Util.checkSsl)) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (cert, host, port) {
          return true;
        };
        return client;
      };
    }

    Response response;
    try {
      response = await dio.get(url, queryParameters: data, cancelToken: cancelToken);
      if (url == "auth.cgi") {
        if (response.headers.map['set-cookie'] != null && response.headers.map['set-cookie'].length > 0) {
          List cookies = [];
          //从原始cookie中提取did
          String did = "";
          if (Util.cookie != null && Util.cookie != '') {
            List originCookies = Util.cookie.split("; ");
            for (int i = 0; i < originCookies.length; i++) {
              Cookie cookie = Cookie.fromSetCookieValue(originCookies[i]);
              if (cookie.name == "did") {
                did = cookie.value;
              }
            }
          }
          bool haveDid = false;
          for (int i = 0; i < response.headers.map['set-cookie'].length; i++) {
            Cookie cookie = Cookie.fromSetCookieValue(response.headers.map['set-cookie'][i]);
            cookies.add("${cookie.name}=${cookie.value}");
            if (cookie.name == "did") {
              haveDid = true;
            }
          }
          //如果新cookie中不含did
          if (!haveDid && did != "") {
            cookies.add("did=$did");
          }

          Util.cookie = cookies.join("; ");
          setStorage("smid", Util.cookie);
        }
      }

      if (response.data is String && decode) {
        try {
          return json.decode(response.data);
        } catch (e) {
          return response.data;
        }
      } else if (response.data is Map) {
        return response.data;
      } else {
        return response.data;
      }
    } on DioError catch (error) {
      String code = "";
      if (error.message != null && error.message.contains("CERTIFICATE_VERIFY_FAILED")) {
        code = "SSL/HTTPS证书有误";
      } else {
        code = error.message;
      }
      print("请求出错:${headers['origin']} $url");
      return {
        "success": false,
        "error": {"code": code},
        "data": null
      };
    } catch (e) {
      print(e);
    }
  }

  static String base64ToString(String source) {
    List<int> bytes = base64.decode(source);
    String result = utf8.decode(bytes);

    return result;
  }

  static void logPrint(Object obj) {
    Log.logger.info(obj);
  }

  static Future<dynamic> post(String url, {Map<String, dynamic> data, bool login: true, String host, CancelToken cancelToken, Map<String, dynamic> headers, bool checkSsl, String cookie, int timeout = 20}) async {
    headers = headers ?? {};
    headers['Cookie'] = cookie ?? Util.cookie;
    headers["Accept-Language"] = "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6,zh-TW;q=0.5";
    headers['origin'] = host ?? baseUrl;
    headers['referer'] = host ?? baseUrl;
    Dio dio = new Dio(
      new BaseOptions(
        // connectTimeout: timeout,
        baseUrl: (host ?? baseUrl) + "/webapi/",
        contentType: "application/x-www-form-urlencoded",
        headers: headers,
      ),
    );
    // if (kDebugMode) {
    //   (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    //     client.findProxy = (uri) {
    //       return "PROXY 192.168.0.107:7890";
    //     };
    //     return client;
    //   }; //
    // }
    // (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    //   client.findProxy = (uri) {
    //     return "PROXY 192.168.1.159:8888";
    //   };
    // };
    //忽略Https校验
    // dio.interceptors.add(LogInterceptor(
    //   requestHeader: false,
    //   request: false,
    //   requestBody: true,
    //   responseBody: true,
    //   responseHeader: false,
    //   logPrint: logPrint,
    // ));
    if (!(checkSsl ?? Util.checkSsl)) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (cert, host, port) {
          return true;
        };
        return client;
      };
    }
    Response response;
    try {
      response = await dio.post(url, data: data, cancelToken: cancelToken);

      return response.data;
    } on DioError catch (error) {
      debugPrint("请求出错:${headers['origin']} $url 请求内容:$data");
      return {
        "success": false,
        "error": {"code": error.message},
        "data": null
      };
    }
  }

  static Future<dynamic> upload(String url, {Map<String, dynamic> params, Map<String, dynamic> data, bool login: true, String host, CancelToken cancelToken, Function(int, int) onSendProgress, Map<String, dynamic> headers}) async {
    headers = headers ?? {};
    headers['Cookie'] = Util.cookie;
    headers['Accept-Encoding'] = "gzip, deflate";
    headers['Accept'] = "*/*";
    // headers["Accept-Language"] = "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6,zh-TW;q=0.5";
    // headers['origin'] = host ?? baseUrl;
    // headers['referer'] = host ?? baseUrl;
    // headers['Host'] = host ?? baseUrl;
    // headers['Connection'] = "keep-alive";
    // headers['User-Agent'] = "DS get 1.12.4 rv:168 (Dalvik/2.1.0 (Linux; U; Android 11; MI 9 Build/RKQ1.200826.002))";
    //Proxy-Connection: keep-alive
    // print(headers);
    Dio dio = new Dio(
      new BaseOptions(
        baseUrl: (host ?? baseUrl) + "/webapi/",
        headers: headers,
      ),
    );
    // (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    //   client.findProxy = (uri) {
    //     return "PROXY 192.168.0.107:8888";
    //   };
    // };
    //忽略Https校验
    if (!checkSsl) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (cert, host, port) {
          return true;
        };
        return client;
      };
    }
    FormData formData = FormData.fromMap(data);
    Response response;
    try {
      response = await dio.post(
        url,
        queryParameters: params,
        data: formData,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
      if (response.data is String) {
        return json.decode(response.data);
      } else if (response.data is Map) {
        return response.data;
      }
    } on DioError catch (error) {
      debugPrint("请求出错:$baseUrl/$url 请求内容:$data msg:${error.message}");
      return {
        "success": false,
        "error": {"code": error.message},
        "data": null
      };
    }
  }

  static Future<String> fileExist(String fileName) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    if (await File(tempPath + "/" + fileName).exists()) {
      return tempPath + "/" + fileName;
    } else {
      return null;
    }
  }

  static Future<String> getDownloadPath() async {
    // final directory = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return downloadSavePath;
      // if (androidInfo.version.sdkInt < 30) {
      //   return downloadSavePath;
      // } else {
      //   final directory = await getExternalStorageDirectory();
      //   return directory.path + Platform.pathSeparator + "Download";
      // }
    } else {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + "Download";
    }
  }

  static Future<dynamic> downloadPkg(String saveName, String url, onReceiveProgress, CancelToken cancelToken) async {
    Dio dio = new Dio();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    Response response;

    try {
      response = await dio.download(url, tempPath + Platform.pathSeparator + saveName, deleteOnError: true, onReceiveProgress: onReceiveProgress, cancelToken: cancelToken);
      return {"code": 1, "msg": "下载完成", "data": tempPath + Platform.pathSeparator + saveName};
    } on DioError catch (error) {
      debugPrint("请求出错:$url");
      if (error.type == DioErrorType.cancel) {
        return {"code": 0, "msg": "下载已取消", "data": null};
      } else {
        return {"code": 0, "msg": "网络错误", "data": null};
      }
    }
  }

  static String getUniqueName(String path, String name) {
    bool unique = true;
    int num = 0;
    String uniqueName;
    String ext = name.split(".").last;
    String fullPath = "";
    while (unique) {
      if (num == 0) {
        uniqueName = name;
      } else {
        uniqueName = name.replaceAll(".$ext", "-$num.$ext");
      }
      fullPath = path + Platform.pathSeparator + uniqueName;
      if (File(fullPath).existsSync()) {
        debugPrint("文件存在");
        num++;
      } else {
        debugPrint("文件不存在");
        unique = false;
      }
    }
    return uniqueName;
    // return fullPath;
  }

  static Future<String> download(String saveName, String url) async {
    //检查权限
    // bool permission = false;
    // permission = await Permission.storage.request().isGranted;
    // if (!permission) {
    //   Util.toast("请先授权APP访问存储权限");
    //   return "";
    // }
    String savePath = await getDownloadPath();
    debugPrint("savePath:$savePath");
    Directory saveDir = Directory(savePath);
    if (!saveDir.existsSync()) {
      debugPrint("文件夹不存在");
      Directory dir = await saveDir.create(recursive: true);
      print(dir);
    } else {
      debugPrint("文件夹已存在");
    }

    saveName = getUniqueName(savePath, saveName);
    debugPrint(saveName);
    // CancelToken cancelToken = CancelToken();
    // DioDownload().downloadFile(url: url, savePath: saveName, cancelToken: cancelToken);
    String taskId = await FlutterDownloader.enqueue(url: url, fileName: saveName, savedDir: savePath, showNotification: true, openFileFromNotification: true);
    return taskId;
  }

  static String formatSize(num size, {int format = 1024, int fixed = 2, bool showByte = false}) {
    if (size == 0) {
      return "0${showByte ? 'Bytes' : ''}";
    } else if (size < format) {
      return "$size${showByte ? 'Bytes' : ''}";
    } else if (size < pow(format, 2)) {
      return "${(size / format).toStringAsFixed(fixed)}K";
    } else if (size < pow(format, 3)) {
      return "${(size / pow(format, 2)).toStringAsFixed(fixed)}M";
    } else if (size < pow(format, 4)) {
      return "${(size / pow(format, 3)).toStringAsFixed(fixed)}G";
    } else {
      return "${(size / pow(format, 4)).toStringAsFixed(fixed)}T";
    }
  }

  static double chartInterval(num maxNetworkSpeed) {
    if (maxNetworkSpeed < 1024) {
      return 102.4;
    } else if (maxNetworkSpeed < 1024 * 2) {
      return 102.4 * 2;
    } else if (maxNetworkSpeed < 1024 * 5) {
      return 1024.0;
    } else if (maxNetworkSpeed < 1024 * 10) {
      return 1024.0 * 2;
    } else if (maxNetworkSpeed < pow(1024, 2)) {
      return 1024.0 * 200;
    } else if (maxNetworkSpeed < pow(1024, 2) * 5) {
      return 1.0 * pow(1024, 2);
    } else if (maxNetworkSpeed < pow(1024, 2) * 10) {
      return 2.0 * pow(1024, 2);
    } else if (maxNetworkSpeed < pow(1024, 2) * 20) {
      return 4.0 * pow(1024, 2);
    } else if (maxNetworkSpeed < pow(1024, 2) * 40) {
      return 8.0 * pow(1024, 2);
    } else if (maxNetworkSpeed < pow(1024, 2) * 50) {
      return 10.0 * pow(1024, 2);
    } else if (maxNetworkSpeed < pow(1024, 2) * 100) {
      return 20.0 * pow(1024, 2);
    } else {
      return 50.0 * pow(1024, 2);
    }
  }

  static String timeRemaining(int seconds) {
    int hour = seconds / 60 ~/ 60;
    int minute = (seconds - hour * 60 * 60) ~/ 60;
    int second = seconds ~/ 60;
    return "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}";
  }

  static Future<bool> setStorage(String name, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(name, value ?? "");
  }

  static Future<String> getStorage(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  static Future<bool> removeStorage(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(name);
  }

  static Future<Map> saveImage(String url, {BuildContext context, bool showLoading: true}) async {
    var hide;
    try {
      bool permission = false;
      if (Platform.isAndroid) {
        permission = await Permission.storage.request().isGranted;
        print(permission);
      } else {
        permission = await Permission.photos.request().isGranted;
      }
      if (!permission) {
        return {
          "code": 2,
          "msg": "permission",
        };
      }
      if (showLoading) {
        hide = showWeuiLoadingToast(context: context, message: Text("保存中"));
      }
      File save;
      if (url.startsWith("http")) {
        File image = await getCachedImageFile(url);
        save = await image.copy(image.path + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
      } else {
        save = File(url);
      }
      bool result = await GallerySaver.saveImage(save.path, albumName: Util.appName);
      if (showLoading) {
        hide();
      }
      if (result) {
        return {
          "code": 1,
          "msg": "success",
        };
      } else {
        return {
          "code": 0,
          "msg": "error",
        };
      }
    } catch (e) {
      if (hide != null) {
        hide();
      }
      return {
        "code": 0,
        "msg": "error",
      };
    }
  }

  static String rand() {
    var r = Random().nextInt(2147483646);
    return r.toString();
  }

  static checkUpdate(bool showMsg, BuildContext context, {bool force = false}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String buildNumber = packageInfo.buildNumber;
    if (kDebugMode) {
      buildNumber = '1';
    }
    var res = await Api.update(buildNumber, force: force); //packageInfo.buildNumber
    if (res['code'] == 1) {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) {
            return Update(res['data']);
          },
          settings: RouteSettings(name: "update")));
    } else {
      if (showMsg) {
        toast(res['msg']);
      }
    }
  }
}
