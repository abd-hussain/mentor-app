import 'package:mentor_app/models/model_checker.dart';

class PaymentResponse {
  List<PaymentResponseData>? data;
  String? message;

  PaymentResponse({this.data, this.message});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(PaymentResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class PaymentResponseData with ModelChecker {
  int? id;
  int? mentorId;
  int? status;
  double? amount;
  int? durations;
  String? currencyArabic;
  String? currencyEnglish;
  String? notes;
  int? type;
  String? descriptions;
  String? createdAt;
  String? reportMessage;

  PaymentResponseData(
      {this.id,
      this.mentorId,
      this.status,
      this.amount,
      this.durations,
      this.currencyArabic,
      this.currencyEnglish,
      this.notes,
      this.type,
      this.descriptions,
      this.createdAt,
      this.reportMessage});

  PaymentResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mentorId = json['mentor_id'];
    status = json['status'];
    amount = convertToDouble(json['amount']);
    durations = json['durations'];
    currencyArabic = json['currency_arabic'];
    currencyEnglish = json['currency_english'];
    notes = json['notes'];
    type = json['type'];
    descriptions = json['descriptions'];
    createdAt = json['created_at'];
    reportMessage = json['report_message'];
  }
}
