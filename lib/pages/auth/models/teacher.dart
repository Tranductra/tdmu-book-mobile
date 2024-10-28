import 'package:tdmubook/pages/auth/models/student.dart';

class Teacher {
  String? name;
  String? email;
  String? phone;
  String? codePhone;
  List<Classes>? classes;
  String? photoUrl;
  String? teacherId;

  Teacher(
      {this.name,
      this.email,
      this.phone,
      this.codePhone,
      this.classes,
      this.photoUrl,
      this.teacherId});

  Teacher.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    codePhone = json['codePhone'];
    if (json['classes'] != null) {
      classes = <Classes>[];
      json['classes'].forEach((v) {
        classes!.add(new Classes.fromJson(v));
      });
    }
    photoUrl = json['photoUrl'];
    teacherId = json['teacherId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['codePhone'] = this.codePhone;
    if (this.classes != null) {
      data['classes'] = this.classes!.map((v) => v.toJson()).toList();
    }
    data['photoUrl'] = this.photoUrl;
    data['teacherId'] = this.teacherId;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'name: $name, email: $email, phone: $phone, codePhone: $codePhone, classes: $classes, photoUrl: $photoUrl, teacherId: $teacherId';
  }
}

// class Classes {
//   String? classId;
//   Unit? unit;
//   String? phone;
//   String? name;
//
//   Classes({this.classId, this.unit, this.phone, this.name});
//
//   Classes.fromJson(Map<String, dynamic> json) {
//     classId = json['classId'];
//     unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
//     phone = json['phone'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['classId'] = this.classId;
//     if (this.unit != null) {
//       data['unit'] = this.unit!.toJson();
//     }
//     data['phone'] = this.phone;
//     data['name'] = this.name;
//     return data;
//   }
// }
//
// class Unit {
//   String? youtube;
//   String? website;
//   String? phone;
//   String? facebook;
//   String? name;
//   String? unitId;
//   String? keyword;
//   String? email;
//
//   Unit(
//       {this.youtube,
//       this.website,
//       this.phone,
//       this.facebook,
//       this.name,
//       this.unitId,
//       this.keyword,
//       this.email});
//
//   Unit.fromJson(Map<String, dynamic> json) {
//     youtube = json['youtube'];
//     website = json['website'];
//     phone = json['phone'];
//     facebook = json['facebook'];
//     name = json['name'];
//     unitId = json['unitId'];
//     keyword = json['keyword'];
//     email = json['email'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['youtube'] = this.youtube;
//     data['website'] = this.website;
//     data['phone'] = this.phone;
//     data['facebook'] = this.facebook;
//     data['name'] = this.name;
//     data['unitId'] = this.unitId;
//     data['keyword'] = this.keyword;
//     data['email'] = this.email;
//     return data;
//   }
// }
