import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  final String url;
  final String title;
  Browser({this.url, this.title});
  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  final WebViewController _webviewController = WebViewController();
  @override
  void initState() {
    _webviewController
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            //TODO 检查是否需要授权
            debugPrint("onPageStarted");
          },
          onPageFinished: (_) {
            debugPrint("onPageFinished");
            setState(() {});
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: FutureBuilder<String>(
          future: _webviewController.platform.getTitle(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot?.data ?? widget.title ?? "加载中……");
            } else {
              return SizedBox();
            }
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10, top: 8, bottom: 8),
            child: NeuButton(
              decoration: NeumorphicDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              bevel: 5,
              onPressed: () {
                launchUrlString(widget.url, mode: LaunchMode.externalApplication);
              },
              child: Image.asset(
                "assets/icons/browser.png",
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(
              controller: _webviewController,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: <Widget>[
                  FutureBuilder<bool>(
                    future: _webviewController.canGoBack(),
                    builder: (context, shot) {
                      bool canGoBack = shot.data ?? false;
                      return NeuButton(
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        enabled: canGoBack,
                        onPressed: () async {
                          await _webviewController.goBack();
                          setState(() {});
                        },
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: canGoBack ? Colors.black : Colors.grey,
                          size: 22,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FutureBuilder<bool>(
                    future: _webviewController.canGoForward(),
                    builder: (context, shot) {
                      bool canGoForward = shot.data ?? false;
                      return NeuButton(
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabled: canGoForward,
                        padding: EdgeInsets.all(10),
                        onPressed: () async {
                          await _webviewController.goForward();
                          setState(() {});
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: canGoForward ? Colors.black : Colors.grey,
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  NeuButton(
                    decoration: NeumorphicDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      size: 22,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  NeuButton(
                    decoration: NeumorphicDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      _webviewController.reload();
                    },
                    child: Icon(
                      Icons.replay,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
