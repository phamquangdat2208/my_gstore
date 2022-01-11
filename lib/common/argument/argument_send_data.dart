import 'package:my_gstore/domain/entities/landing_entity.dart';
import 'package:my_gstore/domain/entities/user_entity.dart';

class ArgumentDetailProductScreen {
  final int? productId;
  final bool? rateProduct;
  final LandingEntity? landingEntity;
  final int? customerId1;
  final bool? rateSuccess;
  final bool? forEducation;

  // TH user vào 1 GShop, bấm vào xem thêm của Line G-Mall, sau đó bấm vào chi tiết 1 sp bất kì thì
  // luồng trong màn chi tiết ko xác định đc customerItem1 là ô G-Shop đầu vào
  final UserEntity? userEntity;

  ArgumentDetailProductScreen(this.productId, {
    this.rateProduct = false,
    this.landingEntity,
    this.customerId1,
    this.rateSuccess,
    this.forEducation,
    this.userEntity,
  });
}