import 'package:dsm_helper/pages/file/file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> with AutomaticKeepAliveClientMixin {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  push() {
    // navigatorKey.currentState.push(route);
  }
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return CupertinoPageRoute(
            settings: settings,
            builder: (ctx) => Files(context),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
