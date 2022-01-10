class OtpModel {
  Data? data;
  bool? erros;
  String? message;
  String? iD;
  int? type;
  int? code;

  OtpModel(
      {this.data, this.erros, this.message, this.iD, this.type, this.code});

  OtpModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    erros = json['Erros'];
    message = json['Message'];
    iD = json['ID'];
    type = json['Type'];
    code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    data['Erros'] = this.erros;
    data['Message'] = this.message;
    data['ID'] = this.iD;
    data['Type'] = this.type;
    data['Code'] = this.code;
    return data;
  }
}

class Data {
  String? token;
  String? refreshToken;
  int? iD;

  Data({this.token, this.refreshToken, this.iD});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    refreshToken = json['RefreshToken'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['RefreshToken'] = this.refreshToken;
    data['ID'] = this.iD;
    return data;
  }
}
