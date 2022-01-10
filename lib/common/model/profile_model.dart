import 'package:intl/intl.dart';
import 'package:my_gstore/common/constants/personal_constant.dart';
import 'package:my_gstore/common/constants/service_package_constant.dart';
import 'package:my_gstore/common/ultils/common_util.dart';

class ProfileModel {
  String? email;
  String? mobile; //(*)
  String? fullName; //(*)
  String? shopName;
  double? wallets;
  String? avartaUrl;
  String? imageTimeline;
  String? address; // (*)
  int? totalWallets;
  String? deviceToken;
  bool? isCompany = false;
  int? numberTS;

  // Android 1, IOS 2
  int? deviceType;
  String? iosToken;
  String? deviceInfo;
  int? iD;
  String? lastName;
  String? description;
  String? birthDay;
  String? birthDayText;

  /// Mã số thuế cá nhân
  String? userMST;
  String? cardCodeDateText;

  // check user đã cập nhật thông tin chưa, chỉ request 1 lần khi tạo tài khoản mới
  bool? isUpdate;

  /// API key service Google
  String? apiKeyGg;

  /// enable baokim
  bool? isBaoKim;

  /*------------------CÁ NHÂN---------------*/

  /// Số CMT (*)
  String? cardCode;

  /// Ngày cấp CMT (*)
  String? cardCodeDate;

  /// Nơi Cấp CMT (*)
  String? cardCodeLocation;

  /*--------------CÔNG TY-----------------*/

  /// tên doanh nghiệp (*)
  String? companyName;

  /// Mã số thuế công ty (*)
  String? companyMST;

  /// Địa chỉ công ty (*)
  String? companyAddress;

  /// Ngày Cấp Đăng Ký Kinh Doanh (*)
  String? companyIdentifyDate;

  /// Nơi cấp đăng ký kinh doanh (*)
  String? companyIdentifyLocaltion;

  /// mã số doanh nghiệp (Mã số đăng ký kinh doanh)
  String? companyCode;
  String? companyWeb;
  String? companyPhone;
  int limitQuantityProduct = 1; // giới hạn đăng bán sản phẩm

  ProfileModel();

  ProfileModel.fromJson(Map<String, dynamic> json) {
    fullName = json['Fullname'];
    shopName = json['ShopName'];
    address = json['Address'];
    email = json['Email'];
    numberTS = json['NumberTS'];
    isUpdate = json['IsUpdate'];
    mobile = json['Mobile'];
    deviceToken = json['tokenDevice'];
    iosToken = json['IosToken'];
    avartaUrl =
        (json['AvartaUrl'] != null && json['AvartaUrl'].contains('http'))
            ? json['AvartaUrl']
            : CommonUtils.getUrlImage(json['AvartaUrl']);
    imageTimeline = CommonUtils.getUrlImage(json['ImageTimeline']);
    iD = json['ID'];

    List<String> objs = fullName?.split(' ') ?? [];
    if (!CommonUtils.isEmptyOrNull(objs)) {
      lastName = objs.last;
    }

    // trên backend đang bị ngược key, API đang trả về IsPersonal = true là công ty
    isCompany = json['IsPersonal'] ?? false;
    userMST = json['TaxCode'];
    cardCode = json['CardCode'];
    cardCodeDate = json['CardCodeDate'];
    cardCodeLocation = json['CardCodeLocation'];
    companyName = json['CompanyName'];
    companyCode = json['CompanyCode'];
    companyIdentifyDate = json['CompanyDate'];
    companyIdentifyLocaltion = json['CompanyLocation'];
    companyAddress = json['CompanyAddress'];
    companyWeb = json['CompanyWeb'];
    companyMST = json['CompanyTaxCode'];
    companyPhone = json['CompanyPhone'];
    deviceType = json['DeviceType'];
    deviceInfo = json['DeviceInfo'];
    description = json['Description'];
    birthDay = json['Birthday'];
    apiKeyGg = json['ApiKeyGG'];
    isBaoKim = json['IsBaoKim'];

    DateFormat format = DateFormat('yyyy-MM-ddThh:mm:ss');
    DateFormat formatText = DateFormat('dd/MM/yyyy');
    if (birthDay?.isNotEmpty ?? false) {
      DateTime time = format.parse(birthDay!);
      birthDayText = formatText.format(time);
    }
    if (cardCodeDate != null) {
      DateTime time = format.parse(cardCodeDate!);
      cardCodeDateText = formatText.format(time);
    }
    limitQuantityProduct = _getLimitNumber();
  }

  int _getLimitNumber() {
    if (isCompany == true) {
      return PersonalConst.limitNumberProductCompany;
    }
    if (numberTS == ServicePackageConstant.gShopTS) {
      return PersonalConst.limitNumberProductGShop;
    }
    if (numberTS == ServicePackageConstant.reputationTS) {
      return PersonalConst.limitNumberProductReputation;
    }
    return PersonalConst.limitNumberProductDefault;
  }
}
