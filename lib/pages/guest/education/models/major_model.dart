import 'industry_model.dart';

class Major {
  String? majorId;
  List<String>? images;
  String? trainingTime;
  String? name;
  Industry? industry;
  String? totalCalculationOnly;
  bool? aun_qa;
  String? title;

  Major(
      {this.majorId,
      this.images,
      this.trainingTime,
      this.name,
      this.industry,
      this.aun_qa,
      this.totalCalculationOnly,
      this.title});

  Major.fromJson(Map<String, dynamic> json) {
    majorId = json['majorId'];
    images = json['images'].cast<String>();
    trainingTime = json['trainingTime'];
    name = json['name'];
    industry = json['industry'] != null
        ? new Industry.fromJson(json['industry'])
        : null;
    aun_qa = json['aun_qa'];
    totalCalculationOnly = json['totalCalculationOnly'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['majorId'] = this.majorId;
    data['images'] = this.images;
    data['trainingTime'] = this.trainingTime;
    data['name'] = this.name;
    if (this.industry != null) {
      data['industry'] = this.industry!.toJson();
    }
    data['aun_qa'] = this.aun_qa;
    data['totalCalculationOnly'] = this.totalCalculationOnly;
    data['title'] = this.title;
    return data;
  }
}
