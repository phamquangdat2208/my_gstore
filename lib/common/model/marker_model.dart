import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_gstore/common/enum.dart';
import 'package:my_gstore/common/ultils/common_util.dart';


class MarkerModel {
  int? sort;
  bool? isPrestige;
  int? ratings;
  double? avgRating;
  double? longitude;
  double? latitude;
  int? customerId;
  int? topRankShop;
  int? iD;
  String? customerName;
  double? km;
  String? kmText;
  String? address;
  BitmapDescriptor? dataIconMarker;
  Uint8List? uint8list;
  String? urlIcon;

  MarkerModel.fromJson(Map<String, dynamic> json) {
    sort = json['NumberTS'];
    isPrestige = json['IsPrestige'];
    urlIcon = CommonUtils.getUrlImage(
      json['UrlIcon'],
      typeImage: TypeSizeImage.small,
      typePng: true,
    );
    ratings = json['Ratings'];
    avgRating = json['AvgRating'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    customerId = json['CustomerId'];
    topRankShop = json['TopRankShop'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['NumberTS'] = sort;
    data['IsPrestige'] = isPrestige;
    data['Ratings'] = ratings;
    data['AvgRating'] = avgRating;
    data['Longitude'] = longitude;
    data['Latitude'] = latitude;
    data['CustomerId'] = customerId;
    data['TopRankShop'] = topRankShop;
    data['ID'] = iD;
    if (uint8list != null) {
      data['dataIconMarker'] = String.fromCharCodes(uint8list!);
    }
    return data;
  }

  MarkerModel.fromJsonLocal(Map<String, dynamic> jsonData) {
    sort = jsonData['NumberTS'];
    isPrestige = jsonData['IsPrestige'];
    ratings = jsonData['Ratings'];
    avgRating = jsonData['AvgRating'];
    longitude = jsonData['Longitude'];
    latitude = jsonData['Latitude'];
    customerId = jsonData['CustomerId'];
    topRankShop = jsonData['TopRankShop'];
    iD = jsonData['ID'];
    String? unit8ListText = jsonData['dataIconMarker'];
    if (unit8ListText != null) {
      uint8list = Uint8List.fromList(unit8ListText.codeUnits);
      if (uint8list != null) {
        dataIconMarker = BitmapDescriptor.fromBytes(uint8list!);
      }
    }
  }

  @override
  bool operator ==(Object other) {
    return other is MarkerModel && this.iD == other.iD;
  }
}
