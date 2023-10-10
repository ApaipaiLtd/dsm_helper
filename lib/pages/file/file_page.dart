import 'package:dsm_helper/pages/file/file.dart';
import 'package:flutter/cupertino.dart';

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => FilePageState();
}

class FilePageState extends State<FilePage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  push() {
    // navigatorKey.currentState.push(route);
  }
  pop() {}
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return CupertinoPageRoute(
            settings: settings,
            builder: (context) => Files(),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
