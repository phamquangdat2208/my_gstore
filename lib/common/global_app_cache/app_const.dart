import 'package:hive/hive.dart';

class AppConst {
  factory AppConst() => _instance;

  AppConst._();

  static final AppConst _instance = AppConst._();

  static AppConst get instance => _instance;

  Box? gstoreBox;

  /// sửa lỗi, khi đăng xuất (để fix lỗi request gửi otp cho sdt bị lỗi)
  bool logged = false;
}
