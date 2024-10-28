class UserCurrent {
  String? name;
  String? email;
  String? phone;
  String? photoUrl;
  String? currentId;

  UserCurrent(
      {this.name, this.email, this.phone, this.photoUrl, this.currentId});

  UserCurrent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photoUrl = json['photoUrl'];
    currentId = json['currentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['photoUrl'] = this.photoUrl;
    data['currentId'] = this.currentId;
    return data;
  }
}
