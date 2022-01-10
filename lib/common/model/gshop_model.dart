class GShopModels {
  String? fullname;
  String? address;
  String? avartaUrl;
  int? ratings;
  double? avgRating;
  double? longitude;
  double? latitude;
  String? categoryName;
  double? km;
  int? type;
  int? iD;
  String? imageTimeline;
  String? shopName;

  GShopModels.fromJson(Map<String, dynamic> json) {
    fullname = json['Fullname'];
    address = json['Address'];
    avartaUrl = json['AvartaUrl'];
    ratings = json['Ratings'];
    avgRating = json['AvgRating'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    categoryName = json['CategoryName'];
    km = json['Km'];
    type = json['Type'];
    iD = json['ID'];
    imageTimeline = json['ImageTimeline'];
    shopName = json['ShopName'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['Fullname'] = this.fullname;
  //   data['Address'] = this.address;
  //   data['AvartaUrl'] = this.avartaUrl;
  //   data['Ratings'] = this.ratings;
  //   data['AvgRating'] = this.avgRating;
  //   data['Longitude'] = this.longitude;
  //   data['Latitude'] = this.latitude;
  //   data['CategoryName'] = this.categoryName;
  //   data['Km'] = this.km;
  //   data['Type'] = this.type;
  //   data['ID'] = this.iD;
  //   data['ImageTimeline'] = this.imageTimeline;
  //   data['ShopName'] = this.shopName;
  //   return data;
  // }
}
