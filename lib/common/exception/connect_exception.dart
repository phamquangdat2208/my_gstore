import 'package:my_gstore/common/constants/string_const.dart';

import 'package:my_gstore/common/exception/app_exception.dart';

class ConnectException extends AppException {
  ConnectException({String? message})
      : super(
          message: message ?? StringConst.connectError,
        );
}
