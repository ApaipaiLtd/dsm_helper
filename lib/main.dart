import 'dart:async';
import 'dart:io';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/pages/control_panel/control_panel.dart';
import 'package:dsm_helper/pages/docker/docker.dart';
import 'package:dsm_helper/pages/download_station/download_station.dart';
import 'package:dsm_helper/pages/home.dart';
import 'package:dsm_helper/pages/login/auth_page.dart';
import 'package:dsm_helper/pages/moments/moments.dart';
import 'package:dsm_helper/pages/packages/packages.dart';
import 'package:dsm_helper/pages/photos/photos.dart';
import 'package:dsm_helper/pages/resource_monitor/resource_monitor.dart';
import 'package:dsm_helper/pages/security_scan/security_scan.dart';
import 'package:dsm_helper/pages/splash/splash.dart';
import 'package:dsm_helper/pages/storage_manager/storage_manager.dart';
import 'package:dsm_helper/pages/virtual_machine/virtual_machine.dart';
import 'package:dsm_helper/providers/audio_player_provider.dart';
import 'package:dsm_helper/providers/external_device_provider.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/providers/setting_provider.dart';
import 'package:dsm_helper/providers/storage_provider.dart';
import 'package:dsm_helper/providers/system_info_provider.dart';
import 'package:dsm_helper/providers/utilization_provider.dart';
import 'package:dsm_helper/themes/light.dart';
import 'package:dsm_helper/themes/dark.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/utils/log.dart';
import 'package:dsm_helper/widgets/keyboard_dismisser.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluwx/fluwx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pangle_flutter/pangle_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';
import '/providers/dark_mode.dart';

void main() async {
  HttpClient client = ExtendedNetworkImageProvider.httpClient as HttpClient;
  client.badCertificateCallback = (X509Certificate cert, String host, int port) {
    return true;
  };

  Future<String> getBestDomain(List<String> domains) async {
    final completer = Completer<String>();
    for (String domain in domains) {
      try {
        Utils.get(domain).then((res) {
          if (res != null && res['code'] == 1) {
            if (!completer.isCompleted) {
              completer.complete("http://${res['data']}");
            }
          }
        });
      } catch (e) {}
    }
    return completer.future;
  }

  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  bool agreement = SpUtil.getBool("agreement", defValue: false)!;
  Log.init();
  if (agreement) {
    Fluwx fluwx = Fluwx();
    fluwx.registerApi(appId: "wxabdf23571f34b49b", universalLink: "https://dsm.apaipai.top/app/");
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
      ),
    );
    // 域名优选
    Utils.appUrl = await getBestDomain(['http://dsm.apaipai.top/index/check', 'http://dsm.flutter.fit/index/check']);
    // 是否关闭广告
    // 判断是否登录
    bool isForever = false;
    DateTime? noAdTime;
    Utils.isWechatInstalled = await fluwx.isWeChatInstalled;
    String userToken = SpUtil.getString("user_token", defValue: '')!;
    String noAdTimeStr = SpUtil.getString("no_ad_time", defValue: '')!;
    if (noAdTimeStr.isNotBlank) {
      noAdTime = DateTime.parse(noAdTimeStr);
    }
    if (userToken.isNotBlank) {
      var res = await Utils.post("${Utils.appUrl}/vip/info", data: {"token": userToken});
      if (res['code'] == 1) {
        isForever = Utils.vipForever = res['data']['is_forever'] == 1;
        if (res['data']['vip_expire_time'] != null) {
          DateTime vipExpireTime = DateTime.parse(res['data']['vip_expire_time']);
          Utils.vipExpireTime = vipExpireTime;
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
      SpUtil.remove("no_ad_time");
      // pangle.loadSplashAd(
      //   iOS: IOSSplashConfig(slotId: '887561543'),
      //   android: AndroidSplashConfig(slotId: '887561531', isExpress: false),
      // );
    }
  }
  // await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  Utils.downloadSavePath = SpUtil.getString("download_save_path", defValue: "/storage/emulated/0/dsm_helper/Download")!;
  Utils.downloadWifiOnly = SpUtil.getBool("download_wifi_only", defValue: true)!;
  //判断是否需要启动密码
  bool launchAuth = SpUtil.getBool("launch_auth", defValue: false)!;
  bool password = SpUtil.getBool("launch_auth_password", defValue: false)!;
  bool biometrics = SpUtil.getBool("launch_auth_biometrics", defValue: false)!;
  bool showShortcut = SpUtil.getBool("show_shortcut", defValue: true)!;
  bool showWallpaper = SpUtil.getBool("show_wallpaper", defValue: true)!;
  int refreshDuration = SpUtil.getInt("refresh_duration", defValue: 10)!;
  bool launchAccountPage = SpUtil.getBool("launch_account_page", defValue: false)!;
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Utils.appName = packageInfo.appName;

  bool authPage = launchAuth && (password || biometrics);

  //暗色模式
  int darkMode = SpUtil.getInt("dark_mode", defValue: 2)!;

  //震动开关
  Utils.vibrateOn = SpUtil.getBool("vibrate_on", defValue: true)!;
  Utils.vibrateNormal = SpUtil.getBool("vibrate_normal", defValue: true)!;
  Utils.vibrateWarning = SpUtil.getBool("vibrate_warning", defValue: true)!;

  Utils.checkSsl = SpUtil.getBool("check_ssl", defValue: true)!;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DarkModeProvider(darkMode)),
        ChangeNotifierProvider.value(value: SettingProvider(refreshDuration: refreshDuration, showShortcut: showShortcut)),
        ChangeNotifierProvider.value(value: AudioPlayerProvider()),
        ChangeNotifierProvider.value(value: SystemInfoProvider()),
        ChangeNotifierProvider.value(value: InitDataProvider()),
        ChangeNotifierProvider.value(value: UtilizationProvider()),
        ChangeNotifierProvider.value(value: StorageProvider()),
        ChangeNotifierProvider.value(value: ExternalDeviceProvider()),
      ],
      child: DsmHelper(authPage, launchAccountPage),
    ),
  );

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }
}

