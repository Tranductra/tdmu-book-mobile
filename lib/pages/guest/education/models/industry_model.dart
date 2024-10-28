class Industry {
  String? industryId;
  String? photoUrl;
  String? name;

  Industry({this.industryId, this.photoUrl, this.name});

  Industry.fromJson(Map<String, dynamic> json) {
    industryId = json['industryId'];
    photoUrl = json['photoUrl'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['industryId'] = this.industryId;
    data['photoUrl'] = this.photoUrl;
    data['name'] = this.name;
    return data;
  }
}
