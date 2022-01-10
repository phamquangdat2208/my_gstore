class KeySaveLocalConstant {
  /// User cho phép quyền truy cập vị trí lần đầu rồi thì lần sau chỉ gần gọi hàm
  /// [getLastKnownPosition] của geolocator nữa là đc, tránh bật pup up lên gây phiền
  static const String keySavePermissionLocationStatus =
      'keySavePermissionLocationStatus';

  /// lưu lại thông tin vị trí gần nhất. dùng khi hàm [CommonUtil.getCurrentPositionApp] bị lỗi
  static const String saveDataLastLatPosition = 'keyDataLastLatPosition';
  static const String saveDataLastLngPosition = 'keyDataLastLngPosition';

  static const String saveTableSubOrderInCart = 'saveTableSubOrderInCart';
  static const String saveTableFavouriteInCart = 'saveTableFavouriteInCart';
  static const String saveTableBuyLaterInCart = 'saveTableBuyLaterInCart';
  static const String homeSaveDataNearMe = 'saveDataNearMe';
  static const String homeSaveUserReputation = 'homeSaveUserReputation';
  static const String homeSaveGetMultipleTime = 'homeSaveGetMultipleTime';
  static const String homeSaveBanner = 'homeSaveBanner1';
  static const String homeSaveRandomCategory = 'homeSaveRandomCategory1';
  static const String homeSaveProductOfG = 'homeSaveRandomCategory';
  static const String categoryAllSharePre = 'categoryAllSharePre';
  static const String keySaveAllCategory = 'keySaveAllCategory';
  static const String keySaveParentCategory = 'keySaveParentCategory1';

  static const String saveRefreshToken = 'saveRefreshToken';
  static const String saveAccessToken = 'saveAccessToken8';
  static const String saveDefaultAddress = 'saveDefaultAddress';
  static const String saveDefaultPaymentType = 'saveDefaultPaymentType';
  static const String havedLoginSuccessFull = 'havedLoginSuccessFull';
  static const String havedAcceptPermissionCamera =
      'havedAcceptPermissionCamera';
  static const String havedAcceptPermissionPhoto = 'havedAcceptPermissionPhoto';
  static const String saveLocationOfUser = 'saveLocationOfUser';
  static const String saveCheckTimeReLoad = 'saveCheckTimeReLoad';
  static const String saveImageHomeMap = 'saveImageHomeMap';
  static const String saveDataCityName = 'saveDataCityName';
  static const String saveProductNearMeBottomHome =
      'saveProductNearMeBottomHome';
  static const String saveDataNews = 'saveDataNews';
  static const String saveTimeLogin = 'saveTimeLogin';
  static const String showWelcomeScreen = 'showWelcomeScreen';

  // request usser update personal information when first use app
  static const String haveUpdatedInformationScreen =
      'haveUpdatedInformationScreen';

  static const String alreadyShowDescriptionProductSelling =
      'alreadyShowDescriptionProductSelling';

  static const String turnOnBiometricAuth = 'turnOnBiometricAuth';
  static const String agreePolicyDeposit = 'agreePolicyDeposit';
  static const String agreePolicyBuy = 'agreePolicyBuy';
  static const String alreadyShowTutorialShare = 'alreadyShowTutorialShare';
  static const String saveListContactGstore = 'saveListContactGstore1';
  static const String saveListKeySearch = 'saveListKeySearch';
  static const String keyHaveRequestNotificationPermissionWhenLockScreen =
      'haveRequestNotificationPermissionWhenLockScreen';
  static const String showRequestCallPermission = 'showRequestCallPermission1';
  static const String codeLanguage = 'codeLanguage';
  static const String autoChangeDefaultAddressForGShop =
      'autoChangeDefaultAddressForGShop1';

  // show cảnh báo phải hoàn thành đơn hàng sau 72h kể từ khi ấn ship hàng
  static const String keySaveWarning72hForShop = 'keySaveWarning72hForShop';

  // đồng ý với chính sách bán hàng
  static const String keySavePolicyAddProduct = 'keySavePolicyAddProduct';

  //đã cập nhật người giới thiệu khi tải app qua link của người khác gửi
  static const alreadyUpdateReferrer = 'alreadyUpdateReferrer';

  static const saveKeyReferrer = 'saveKeyReferrer';

  /// key save data marker in home
  static const keySaveMarkerHome = 'keySaveMarkerHome1';

  static const keyCacheDataHomeTop = 'keyCacheDataHomeTop';

  /// đồng ý với chính sách landing của người bán
  static const keySaveLandingPolicyForSeller = 'keySaveLandingPolicyForSeller';

  /// firebase device token
  static const keySaveDeviceToken = 'keySaveDeviceToken';

  /// check người dùng đã log cài đặt từ các nguồn MKT - TECH - PTTT
  static const keySaveLogIntallForAnalytics = 'keySaveLogIntallForAnalytics1';

  /// chính sách chung của G-Store
  static const String keySaveAgreePolicyGstore = 'keySaveAgreePolicyGstore';
}
