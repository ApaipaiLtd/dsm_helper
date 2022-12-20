import 'dart:async';
import 'dart:io';

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
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: FutureBuilder<WebViewController>(
          future: _controller.future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                future: snapshot.data.getTitle(),
                builder: (context, shot) {
                  return Text(shot?.data ?? widget.title ?? "加载中……");
                },
              );
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
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (v) async {
                var future = await _controller.future;
                setState(() {});
              },
            ),
          ),
          FutureBuilder<WebViewController>(
            future: _controller.future,
            builder: (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
              final bool webViewReady = snapshot.connectionState == ConnectionState.done;
              final WebViewController controller = snapshot.data;
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: <Widget>[
                      FutureBuilder<bool>(
                        future: controller.canGoBack(),
                        builder: (context, shot) {
                          return NeuButton(
                            decoration: NeumorphicDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(10),
                            enabled: shot.data,
                            onPressed: webViewReady
                                ? () async {
                                    await controller.goBack();
                                    setState(() {});
                                  }
                                : null,
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: shot.data ? Colors.black : Colors.grey,
                              size: 22,
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FutureBuilder<bool>(
                        future: controller.canGoForward(),
                        builder: (context, shot) {
                          return NeuButton(
                            decoration: NeumorphicDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabled: shot.data,
                            padding: EdgeInsets.all(10),
                            onPressed: !webViewReady
                                ? null
                                : () async {
                                    await controller.goForward();
                                    setState(() {});
                                  },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 22,
                              color: shot.data ? Colors.black : Colors.grey,
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
                        onPressed: !webViewReady
                            ? null
                            : () {
                                controller.reload();
                              },
                        child: Icon(
                          Icons.replay,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