class DsmHelper extends StatefulWidget {
  final bool authPage;
  final bool launchAccountPage;
  DsmHelper(this.authPage, this.launchAccountPage);

  @override
  _DsmHelperState createState() => _DsmHelperState();
}

class _DsmHelperState extends State<DsmHelper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(
      builder: (context, darkModeProvider, _) {
        return KeyboardDismisser(
          child: WeuiToastConfig(
            data: WeuiToastConfigData(
              toastAlignment: Alignment.center,
              loadingText: "请稍后",
              loadingBackButtonClose: true,
            ),
            child: MaterialApp(
              title: '${Utils.appName}',
              debugShowCheckedModeBanner: false,
              // theme: darkModeProvider.darkMode == 2 ? lightTheme : (darkModeProvider.darkMode == 0 ? lightTheme : darkTheme),
              // darkTheme: darkModeProvider.darkMode == 2 ? darkTheme : null,
              localizationsDelegates: [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('zh', 'CN'),
              ],
              home: Splash(),
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.system,
              // home: widget.authPage
              //     ? AuthPage(
              //         launchAccountPage: widget.launchAccountPage,
              //       )
              //     : widget.launchAccountPage
              //         ? Accounts()
              //         : Login(),
              routes: {
                "/home": (BuildContext context) => Home(),
                "/control_panel": (BuildContext context) => ControlPanel(),
                "/package_center": (BuildContext context) => Packages(),
                "/resource_monitor": (BuildContext context) => ResourceMonitor(),
                "/storage_manager": (BuildContext context) => StorageManager(),
                "/security_scan": (BuildContext context) => SecurityScan(),
                "/docker": (BuildContext context) => Docker(title: "Docker"),
                "/container_manager": (BuildContext context) => Docker(title: "Container Manager"),
                "/download_station": (BuildContext context) => DownloadStation(),
                "/moments": (BuildContext context) => Moments(),
                "/synology_photos": (BuildContext context) => Photos(),
                "/virtual_machine": (BuildContext context) => VirtualMachine(),
              },
            ),
          ),
        );
      },
    );
  }
}
