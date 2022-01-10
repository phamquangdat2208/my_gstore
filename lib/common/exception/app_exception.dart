import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:my_gstore/common/constants/string_const.dart';

class AppException implements Exception {
  /// message return from server
  String message;

  final int? errorCode;

  /// message dev want to log to server
  String? errorText;

  /// Snackbar Type
  SnackBarType? type;

  AppException(
      {this.message = StringConst.someThingWentWrong,
      this.errorCode,
      this.type,
      this.errorText});
}
