import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSite extends StatefulWidget {
  String urlSite;
  WebViewSite(this.urlSite);

  @override
  _WebViewSiteState createState() => _WebViewSiteState();
}

class _WebViewSiteState extends State<WebViewSite> {
  WebViewController conroller;
  var stackIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisa externa"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: clickRefresh,
          )
        ],
      ),
      body: webView(),
    );
  }

  webView() {
    return IndexedStack(
      index: stackIndex,
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                initialUrl: widget.urlSite,
                onWebViewCreated: (controller) {
                  this.conroller = controller;
                },
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (request) {
                  return NavigationDecision.navigate;
                },
                onPageFinished: onPageFinished,
              ),
            ),
          ],
        ),
       CircularProgressor(),
      ],
    );
  }

  clickRefresh() {
    this.conroller.reload();
  }

  onPageFinished(String url) {
    setState(() {
      stackIndex = 0;
    });
  }
}
