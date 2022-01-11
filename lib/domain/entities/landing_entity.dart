class LandingEntity {
  String? name;
  String? code;
  String? note;
  String? policy;
  int? discount;
  int? payMain;
  int? payReward;
  String? dateCreated;
  String? avatarUrl;
  int? iD;
  bool? isActive;
  double? percentVC;
  double? percentVT;
  double? percentDiscount;
  DateTime? dateEnd;
  static LandingEntity? fromMap(Map<String, dynamic>? json) {
    if (json == null) return null;
    LandingEntity landingEntity = LandingEntity();
    landingEntity.name = json['Name'];
    landingEntity.code = json['Code'];
    landingEntity.note = json['Note'];
    landingEntity.policy = json['Policy'];
    landingEntity.discount = json['Discount'];
    landingEntity.payMain = json['PayMain'];
    landingEntity.payReward = json['PayReward'];
    landingEntity.dateCreated = json['DateCreated'];
    landingEntity.avatarUrl = json['AvatarUrl'];
    landingEntity.iD = json['ID'];
    landingEntity.percentVC = json['percentVC'];
    landingEntity.percentVT = json['percentVT'];
    landingEntity.percentDiscount = json['percentDiscount'];
    return landingEntity;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percentVC'] = this.percentVC;
    data['percentVT'] = this.percentVT;
    data['percentDiscount'] = this.percentDiscount;
    data['Name'] = this.name;
    data['Code'] = this.code;
    data['Note'] = this.note;
    data['Policy'] = this.policy;
    data['Discount'] = this.discount;
    data['PayMain'] = this.payMain;
    data['PayReward'] = this.payReward;
    data['DateCreated'] = this.dateCreated;
    data['AvatarUrl'] = this.avatarUrl;
    data['ID'] = this.iD;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return other is LandingEntity && this.iD == other.iD;
  }
}
