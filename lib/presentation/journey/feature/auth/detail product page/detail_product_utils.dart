//
// import 'package:my_gstore/common/model/detail_product_model.dart';
// import 'package:my_gstore/common/ultils/format_utils.dart';
//
// class DetailProductUtils {
//   static String getRangerPriceOld(List<ProductVariant> productVariants) {
//     double _min = 99999999999;
//     double _max = 0;
//     for (ProductVariant obj in productVariants) {
//       if (_max < (obj.priceOld ?? 0)) {
//         _max = obj.priceOld ?? 0;
//       }
//       if (_min > (obj.priceOld ?? 0)) {
//         _min = obj.priceOld ?? 0;
//       }
//     }
//     if(_min ==_max){
//       return FormatUtils.formatCurrencyDoubleToString(_min);
//     }
//     return '${_min != 99999999999 ? '${FormatUtils.formatCurrencyDoubleToString(_min)}~' : ''}${_max != 0 ? FormatUtils.formatCurrencyDoubleToString(_max) : ''}';
//   }
//
//   static String getRangerPrice(List<ProductVariant> productVariants) {
//     double _min = 99999999999;
//     double _max = 0;
//     for (ProductVariant obj in productVariants) {
//       if (_max < (obj.price ?? 0)) {
//         _max = obj.price ?? 0;
//       }
//       if (_min > (obj.price ?? 0)) {
//         _min = obj.price ?? 0;
//       }
//     }
//     if(_min ==_max){
//       return FormatUtils.formatCurrencyDoubleToString(_min);
//     }
//     return '${_min != 99999999999 ? '${FormatUtils.formatCurrencyDoubleToString(_min)}~' : ''}${_max != 0 ? FormatUtils.formatCurrencyDoubleToString(_max) : ''}';
//   }
// }
