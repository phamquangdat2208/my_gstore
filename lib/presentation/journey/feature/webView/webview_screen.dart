import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/customs/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../injector_container.dart';
import '../../../routes.dart';

class ArgumentWebViewScreen {
  final String url;
  final bool showLoading;

  ArgumentWebViewScreen(this.url, {this.showLoading = true});
}

class WebViewScreen extends StatefulWidget {
  final ArgumentWebViewScreen? argument;

  const WebViewScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    _timeOutLoading();
    super.initState();
  }

  void _timeOutLoading() {
    Timer(Duration(seconds: 5), () {
      injector<LoadingBloc>().add(FinishLoading());
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: CustomAppBar(
        title: StringConst.appName,
        iconLeftTap: () {
          Routes.instance.pop();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Builder(builder: (BuildContext context) {
              return WebView(
                initialUrl: '${widget.argument?.url}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onProgress: (int progress) {
                  if (widget.argument?.showLoading ?? true) {
                    injector<LoadingBloc>().add(StartLoading());
                    _timeOutLoading();
                  }
                  print("WebView is loading (progress : $progress%)");
                },
                onWebResourceError: (WebResourceError error) {
                  injector<LoadingBloc>().add(FinishLoading());
                  Routes.instance.pop(result: true);
                },
                javascriptChannels: <JavascriptChannel>{},
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    print('blocking navigation to $request}');
                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                  injector<LoadingBloc>().add(FinishLoading());
                },
                gestureNavigationEnabled: true,
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    injector<LoadingBloc>().add(FinishLoading());
    super.dispose();
  }
}
