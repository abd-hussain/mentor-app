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

class PaymentResponseData {
  DBMentorPayments? dBMentorPayments;
  String? reportMessage;

  PaymentResponseData({this.dBMentorPayments, this.reportMessage});

  PaymentResponseData.fromJson(Map<String, dynamic> json) {
    dBMentorPayments = json['DB_Mentor_Payments'] != null
        ? DBMentorPayments.fromJson(json['DB_Mentor_Payments'])
        : null;
    reportMessage = json['report_message'];
  }
}

class DBMentorPayments with ModelChecker {
  int? mentorId;
  int? status;
  int? durations;
  String? currencyEnglish;
  String? notes;
  String? createdAt;
  int? id;
  double? amount;
  String? currencyArabic;
  String? descriptions;
  int? type;

  DBMentorPayments(
      {this.mentorId,
      this.status,
      this.durations,
      this.currencyEnglish,
      this.notes,
      this.createdAt,
      this.id,
      this.amount,
      this.currencyArabic,
      this.descriptions,
      this.type});

  DBMentorPayments.fromJson(Map<String, dynamic> json) {
    mentorId = json['mentor_id'];
    status = json['status'];
    durations = json['durations'];
    currencyEnglish = json['currency_english'];
    notes = json['notes'];
    createdAt = json['created_at'];
    id = json['id'];
    amount = json['amount'];
    currencyArabic = json['currency_arabic'];
    descriptions = json['descriptions'];
    type = json['type'];
  }
}
