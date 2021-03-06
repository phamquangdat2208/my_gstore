import 'dart:math';
import 'dart:typed_data';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:my_gstore/common/constants/app_constant.dart';
import 'package:my_gstore/common/constants/home_constant.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/constants/service_package_constant.dart';
import 'package:my_gstore/common/exception/app_exception.dart';
import 'package:my_gstore/common/exception/connect_exception.dart';
import 'package:my_gstore/common/exception/timeout_exception.dart';
import 'package:my_gstore/common/exception/token_expired_exception.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';
import 'package:my_gstore/presentation/injector_container.dart';
import 'package:my_gstore/presentation/journey/feature/webView/webview_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../presentation/routes.dart';
import '../enum.dart';
import 'log_util.dart';
import 'dart:ui' as ui;

class CommonUtils {
  static Future<Uint8List?> getBytesFromAsset(String path, int size) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: size - 20, targetHeight: size);
    ui.FrameInfo fi = await codec.getNextFrame();
    ByteData? result =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return result?.buffer.asUint8List();
  }

  static bool isEmptyOrNull(dynamic obj) {
    try {
      return (obj == null || obj.isEmpty);
    } catch (e) {
      return true;
    }
  }

  static bool isNull(dynamic input) {
    return ["", null, false, 0].contains(input);
  }

  static int countNumberRowOfGridview(List? data) {
    if (data?.isEmpty ?? true) {
      return 1;
    }
    if (data!.length % 2 == 0) {
      return data.length ~/ 2;
    }
    return (data.length + 1) ~/ 2;
  }
  static Future openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      injector<GlobalAppCache>().openingOtherApp = true;
      await launch(googleUrl);
      await Future.delayed(Duration(milliseconds: 200));
      injector<GlobalAppCache>().openingOtherApp = false;
    } else {
      injector<SnackBarBloc>().add(ShowSnackbarEvent());
      LOG.e('Exception: openMap: cannot open Map');
    }
  }
  static String textHelloInHome() {
    int hour = DateTime.now().hour;
    if (hour >= 4 && hour < 12) {
      return HomeConstant.goodMorning;
    }
    if (hour == 12) {
      return HomeConstant.goodLunch;
    }
    if (hour >= 13 && hour <= 18) {
      return HomeConstant.goodAfterNoon;
    }
    return HomeConstant.goodEvening;
  }

  static Future runUrl(String url, {bool runInApp = true}) async {
    if (runInApp == true) {
      Routes.instance.navigateTo(RouteName.webViewScreen,
          arguments: ArgumentWebViewScreen(url));
      return;
    }

    if (await canLaunch(url)) {
      injector<GlobalAppCache>().openingOtherApp = true;
      await launch(url);
      LOG.e('runUrlrunUrl: $url');
      await Future.delayed(const Duration(milliseconds: 1000));
      injector<GlobalAppCache>().openingOtherApp = false;
    } else {
      LOG.e('Exception: runUrl: $url');
      injector<SnackBarBloc>().add(ShowSnackbarEvent());
    }
  }

  static String getTwoCharOfName(String? name) {
    try {
      if (name == null || name.isEmpty) {
        return '';
      }
      List<String> listChar = name.trim().split(' ');
      if (listChar.length == 1) {
        if (listChar[0].length == 1) {
          return listChar[0].toUpperCase();
        } else {
          return listChar[0].substring(0, 2).toUpperCase();
        }
      }
      return '${listChar[0].substring(0, 1)}${listChar.last.substring(0, 1)}'
          .toUpperCase();
    } catch (_) {
      return name ?? '';
    }
  }

  static Widget mapLevelUserToWidget(int? sort, {bool? haveLogoGstore}) {
    if ((sort ?? 0) >= ServicePackageConstant.gShopTS ||
        haveLogoGstore == true) {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: CommonConstant.defaultShadow),
        padding: EdgeInsets.all(4),
        child: SvgPicture.asset(ImageConstant.logo),
      );
    }
    if (sort == ServicePackageConstant.reputationTS) {
      return SvgPicture.asset(IconConst.shopping_cart,
          width: 32.0, height: 32.0);
    }
    return SizedBox();
  }

  static bool _getOld(String endpoint) {
    try {
      List<String> result = endpoint.split('/');
      result.removeLast();
      DateTime oldTime = DateTime(
        int.parse(result[0]),
        int.parse(result[1]),
        int.parse(result[2]),
      );
      DateTime temp = DateTime(2020, 12, 1);
      return oldTime.isBefore(temp);
    } catch (e) {
      return true;
    }
  }

  static String? getUrlImage(
    String? endPoint, {
    TypeSizeImage? typeImage,
    bool havedType = false,
    bool typePng = false,
    bool? oldUrl,
  }) {
    if (endPoint == null || endPoint.isEmpty) {
      return null;
    }
    bool _oldUrl = _getOld(endPoint);
    if (oldUrl == true) {
      _oldUrl = true;
    }
    String type;
    switch (typeImage) {
      case TypeSizeImage.thumbs:
        type = '250x250';
        break;
      case TypeSizeImage.medium:
        type = '400x400';
        break;
      case TypeSizeImage.small:
        type = '150x150';
        break;
      default:
        type = '1000x1000';
        break;
    }
    return 'http://image.gstore.social/ResizeImg/ImageResize/$type/resize${typePng ? 'png' : ''}/normal/high/${_oldUrl ? Configurations.hostImageOld : Configurations.hostImage}$endPoint';
  }

  static dynamic convertDateTime(String? input,
      {bool outputDateTime = false, String? format}) {
    if (input?.isEmpty ?? true) {
      return null;
    }
    DateFormat dateFormat = DateFormat(format ?? "yyyy-MM-ddTHH:mm:ss");
    DateFormat dateFormatText = DateFormat("HH:mm - dd/MM/yyyy");
    DateTime dateTime = dateFormat.parse(input!);
    if (outputDateTime == true) {
      return dateTime;
    }
    return dateFormatText.format(dateTime);
  }

  static void handleException(SnackBarBloc? snackBarBloc, e,
      {required String methodName,
      String? exceptionName,
      bool showSnackbar = true,
      bool logBug = true,
      String? text}) async {
    LOG.e('GstoreException: ${e.toString()} | $methodName | $exceptionName');
    if (e is TokenExpiredException) {
      injector<SnackBarBloc>().add(ShowSnackbarEvent(
        content: e.message,
        type: SnackBarType.warning,
      ));
      Routes.instance.navigateAndRemove(RouteName.loginScreen);
      return;
    }
    if ((e is TimeOutException || e is ConnectException) &&
        snackBarBloc != null) {
      snackBarBloc.add(ShowSnackbarEvent(
        content: '???????ng truy???n c???a b???n kh??ng ???n ?????nh, vui l??ng th??? l???i',
        type: SnackBarType.warning,
      ));
      return;
    }
    if (logBug) {
      await injector<AppClient>().logBug(
        exception: e,
        functionName: methodName,
        text: text,
      );
    }

    final message = (e is AppException) ? e.message : 'L???i kh??ng x??c ?????nh';

    if (showSnackbar && snackBarBloc != null) {
      snackBarBloc.add(ShowSnackbarEvent(content: exceptionName ?? message));
    }
  }

  static void mapListenerSnackBarState(
      BuildContext context, SnackBarState state) {
    if (state is ShowSnackBarState) {
      var icon;
      var color;
      var title;
      switch (state.type) {
        case SnackBarType.success:
          icon = Icon(
            Icons.check_circle_outline,
            color: Colors.white,
          );
          color = Color(0xff33B44A);
          title = "Th??nh c??ng";
          break;
        case SnackBarType.warning:
          icon = Icon(
            Icons.error_outline,
            color: Colors.white,
          );
          color = Colors.orange;
          title = "C???nh b??o";
          break;
        case SnackBarType.error:
          icon = Icon(
            Icons.error_outline,
            color: Colors.white,
          );
          color = Color(0xffF63E43);
          title = "Th???t b???i";
          break;
        default:
          icon = Icon(
            Icons.error_outline,
            color: Colors.white,
          );
          color = Colors.grey;
          title = "Th??ng b??o";
          break;
      }
      showFlash(
        context: Routes.instance.navigatorKey.currentContext!,
        duration: state.duration ?? Duration(milliseconds: 3000),
        builder: (context, controller) {
          return Flash.bar(
            controller: controller,
            backgroundColor: color,
            position: FlashPosition.top,
            horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
            margin: const EdgeInsets.all(8),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            forwardAnimationCurve: Curves.easeOutBack,
            reverseAnimationCurve: Curves.easeInCubic,
            child: FlashBar(
              title: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white),
              ),
              content: Text(
                state.mess ?? '',
                style: TextStyle(color: Colors.white),
              ),
              icon: icon,
              shouldIconPulse: true,
              showProgressIndicator: false,
            ),
          );
        },
      );
    }
  }

  static void dismissKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void showCustomBottomSheet({
    required BuildContext context,
    required Widget child,
    double? height,
    Function? onClosed,
    EdgeInsets? margin,
    Color? backgroundColor,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext builder) {
        double _maxHeight = GScreenUtil.screenHeightDp -
            CommonConstant.defaultMarginTopOfBottomSheet -
            GScreenUtil.statusBarHeight;
        return Container(
          height: height != null ? min(height, _maxHeight) : _maxHeight,
          margin: margin ?? EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          child: child,
        );
      },
    ).whenComplete(() {
      if (onClosed != null) {
        onClosed();
      }
    });
  }
}
