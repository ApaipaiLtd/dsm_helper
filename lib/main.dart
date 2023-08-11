import 'dart:io';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/pages/home.dart';
import 'package:dsm_helper/pages/login/accounts.dart';
import 'package:dsm_helper/pages/login/auth_page.dart';
import 'package:dsm_helper/pages/login/login.dart';
import 'package:dsm_helper/providers/audio_player_provider.dart';
import 'package:dsm_helper/providers/setting.dart';
import 'package:dsm_helper/providers/shortcut.dart';
import 'package:dsm_helper/providers/wallpaper.dart';
import 'package:dsm_helper/themes/light.dart';
import 'package:dsm_helper/themes/dark.dart';
import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/util/log.dart';
import 'package:dsm_helper/widgets/keyboard_dismisser.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluwx/fluwx.dart';
import 'package:oktoast/oktoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pangle_flutter/pangle_flutter.dart';
import 'package:provider/provider.dart';
import '/providers/dark_mode.dart';

void main() async {
  HttpClient client = ExtendedNetworkImageProvider.httpClient as HttpClient;
  client.badCertificateCallback = (X509Certificate cert, String host, int port) {
    return true;
  };

  WidgetsFlutterBinding.ensureInitialized();
  String agreement = await Util.getStorage("agreement");
  Log.init();
  if (agreement != null && agreement == "1") {
    registerWxApi(appId: "wxabdf23571f34b49b", universalLink: "https://dsm.apaipai.top/app/").then((value) {
      stopLog();
    });
    // print("初始化穿山甲");
    await pangle.init(
      iOS: IOSConfig(
        appId: '5215470',
        logLevel: PangleLogLevel.error,
      ),
      android: AndroidConfig(
        appId: '5215463',
        debug: false,
        allowShowNotify: true,
        allowShowPageWhenScreenLock: false,
      ),
    );
    // 域名优选
    // Util.appUrl = 
    var check = await Future.any([Util.get('https://dsm.apaipai.top/index/check'),Util.get('https://dsm.flutter.fit/index/check'),]);
    print(check);
    Util.appUrl = "https://${check['data']}";
    // 是否关闭广告
    // 判断是否登录
    bool isForever = false;
    DateTime noAdTime;
    Util.isWechatInstalled = await isWeChatInstalled;
    String userToken = await Util.getStorage("user_token");
    String noAdTimeStr = await Util.getStorage("no_ad_time");
    if (noAdTimeStr.isNotBlank) {
      noAdTime = DateTime.parse(noAdTimeStr);
    }
    if (userToken.isNotBlank) {
      var res = await Util.post("${Util.appUrl}/vip/info", data: {"token": userToken});
      if (res['code'] == 1) {
        isForever = Util.vipForever = res['data']['is_forever'] == 1;
        if (res['data']['vip_expire_time'] != null) {
          DateTime vipExpireTime = DateTime.parse(res['data']['vip_expire_time']);
          Util.vipExpireTime = vipExpireTime;
          if (noAdTime == null) {
            if (vipExpireTime.isAfter(DateTime.now())) {
              noAdTime = vipExpireTime;
            }
          } else {
            if (vipExpireTime.isAfter(noAdTime)) {
              noAdTime = vipExpireTime;
            }
          }
        }
      }
    }

    if (isForever || (noAdTime != null && noAdTime.isAfter(DateTime.now()))) {
      // 处于关闭广告有效期内
      if (kDebugMode) {
        debugPrint("免广告有效期内");
      }
    } else {
      Util.removeStorage("no_ad_time");
      pangle.loadSplashAd(
        iOS: IOSSplashConfig(slotId: '887561543'),
        android: AndroidSplashConfig(slotId: '887561531', isExpress: false),
      );
    }
  }
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  Util.downloadSavePath = await Util.getStorage("download_save_path") ?? "/storage/emulated/0/dsm_helper/Download";
  Util.getStorage("download_wifi_only").then((value) {
    if (value != null) {
      Util.downloadWifiOnly = value == "1";
    } else {
      Util.downloadWifiOnly = true;
    }
  });
  //判断是否需要启动密码
  bool launchAuth = false;
  bool password = false;
  bool biometrics = false;
  bool showShortcuts = true;
  bool showWallpaper = true;
  int refreshDuration = 10;
  bool launchAccountPage = false;
  String launchAuthStr = await Util.getStorage("launch_auth");
  String launchAuthPasswordStr = await Util.getStorage("launch_auth_password");
  String launchAuthBiometricsStr = await Util.getStorage("launch_auth_biometrics");
  String launchAccountPageStr = await Util.getStorage('launch_account_page');
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Util.appName = packageInfo.appName;
  if (launchAuthStr != null) {
    launchAuth = launchAuthStr == "1";
  } else {
    launchAuth = false;
  }
  if (launchAuthPasswordStr != null) {
    password = launchAuthPasswordStr == "1";
  } else {
    password = false;
  }
  if (launchAuthBiometricsStr != null) {
    biometrics = launchAuthBiometricsStr == "1";
  } else {
    biometrics = false;
  }

  if (launchAccountPageStr != null) {
    launchAccountPage = launchAccountPageStr == "1";
  } else {
    launchAccountPage = false;
  }

  bool authPage = launchAuth && (password || biometrics);

  //暗色模式
  String darkModeStr = await Util.getStorage("dark_mode");
  int darkMode = 2;
  if (darkModeStr.isNotBlank) {
    darkMode = int.parse(darkModeStr);
  }

  //震动开关
  String vibrateOn = await Util.getStorage("vibrate_on");
  String vibrateNormal = await Util.getStorage("vibrate_normal");
  String vibrateWarning = await Util.getStorage("vibrate_warning");
  String showShortcutsStr = await Util.getStorage("show_shortcut");
  if (showShortcutsStr.isNotBlank) {
    showShortcuts = showShortcutsStr == "1";
  }
  String showWallpaperStr = await Util.getStorage("show_wallpaper");
  if (showWallpaperStr.isNotBlank) {
    showWallpaper = showWallpaperStr == "1";
  }
  String refreshDurationStr = await Util.getStorage("refresh_duration");
  if (refreshDurationStr.isNotBlank) {
    refreshDuration = int.parse(refreshDurationStr);
  }
  if (vibrateOn.isNotBlank) {
    Util.vibrateOn = vibrateOn == "1";
  } else {
    Util.vibrateOn = true;
  }
  if (vibrateNormal.isNotBlank) {
    Util.vibrateNormal = vibrateNormal == "1";
  } else {
    Util.vibrateNormal = true;
  }
  if (vibrateWarning.isNotBlank) {
    Util.vibrateWarning = vibrateWarning == "1";
  } else {
    Util.vibrateWarning = true;
  }
  String checkSsl = await Util.getStorage("check_ssl");
  if (checkSsl.isNotBlank) {
    Util.checkSsl = checkSsl == "1";
  } else {
    Util.checkSsl = true;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DarkModeProvider(darkMode)),
        ChangeNotifierProvider.value(value: ShortcutProvider(showShortcuts)),
        ChangeNotifierProvider.value(value: WallpaperProvider(showWallpaper)),
        ChangeNotifierProvider.value(value: SettingProvider(refreshDuration)),
        ChangeNotifierProvider.value(value: AudioPlayerProvider()),
      ],
      child: MyApp(authPage, launchAccountPage),
    ),
  );

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }
}

class MyApp extends StatefulWidget {
  final bool authPage;
  final bool launchAccountPage;
  MyApp(this.authPage, this.launchAccountPage);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(
      builder: (context, darkModeProvider, _) {
        return OKToast(
          child: KeyboardDismisser(
            child: WeuiToastConfig(
              data: WeuiToastConfigData(
                toastAlignment: Alignment.center,
                loadingText: "请稍后",
                loadingBackButtonClose: true,
              ),
              child: MaterialApp(
                title: '${Util.appName}',
                debugShowCheckedModeBanner: false,
                theme: darkModeProvider.darkMode == 2 ? lightTheme : (darkModeProvider.darkMode == 0 ? lightTheme : darkTheme),
                darkTheme: darkModeProvider.darkMode == 2 ? darkTheme : null,
                localizationsDelegates: [
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('zh', 'CN'),
                ],
                home: widget.authPage
                    ? AuthPage(
                        launchAccountPage: widget.launchAccountPage,
                      )
                    : widget.launchAccountPage
                        ? Accounts()
                        : Login(),
                routes: {
                  "/login": (BuildContext context) => Login(),
                  "/home": (BuildContext context) => Home(),
                  "/accounts": (BuildContext context) => Accounts(),
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
