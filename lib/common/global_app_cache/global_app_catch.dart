import 'dart:math';
import 'package:my_gstore/common/model/app_position.dart';
import 'package:my_gstore/common/model/profile_model.dart';
import 'package:my_gstore/domain/entities/user_entity.dart';

class GlobalAppCache {
  AppPosition? gspPosition;
  // AddressModel? defaultAddress;
  //
  // SplashDataModel? splashDataModel;
  ProfileModel? profileModel;

  String? deviceToken;

  // ảnh gif ở màn giỏ hàng, mỗi file chỉ chạy đc một lần khi mở app
  // nên cần tạo ra nhiều file, mỗi lần chạy thì phải đổi file
  int helperRepeatAnimFly = 0;

  // check điều kiện load lại data mới ko, nếu ko sẽ lấy data ở local
  bool reloadData = true;

  bool openingOtherApp = false;

  // đã đăng nhập
  bool haveLoggedIn = false;

  // check xem có dữ liệu khuôn mặt hoặc vân tay ko
  bool canLocalAuth = false;

  // thời gian đã đăng nhập, sau 3p sẽ đc cập nhật sau khi user xác thực bằng
  // sinh trắc học
  int? timeLoggedIn;

  // show only first time pop up first in app
  bool? showPopUpFirstInApp;

  /// dùng trong trường hợp app chưa đc bật lên và nhận được cuộc gọi
  bool readyToCallFlutter = false;
  Map<String, dynamic>? dataCall;

  // Locale('vi'),Locale('en')
  String? currentLocale;

  // id của 12 gshop gần nhất, dùng để random khi kh mua sp của công ty đối tác
  List<UserEntity>? gshops;

  UserEntity? getRandomGShop() {
    if (gshops?.isEmpty ?? true) {
      return null;
    }
    int index = Random().nextInt(gshops?.length ?? 0);
    return gshops?[index];
  }

  // referer download app
  String? referrerDownloadApp;
}
