import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/ultils/log_util.dart';
import 'package:my_gstore/presentation/journey/feature/auth/login/login_phone_number_screen.dart';
import 'package:my_gstore/presentation/journey/feature/auth/login/login_screen.dart';
import 'package:my_gstore/presentation/journey/feature/auth/otp/confirm_screen.dart';
import 'package:my_gstore/presentation/journey/feature/screens/on_boarding_screen.dart';
import 'package:my_gstore/presentation/journey/feature/screens/screen_container.dart';
import 'package:my_gstore/presentation/journey/feature/screens/splash_screen.dart';
import 'package:my_gstore/presentation/journey/feature/webView/webview_screen.dart';

import 'injector_container.dart';

class Routes {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory Routes() => _instance;

  Routes._internal();

  static final Routes _instance = Routes._internal();

  static Routes get instance => _instance;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndNavigateTo(
      {dynamic result, String? routeName, dynamic arguments}) {
    return navigatorKey.currentState!
        .popAndPushNamed(routeName ?? '', arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  dynamic popUntil() {
    return navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  Future<dynamic> navigateAndReplace(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  dynamic pop({dynamic result}) {
    injector<LoadingBloc>().add(FinishLoading());
    return navigatorKey.currentState!.pop(result);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    LOG.d('LOG ROUTE_NAVIGATOR: ${settings.name}');
    switch (settings.name) {
      case RouteName.webViewScreen:
        return CupertinoPageRoute(
          builder: (context) =>
              WebViewScreen(url: settings.arguments as String),
        );
      case RouteName.loginScreen:
        return CupertinoPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RouteName.splashScreen:
        return CupertinoPageRoute(builder: (context) => SplashScreen());
      case RouteName.containerScreen:
        return CupertinoPageRoute(builder: (context) => ContainerScreen());
      case RouteName.onBoardingScreen:
        return CupertinoPageRoute(builder: (context) => OnBoardingScreen());
      case RouteName.loginWithPhoneNumber:
        return CupertinoPageRoute(
            builder: (context) => LoginWithPhoneNumberScreen());
      // case RouteName.confirmScreen:
      //   return CupertinoPageRoute(
      //       builder: (context) => ConfirmScreen(
      //             phoneNumber: '',
      //           ));

      default:
        return _emptyRoute(settings);
    }
  }

  static MaterialPageRoute _emptyRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Center(
              child: Text(
                'Back',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        body: Center(
          child: Text('No path for ${settings.name}'),
        ),
      ),
    );
  }
}
