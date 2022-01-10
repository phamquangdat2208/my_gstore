import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/format_utils.dart';
import 'package:my_gstore/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel.fromJson(Map<String, dynamic> json, {bool? spaceMeter}) {
    fullname = json['Fullname'];
    shopName = json['ShopName'];
    fullname = (fullname?.isEmpty ?? true) ? 'User' : fullname;
    mobile = json['Mobile'];
    categoryName = json['CategoryName'];
    address = json['Address'];
    imageTimeline = CommonUtils.getUrlImage(json['ImageTimeline']);
    avatar = CommonUtils.getUrlImage(json['AvartaUrl']);
    ratings = json['Ratings'];
    avgRating = json['AvgRating'] ?? 0.0;
    likeTotal = json['LikeTotal'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    numberTS = json['NumberTS'];
    categoryItem = json['CategoryItem'] != null
        ? new CategoryItem.fromJson(json['CategoryItem'])
        : null;
    km = json['Km'];
    if (spaceMeter == true) {
      km = (json['Km'] ?? 0) / 1000;
    }
    kmText = FormatUtils.formatSpaceToDisplay(km);
    iD = json['ID'];
    totalComment = json['TotalComment'];
    totalProduct = json['TotalProduct'];
    totalProductView = json['TotalProductView'];
    totalProductLike = json['TotalProductLike'];
    totalOrder = json['TotalOrder'];
    if (json['LstUserCommented'] != null) {
      urlUserComment = <String>[];
      json['LstUserCommented'].forEach((v) {
        urlUserComment
            ?.add(CommonUtils.getUrlImage(v['AvartaUrl'] ?? '') ?? '');
      });
    }
  }
}

class CategoryItem {
  String? name;
  int? iD;

  CategoryItem({this.name, this.iD});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['ID'] = this.iD;
    return data;
  }
}
