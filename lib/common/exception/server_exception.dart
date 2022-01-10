import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/exception/app_exception.dart';

class ServerException extends AppException {
  ServerException({
    String? message,
    int? errorCode,
    String? errorText,
  }) : super(
          message: message ?? StringConst.someThingWentWrong,
          errorCode: errorCode,
          errorText: errorText,
        );
}
