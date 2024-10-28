class MasterTraining {
  String? masterTrainingId;
  String? file;
  String? name;

  MasterTraining({this.masterTrainingId, this.file, this.name});

  MasterTraining.fromJson(Map<String, dynamic> json) {
    masterTrainingId = json['masterTrainingId'];
    file = json['file'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['masterTrainingId'] = this.masterTrainingId;
    data['file'] = this.file;
    data['name'] = this.name;
    return data;
  }
}
