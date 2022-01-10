import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_gstore/common/model/user_model.dart';

class UserEntity {
  String? fullname;
  String? shopName;
  String? mobile;
  String? address;
  String? imageTimeline;
  int? ratings;
  double? avgRating;
  int? likeTotal;
  double? longitude;
  double? latitude;
  CategoryItem? categoryItem;
  double? km;
  String? kmText;
  int iD = 0;
  String? avatar;
  String? categoryName;
  BitmapDescriptor? dataIconMarker;
  int? numberTS;
  int? totalComment;
  int? totalProduct;
  int? totalProductView;
  int? totalProductLike;
  int? totalOrder;
  List<String>? urlUserComment;
  bool? isCompany;
  int? type;
  String? dateTimeText;
}
