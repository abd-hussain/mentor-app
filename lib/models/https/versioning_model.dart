class Versioning {
  List<VersioningData>? data;
  String? message;

  Versioning({this.data, this.message});

  Versioning.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VersioningData>[];
      json['data'].forEach((v) {
        data!.add(VersioningData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class VersioningData {
  int? id;
  double? number;
  String? content;
  bool? isForced;
  int? platform;

  VersioningData(
      {this.id, this.number, this.content, this.isForced, this.platform});

  VersioningData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    content = json['content'];
    isForced = json['is_forced'];
    platform = json['platform'];
  }
}
