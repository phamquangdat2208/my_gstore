import 'dart:math';

import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/format_utils.dart';

import '../enum.dart';

class ProductModel {
  int? iD;
  String? name;
  String? urlPicture;
  String? folder;
  double? priceNew;
  int? ratings;
  double? avgRating;
  String? kmText;
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
  int? percentDiscount;
  String? rangerPrice;
  String? rangerPriceOld;

  ProductModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    urlPicture = CommonUtils.getUrlImage(
      json['UrlPicture'],
      typeImage: TypeSizeImage.origin,
    );
    folder = json['Folder'];
    priceNew = json['PriceNew'];
    ratings = json['Ratings'];
    avgRating = json['AvgRating'];
    numberTS = json['NumberTS'];
    customerID = json['CustomerID'];
    customerID1 = json['CustomerID1'];
    hasTransfer = json['HasTransfer'];
    isPersonal = json['IsPersonal'];
    double minPrice = json['MinPrice'] ?? 0;
    double maxPrice = json['MaxPrice'] ?? 0;
    double minPriceOld = json['MinPriceOld'] ?? 0;
    double maxPriceOld = json['MaxPriceOld'] ?? 0;
    isHaveVideo = json['IsHaveVideo'];
    priceOld = json['PriceOld'];
    priceNew = json['PriceNew'] ?? 0.0;
    priceOld = json['PriceOld'] ?? 0.0;
    if (priceNew == 0.0) {
      priceNew = priceNew;
      priceOld = 0;
    }
    if (priceOld! <= priceNew!) {
      priceOld = 0.0;
    }
    if (minPrice != 0 && maxPrice != 0 && minPrice != maxPrice) {
      rangerPrice =
          '${FormatUtils.formatCurrencyDoubleToString(minPrice, haveUnit: false)}'
          '~${FormatUtils.formatCurrencyDoubleToString(maxPrice, haveUnit: false)}';
    }
    if (minPriceOld != 0 && maxPriceOld != 0 && maxPriceOld != minPriceOld) {
      rangerPriceOld =
          '${FormatUtils.formatCurrencyDoubleToString(minPriceOld, haveUnit: false)}'
          '~${FormatUtils.formatCurrencyDoubleToString(maxPriceOld, haveUnit: false)}';
    }
    if ((minPrice != 0 && maxPrice == 0) || (minPrice == 0 && maxPrice != 0)) {
      priceNew = max(minPrice, maxPrice);
    }
    if ((minPriceOld != 0 && maxPriceOld == 0) ||
        (minPriceOld == 0 && maxPriceOld != 0)) {
      priceOld = max(minPriceOld, maxPriceOld);
    }
    percentDiscount = 0;
    if (maxPrice != 0 && maxPriceOld != 0) {
      percentDiscount = (maxPriceOld - maxPrice) * 100 ~/ maxPriceOld;
    } else if (priceOld != 0) {
      percentDiscount =
          ((priceOld ?? 0) - (priceNew ?? 0)) * 100 ~/ (priceOld ?? 1);
    }
    double km = json['Km'] ?? 0;
    double? km1 = json['Km1'];
    kmText = FormatUtils.formatSpaceToDisplay(km1 ?? km);
    if (kmText!.length > 5) {
      kmText = kmText!.substring(0, 5);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['UrlPicture'] = this.urlPicture;
    data['Folder'] = this.folder;
    data['PriceNew'] = this.priceNew;
    data['Ratings'] = this.ratings;
    data['AvgRating'] = this.avgRating;
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
