import 'package:my_gstore/common/enum.dart';
import 'package:my_gstore/common/ultils/common_util.dart';

class CategoryModel {
  String? name;
  String? slug;
  int? parentId;
  int? sort;
  String? languageId;
  String? urlPicture;
  String? urlIcon;
  bool? isPrestige;
  int? iD;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    slug = json['Slug'];
    parentId = json['ParentId'];
    sort = json['Sort'];
    languageId = json['LanguageId'];
    urlPicture = CommonUtils.getUrlImage(json['UrlPicture'],
      typeImage: TypeSizeImage.thumbs,
      typePng: true,
      oldUrl: true,);
    if(json['UrlIcon']!= null){
      urlIcon = CommonUtils.getUrlImage(
        json['UrlIcon'],
        typePng: true,
        typeImage: TypeSizeImage.thumbs,
        oldUrl: true,
      );
    }
    isPrestige = json['IsPrestige'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Slug'] = this.slug;
    data['ParentId'] = this.parentId;
    data['Sort'] = this.sort;
    data['LanguageId'] = this.languageId;
    data['UrlPicture'] = this.urlPicture;
    data['UrlIcon'] = this.urlIcon;
    data['IsPrestige'] = this.isPrestige;
    data['ID'] = this.iD;
    return data;
  }
}
