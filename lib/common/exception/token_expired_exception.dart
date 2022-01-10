import 'package:my_gstore/common/exception/app_exception.dart';

class TokenExpiredException extends AppException {
  TokenExpiredException({int? errorCode, String? errorText})
      : super(
          message: 'Phiên đăng nhập đã hết hạn',
        );
  //trả ra khi
}
