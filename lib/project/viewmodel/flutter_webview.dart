import 'dart:async';

import 'package:FlutterProject/project/login/page/login_page.dart';
import 'package:FlutterProject/project/models/article.dart';
import 'package:FlutterProject/project/viewmodel/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final Data article;

  WebViewExample(this.article);

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('详情'),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.article.link,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            if (!request.url.startsWith('http')) {
              //ThirdAppUtils.openAppByUrl(request.url);
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
            // return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('onPageStarted: $url');
          },
          onPageFinished: (String url) {
            print('onPageFinished: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
      bottomNavigationBar: BottomAppBar(
        child: NavigationControls(_controller.future),
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  bool collect = false;

  Widget favoriteButton() {
    return FloatingActionButton(
      onPressed: () async {
        var userModel = Provider.of<UserModel>(context, listen: false);

        if (userModel.user.data == null) {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  //title: Text('提示'),
                  content: Text('请先登录'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text('确认'),
                      onPressed: () {
                        Navigator.of(context).pop(false);

                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (ctx) {
                          return LoginPage();
                        }));
                      },
                    ),
                  ],
                );
              });
        } else {
          setState(() {
            widget.article.collect = widget.article.collect ? false : true;

            if (_checkCollect()) {



            } else {
              //+

            }
          });
        }
      },
      child: Icon(
        widget.article.collect ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
    );
  }

  bool _checkCollect() {
    var userModel = Provider.of<UserModel>(context, listen: false);

    if (userModel.user.data.collectIds.removeAt(widget.article.id)) {
      return true;
    }
    return false;
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        await controller.goBack();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text("无返回")),
                        );
                        return;
                      }
                    },
            ),
            SizedBox(
              width: 50,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        await controller.goForward();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text("无前进")),
                        );
                        return;
                      }
                    },
            ),
          ],
        );
      },
    );
  }
}
