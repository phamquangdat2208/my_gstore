
import 'package:my_gstore/common/ultils/common_util.dart';

import '../enum.dart';

class BannerModels {
  int? typeId;
  int? type;
  String? pictureUrl;
  String? link;
  String? dateStart;
  int? linkConverted;
  int? iD;

  BannerModels.fromJson(Map<String, dynamic> json) {
    typeId = json['TypeId'];
    type = json['Type'];
    pictureUrl = CommonUtils.getUrlImage(json['PictureUrl'],
      typeImage: TypeSizeImage.origin,
      oldUrl: true,);
    link = json['Link'];
    try {
      linkConverted = int.parse(link ?? '');
    }catch (e) {}
    dateStart = json['DateStart'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TypeId'] = this.typeId;
    data['Type'] = this.type;
    data['PictureUrl'] = this.pictureUrl;
    data['Link'] = this.link;
    data['DateStart'] = this.dateStart;
    data['ID'] = this.iD;
    return data;
  }
}
