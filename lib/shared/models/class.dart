class Class {
  String? classId;
  Unit? unit;
  String? phone;
  String? name;

  Class({this.classId, this.unit, this.phone, this.name});

  Class.fromJson(Map<String, dynamic> json) {
    classId = json['classId'];
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
    phone = json['phone'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classId'] = this.classId;
    if (this.unit != null) {
      data['unit'] = this.unit!.toJson();
    }
    data['phone'] = this.phone;
    data['name'] = this.name;
    return data;
  }
}

class Unit {
  String? youtube;
  String? website;
  String? phone;
  String? facebook;
  String? name;
  String? unitId;
  String? keyword;
  String? email;

  Unit(
      {this.youtube,
      this.website,
      this.phone,
      this.facebook,
      this.name,
      this.unitId,
      this.keyword,
      this.email});

  Unit.fromJson(Map<String, dynamic> json) {
    youtube = json['youtube'];
    website = json['website'];
    phone = json['phone'];
    facebook = json['facebook'];
    name = json['name'];
    unitId = json['unitId'];
    keyword = json['keyword'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['youtube'] = this.youtube;
    data['website'] = this.website;
    data['phone'] = this.phone;
    data['facebook'] = this.facebook;
    data['name'] = this.name;
    data['unitId'] = this.unitId;
    data['keyword'] = this.keyword;
    data['email'] = this.email;
    return data;
  }
}
