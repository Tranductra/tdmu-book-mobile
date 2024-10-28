class Admin {
  String? adminId;
  String? phone;
  String? name;
  String? codePhone;
  String? email;
  String? photoUrl;

  Admin(
      {this.adminId,
      this.phone,
      this.name,
      this.codePhone,
      this.email,
      this.photoUrl});

  Admin.fromJson(Map<String, dynamic> json) {
    adminId = json['adminId'];
    phone = json['phone'];
    name = json['name'];
    codePhone = json['codePhone'];
    email = json['email'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminId'] = this.adminId;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['codePhone'] = this.codePhone;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}
