import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/model/gshop_model.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/ultils/log_util.dart';
import 'package:my_gstore/presentation/journey/feature/auth/Post%20Product%20For%20Sale/post_product_sale.dart';
import 'package:my_gstore/presentation/journey/feature/auth/all%20product/all_product_page.dart';
import 'package:my_gstore/presentation/journey/feature/auth/g%20shop%20page/gshop_infomation_page.dart';
import 'package:my_gstore/presentation/journey/feature/auth/login/login_phone_number_screen.dart';
import 'package:my_gstore/presentation/journey/feature/auth/login/login_screen.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Notification/Detail%20Screen/notification_detail_screen.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Notification/model/notification_model.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Search%20product%20screen/map_page.dart';
import 'package:my_gstore/presentation/journey/feature/screens/on_boarding_screen.dart';
import 'package:my_gstore/presentation/journey/feature/screens/screen_container.dart';
import 'package:my_gstore/presentation/journey/feature/screens/splash_screen.dart';
import 'package:my_gstore/presentation/journey/feature/webView/webview_screen.dart';
import 'injector_container.dart';
import 'journey/feature/auth/detail product page/detail_product.dart';
import 'journey/feature/auth/individual/action/Update Profile/update_profile_screen.dart';
import 'journey/feature/screens/gshop map screen/gshop_map_screen.dart';

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
          builder: (context) => WebViewScreen(
            argument: settings.arguments != null
                ? settings.arguments as ArgumentWebViewScreen
                : null,
          ),
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
      case RouteName.allProductScreen:
        return CupertinoPageRoute(
            builder: (context) => AllProductScreen(
                  argument: settings.arguments != null
                      ? settings.arguments as ArgumentAllProductScreen
                      : null,
                ));
      case RouteName.searchProductScreen:
        return CupertinoPageRoute(builder: (context) => MapPageScreen());
      case RouteName.notificationDetail:
        return CupertinoPageRoute(
            builder: (context) => NotificationDetailScreen(
                  notificationModels: settings.arguments != null
                      ? settings.arguments as NotificationModels
                      : null,
                ));
      case RouteName.mapGShopScreen:
        return CupertinoPageRoute(builder: (context) => MapSearchGShopScreen());
      case RouteName.updateProfileScreen:
        return CupertinoPageRoute(builder: (context) => UpdateProfileScreen());
      case RouteName.postedForSale:
        return CupertinoPageRoute(builder: (context) => PostedForSalePage());
      case RouteName.detailProductScreen:
        return CupertinoPageRoute(
            builder: (context) => ProductDetailPage(
                  products: settings.arguments != null
                      ? settings.arguments as ProductModel
                      : null,
                ));
      case RouteName.gShopInformationScreen:
        return CupertinoPageRoute(
            builder: (context) => GShopInforScreen(
                  gshop: settings.arguments != null
                      ? settings.arguments as GShopModels
                      : null,
                ));
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
