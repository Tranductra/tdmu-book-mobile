class GuestNotification {
  String? guestNotificationsId;
  String? nameType;
  String? name;
  String? type;
  String? file;
  DataPublished? dataPublished;

  GuestNotification(
      {this.guestNotificationsId,
        this.nameType,
        this.name,
        this.type,
        this.file,
        this.dataPublished});

  GuestNotification.fromJson(Map<String, dynamic> json) {
    guestNotificationsId = json['guestNotificationsId'];
    nameType = json['nameType'];
    name = json['name'];
    type = json['type'];
    file = json['file'];
    dataPublished = json['dataPublished'] != null
        ? new DataPublished.fromJson(json['dataPublished'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guestNotificationsId'] = this.guestNotificationsId;
    data['nameType'] = this.nameType;
    data['name'] = this.name;
    data['type'] = this.type;
    data['file'] = this.file;
    if (this.dataPublished != null) {
      data['dataPublished'] = this.dataPublished!.toJson();
    }
    return data;
  }
}

class DataPublished {
  int? iSeconds;
  int? iNanoseconds;

  DataPublished({this.iSeconds, this.iNanoseconds});

  DataPublished.fromJson(Map<String, dynamic> json) {
    iSeconds = json['_seconds'];
    iNanoseconds = json['_nanoseconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_seconds'] = this.iSeconds;
    data['_nanoseconds'] = this.iNanoseconds;
    return data;
  }
}