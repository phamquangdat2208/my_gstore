import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:my_gstore/common/constants/home_constant.dart';
import 'package:my_gstore/common/exception/app_exception.dart';
import 'package:my_gstore/common/exception/connect_exception.dart';
import 'package:my_gstore/common/exception/timeout_exception.dart';
import 'package:my_gstore/common/exception/token_expired_exception.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/presentation/injector_container.dart';

import '../../presentation/routes.dart';
import '../enum.dart';
import 'log_util.dart';

class CommonUtils {
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
        content: 'Đường truyền của bạn không ổn định, vui lòng thử lại',
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

    final message = (e is AppException) ? e.message : 'Lỗi không xác định';

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
          title = "Thành công";
          break;
        case SnackBarType.warning:
          icon = Icon(
            Icons.error_outline,
            color: Colors.white,
          );
          color = Colors.orange;
          title = "Cảnh báo";
          break;
        case SnackBarType.error:
          icon = Icon(
            Icons.error_outline,
            color: Colors.white,
          );
          color = Color(0xffF63E43);
          title = "Thất bại";
          break;
        default:
          icon = Icon(
            Icons.error_outline,
            color: Colors.white,
          );
          color = Colors.grey;
          title = "Thông báo";
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
}
