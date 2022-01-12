import 'package:my_gstore/common/ultils/common_util.dart';

import '../enum.dart';

class DetailProductModel {
  int? cateId;
  int? pictureId;
  int? quantity;
  String? name;
  String? description;
  int? quantityOut;
  bool? isShow;
  bool? isApproved;
  String? dateCreated;
  String? strDateCreated;
  String? urlPicture;
  double? priceOld;
  double? priceNew;
  bool? hasTransfer;
  String? type;
  int? ratings;
  double? avgRating;
  double? longitude;
  double? latitude;
  double? longitudeKg;
  double? latitudeKg;
  int? customerId;
  String? categoryName;
  int? topRankShop;
  CustomerItem? customerItem;
  bool? isAccept;
  int? numberTS;
  String? shopType;
  bool? isGstore;
  int? landingId;
  bool? isLike;
  List<Landing>? landing;
  List<CustomerItem>? customerItemShop;
  List<ProductVariants>? productVariants;
  List<LstPictures>? lstPictures;
  List<VideoModel>? videos;
  int? iD;

  DetailProductModel.fromJson(Map<String, dynamic> json) {
    cateId = json['CateId'];
    pictureId = json['PictureId'];
    quantity = json['Quantity'];
    name = json['Name'];
    description = json['Description'];
    quantityOut = json['QuantityOut'];
    isShow = json['IsShow'];
    isApproved = json['IsApproved'];
    dateCreated = json['DateCreated'];
    strDateCreated = json['StrDateCreated'];
    urlPicture = CommonUtils.getUrlImage(
      json['UrlPicture'],
      typeImage: TypeSizeImage.origin,
      oldUrl: true,
    );
    priceOld = json['PriceOld'];
    priceNew = json['PriceNew'];
    hasTransfer = json['HasTransfer'];
    type = json['Type'];
    ratings = json['Ratings'];
    avgRating = json['AvgRating'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    longitudeKg = json['LongitudeKg'];
    latitudeKg = json['LatitudeKg'];
    customerId = json['CustomerId'];
    categoryName = json['CategoryName'];
    topRankShop = json['TopRankShop'];
    customerItem = json['CustomerItem'] != null
        ? new CustomerItem.fromJson(json['CustomerItem'])
        : null;
    isAccept = json['IsAccept'];
    numberTS = json['NumberTS'];
    shopType = json['ShopType'];
    isGstore = json['IsGstore'];
    landingId = json['LandingId'];
    isLike = json['IsLike'];
    if (json['Landing'] != null) {
      landing = <Landing>[];
      json['Landing'].forEach((v) {
        landing!.add(Landing.fromJson(v));
      });
    }
    if (json['CustomerItemShop'] != null) {
      customerItemShop = <CustomerItem>[];
      json['CustomerItemShop'].forEach((v) {
        customerItemShop!.add(CustomerItem.fromJson(v));
      });
    }
    if (json['ProductVariants'] != null) {
      productVariants = <ProductVariants>[];
      json['ProductVariants'].forEach((v) {
        productVariants!.add(ProductVariants.fromJson(v));
      });
    }
    if (json['LstPictures'] != null) {
      lstPictures = <LstPictures>[];
      json['LstPictures'].forEach((v) {
        lstPictures!.add(new LstPictures.fromJson(v));
      });
    }
    if (json['Videos'] != null) {
      videos = <VideoModel>[];
      json['Videos'].forEach((v) {
        videos!.add(VideoModel.fromJson(v));
      });
    }
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CateId'] = this.cateId;
    data['PictureId'] = this.pictureId;
    data['Quantity'] = this.quantity;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['QuantityOut'] = this.quantityOut;
    data['IsShow'] = this.isShow;
    data['IsApproved'] = this.isApproved;
    data['DateCreated'] = this.dateCreated;
    data['StrDateCreated'] = this.strDateCreated;
    data['UrlPicture'] = this.urlPicture;
    data['PriceOld'] = this.priceOld;
    data['PriceNew'] = this.priceNew;
    data['HasTransfer'] = this.hasTransfer;
    data['Type'] = this.type;
    data['Ratings'] = this.ratings;
    data['AvgRating'] = this.avgRating;
    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['LongitudeKg'] = this.longitudeKg;
    data['LatitudeKg'] = this.latitudeKg;
    data['CustomerId'] = this.customerId;
    data['CategoryName'] = this.categoryName;
    data['TopRankShop'] = this.topRankShop;
    if (this.customerItem != null) {
      data['CustomerItem'] = this.customerItem!.toJson();
    }
    data['IsAccept'] = this.isAccept;
    data['NumberTS'] = this.numberTS;
    data['ShopType'] = this.shopType;
    data['IsGstore'] = this.isGstore;
    data['LandingId'] = this.landingId;
    data['IsLike'] = this.isLike;
    if (this.landing != null) {
      data['Landing'] = this.landing!.map((v) => v.toJson()).toList();
    }
    if (this.customerItemShop != null) {
      data['CustomerItemShop'] =
          this.customerItemShop!.map((v) => v.toJson()).toList();
    }
    if (this.productVariants != null) {
      data['ProductVariants'] =
          this.productVariants!.map((v) => v.toJson()).toList();
    }
    if (this.lstPictures != null) {
      data['LstPictures'] = this.lstPictures!.map((v) => v.toJson()).toList();
    }
    if (this.videos != null) {
      data['Videos'] = this.videos!.map((v) => v.toJsonId()).toList();
    }
    data['ID'] = this.iD;
    return data;
  }
}

class VideoModel {
  String? name;
  String? url;
  String? dateCreated;
  bool? isShow;
  bool? isDeleted;
  int? iD;

