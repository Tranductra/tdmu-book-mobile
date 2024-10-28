class GeneralInfo {
  String? description;
  String? title;
  String? keyType;
  String? id;

  GeneralInfo({this.description, this.title, this.keyType, this.id});

  GeneralInfo.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    title = json['title'];
    keyType = json['keyType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['title'] = this.title;
    data['keyType'] = this.keyType;
    data['id'] = this.id;
    return data;
  }
}
