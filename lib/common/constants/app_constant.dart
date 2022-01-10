import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

class CommonConstant {
  static const String fontRoboto = 'Roboto';
  static const String fontAverta = 'Averta';

  static const double defaultHeightBottomNavigationScreenContainer = 58.0;
  static const double defaultHeightButtonBottom = 48.0;
  static const double defaultMarginTopOfBottomSheet = 44;
  static const double defaultHeightKeyBoard = 175;
  static const double defaultAppbar = 56;
  static const double heightTimeLine = 136;

  static const double heightBanner = 207;
  static List<BoxShadow> defaultShadow = [
    BoxShadow(
        color: Colors.black.withOpacity(0.05), spreadRadius: 3, blurRadius: 5)
  ];
  static List<Color> colorsGradient = [
    AppColors.logoPink,
    AppColors.logoYellow,
    AppColors.logoGreen,
    AppColors.primaryColor,
  ];

  // type address
  static const int ADDRESS_TYPE_OWN_HOME = 1;
  static const int ADDRESS_TYPE_COMPANY = 2;

  // type status product
  static const List<Map<String, dynamic>> statusProduct = [
    {'code': 1, 'name': 'Mới 100%'},
    {'code': 2, 'name': 'Đồ cũ, còn bảo hành'},
    {'code': 3, 'name': 'Đồ cũ'},
  ];

  static const String TYPE_IMAGE_THUMBS = 'Thumbs/';
  static const String TYPE_IMAGE_MEDIUM = 'Mediums/';
  static const String TYPE_IMAGE_ORIGIN = 'Originals/';

  // TYPE_TRANSACTION
  static const int TRANSACTION_ALL = 0;
  static const int TRANSACTION_IN = 1;
  static const int TRANSACTION_OUT = 2;

  // ID Banner be config in server admin
  static const int ID_BANNER_HOME_1 = 1;
  static const int ID_BANNER_HOME_2 = 6;
  static const int ID_BANNER_CATEGORY = 7;
  static const int ID_BANNER_PUP_UP_FIRST_IN_APP = 8;
  static const int ID_BANNER_GMALL = 4;

  /// banner type click
  static const int BANNER_TYPE_PRODUCT = 1; // link tới sản phẩm
  static const int BANNER_TYPE_COMPANY = 2; // link tới công ty

  // static const int STATUS_ORDER_CANCEL = -1;
  // static const int STATUS_ORDER_ALL = 0;
  // static const int STATUS_ORDER_HANDLING = 1;
  // static const int STATUS_ORDER_SHIPPING = 2;
  // static const int STATUS_ORDER_DONE = 3;
  // static const int STATUS_ORDER_COMPLAIN = 4;

  static const int TYPE_TIME_WEEK = 3;
  static const int TYPE_TIME_MONTH = 2;
  static const int TYPE_TIME_YEAR = 1;
  static const int TYPE_TIME_ALL = 0;

  static const String KEY_SHARE_PRODUCT = 'zzzzzzzz';

  static const String KEY_SHARE_MARKETING = 'ssssssss';
  static const String KEY_SHARE_USER = 'uuuuuuuu';

  static const int TYPE_SOURCE_MKT = 111;
  static const int TYPE_SOURCE_TECH = 112;
  static const int TYPE_SOURCE_PTTT = 113;

  static String getKeyShareProduct(int productId, int customerId1) {
    return '$KEY_SHARE_PRODUCT$productId$KEY_SHARE_PRODUCT$customerId1$KEY_SHARE_PRODUCT';
  }

  static String getKeyShareUser(int customerId, int type) {
    return '$KEY_SHARE_USER$customerId$KEY_SHARE_USER$type$KEY_SHARE_USER';
  }

  static String getKeyShareMarketing(String source) {
    return '$KEY_SHARE_MARKETING$source$KEY_SHARE_MARKETING';
  }

  static const List<int> categoriesBan = [
    215, // đồ uống có cồn
  ];
}
