import 'package:mentor_app/models/model_checker.dart';

class HourRateResponse {
  HourRateResponseData? data;
  String? message;

  HourRateResponse({this.data, this.message});

  HourRateResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? HourRateResponseData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class HourRateResponseData with ModelChecker {
  double? hourRate;
  String? iban;

  HourRateResponseData({this.hourRate, this.iban});

  HourRateResponseData.fromJson(Map<String, dynamic> json) {
    hourRate = convertToDouble(json['hour_rate']);
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['hour_rate'] = hourRate;
    data['iban'] = iban;
    return data;
  }
}
