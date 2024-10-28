class Student {
  String? studentId;
  String? phone;
  String? name;
  String? codePhone;
  Classes? classes;
  String? email;
  String? photoUrl;

  Student(
      {this.studentId,
      this.phone,
      this.name,
      this.codePhone,
      this.classes,
      this.email,
      this.photoUrl});

  Student.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    phone = json['phone'];
    name = json['name'];
    codePhone = json['codePhone'];
    classes =
        json['class'] != null ? new Classes.fromJson(json['class']) : null;
    email = json['email'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['codePhone'] = this.codePhone;
    if (this.classes != null) {
      data['classes'] = this.classes!.toJson();
    }
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Student: {studentId: $studentId, phone: $phone, name: $name, codePhone: $codePhone, classes: $classes, email: $email, photoUrl: $photoUrl}';
  }
}

class Classes {
  Unit? unit;
  String? classId;
  String? phone;
  String? name;

  Classes({this.unit, this.classId, this.phone, this.name});

  Classes.fromJson(Map<String, dynamic> json) {
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
    classId = json['classId'];
    phone = json['phone'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.unit != null) {
      data['unit'] = this.unit!.toJson();
    }
    data['classId'] = this.classId;
    data['phone'] = this.phone;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Classes: {unit: $unit, classId: $classId, phone: $phone, name: $name}';
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

  @override
  String toString() {
    // TODO: implement toString
    return 'Unit: {youtube: $youtube, website: $website, phone: $phone, facebook: $facebook, name: $name, unitId: $unitId, keyword: $keyword, email: $email}';
  }
}
