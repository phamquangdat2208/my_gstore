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
    urlPicture = json['UrlPicture'];
    urlIcon = json['UrlIcon'];
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
