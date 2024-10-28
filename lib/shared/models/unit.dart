class Unit {
  String? unitId;
  String? youtube;
  String? website;
  String? phone;
  String? facebook;
  String? name;
  String? keyword;
  String? email;

  Unit(
      {this.unitId,
      this.youtube,
      this.website,
      this.phone,
      this.facebook,
      this.name,
      this.keyword,
      this.email});

  Unit.fromJson(Map<String, dynamic> json) {
    unitId = json['unitId'];
    youtube = json['youtube'];
    website = json['website'];
    phone = json['phone'];
    facebook = json['facebook'];
    name = json['name'];
    keyword = json['keyword'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitId'] = this.unitId;
    data['youtube'] = this.youtube;
    data['website'] = this.website;
    data['phone'] = this.phone;
    data['facebook'] = this.facebook;
    data['name'] = this.name;
    data['keyword'] = this.keyword;
    data['email'] = this.email;
    return data;
  }

  @override
  String toString() {
    return 'Unit{unitId: $unitId, youtube: $youtube, website: $website, phone: $phone, facebook: $facebook, name: $name, keyword: $keyword, email: $email}';
  }
}
