import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/customs/custom_scaffold.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../routes.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Row(
            children: [
              CustomGestureDetector(
                onTap: () {
                  Routes.instance.pop();
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.chevron_left,
                    color: AppColors.black,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Expanded(
            child: Builder(builder: (BuildContext context) {
              return WebView(
                initialUrl: '${widget.url}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                  // injector<LoadingBloc>().add(FinishLoading());
                },
                onProgress: (int progress) {
                  // injector<LoadingBloc>().add(StartLoading());
                },
                javascriptChannels: <JavascriptChannel>{},
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('https://gstorevietnam.vn/')) {
                    print('blocking navigation to $request}');
                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onWebResourceError: (WebResourceError error) {
                  // injector<LoadingBloc>().add(FinishLoading());
                },
                onPageStarted: (String url) {
                  // injector<LoadingBloc>().add(FinishLoading());
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  // injector<LoadingBloc>().add(FinishLoading());
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
              );
            }),
          ),
        ],
      ),
    );
  }
}
