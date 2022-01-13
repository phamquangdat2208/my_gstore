

import 'package:my_gstore/common/ultils/common_util.dart';

import '../enum.dart';

class ProductModel {
  int? iD;
  String? name;
  String? urlPicture;
  String? folder;
  double? priceNew;
  int? ratings;
  double? avgRating;
  double? km;
  int? numberTS;
  int? customerID;
  int? customerID1;
  bool? hasTransfer;
  bool? isPersonal;
  double? minPrice;
  double? maxPrice;
  double? minPriceOld;
  double? maxPriceOld;
  bool? isHaveVideo;
  double? priceOld;

  ProductModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    urlPicture = CommonUtils.getUrlImage(json['UrlPicture'],
    typeImage: TypeSizeImage.origin,);
    folder = json['Folder'];
    priceNew = json['PriceNew'];
    ratings = json['Ratings'];
    avgRating = json['AvgRating'];
    km = json['Km'];
    numberTS = json['NumberTS'];
    customerID = json['CustomerID'];
    customerID1 = json['CustomerID1'];
    hasTransfer = json['HasTransfer'];
    isPersonal = json['IsPersonal'];
    minPrice = json['MinPrice'];
    maxPrice = json['MaxPrice'];
    minPriceOld = json['MinPriceOld'];
    maxPriceOld = json['MaxPriceOld'];
    isHaveVideo = json['IsHaveVideo'];
    priceOld = json['PriceOld'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['UrlPicture'] = this.urlPicture;
    data['Folder'] = this.folder;
    data['PriceNew'] = this.priceNew;
    data['Ratings'] = this.ratings;
    data['AvgRating'] = this.avgRating;
    data['Km'] = this.km;
    data['NumberTS'] = this.numberTS;
    data['CustomerID'] = this.customerID;
    data['CustomerID1'] = this.customerID1;
    data['HasTransfer'] = this.hasTransfer;
    data['IsPersonal'] = this.isPersonal;
    data['MinPrice'] = this.minPrice;
    data['MaxPrice'] = this.maxPrice;
    data['MinPriceOld'] = this.minPriceOld;
    data['MaxPriceOld'] = this.maxPriceOld;
    data['IsHaveVideo'] = this.isHaveVideo;
    data['PriceOld'] = this.priceOld;
    return data;
  }
}