  VideoModel();

  VideoModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    if (json['Url'] != null) {
      url = json['Url'];
    }
    dateCreated = json['DateCreated'];
    isShow = json['IsShow'];
    isDeleted = json['IsDeleted'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJsonId() {
    return {"Id": iD};
  }
}

class ProductVariants {
  ProductVariants.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Landing {
  Landing.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class CustomerItem {
  int? addressID;
  String? address;
  double? latitude;
  double? longitude;
  String? fullname;
  String? mobile;
  String? avatarUrl;
  double? km;
  int? numberTS;
  bool? isPrestige;
  bool? isPersonal;
  int? iD;

  CustomerItem(
      {this.addressID,
      this.address,
      this.latitude,
      this.longitude,
      this.fullname,
      this.mobile,
      this.avatarUrl,
      this.km,
      this.numberTS,
      this.isPrestige,
      this.isPersonal,
      this.iD});

  CustomerItem.fromJson(Map<String, dynamic> json) {
    addressID = json['AddressID'];
    address = json['Address'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    fullname = json['Fullname'];
    mobile = json['Mobile'];
    avatarUrl = json['AvatarUrl'];
    km = json['Km'];
    numberTS = json['NumberTS'];
    isPrestige = json['IsPrestige'];
    isPersonal = json['IsPersonal'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AddressID'] = this.addressID;
    data['Address'] = this.address;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['Fullname'] = this.fullname;
    data['Mobile'] = this.mobile;
    data['AvatarUrl'] = this.avatarUrl;
    data['Km'] = this.km;
    data['NumberTS'] = this.numberTS;
    data['IsPrestige'] = this.isPrestige;
    data['IsPersonal'] = this.isPersonal;
    data['ID'] = this.iD;
    return data;
  }
}

class LstPictures {
  String? url;
  String? folder;
  int? type;
  int? iD;

  LstPictures({this.url, this.folder, this.type, this.iD});

  LstPictures.fromJson(Map<String, dynamic> json) {
    folder = json['Folder'];
    url = CommonUtils.getUrlImage(
          '$folder${json['Url']}',
          typeImage: TypeSizeImage.origin,
        ) ??
        '';
    iD = json['ID'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Url'] = this.url;
    data['Folder'] = this.folder;
    data['Type'] = this.type;
    data['ID'] = this.iD;
    return data;
  }
}
