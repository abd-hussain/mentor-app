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
    dBMentorPayments =
        json['DB_Mentor_Payments'] != null ? DBMentorPayments.fromJson(json['DB_Mentor_Payments']) : null;
    reportMessage = json['report_message'];
  }
}

class DBMentorPayments with ModelChecker {
  double? amount;
  int? id;
  String? descriptions;
  int? type;
  int? mentorId;
  int? status;
  int? durations;
  String? notes;
  String? createdAt;

  DBMentorPayments(
      {this.amount,
      this.id,
      this.descriptions,
      this.type,
      this.mentorId,
      this.status,
      this.durations,
      this.notes,
      this.createdAt});

  DBMentorPayments.fromJson(Map<String, dynamic> json) {
    amount = convertToDouble(json['amount']);
    id = json['id'];
    descriptions = json['descriptions'];
    type = json['type'];
    mentorId = json['mentor_id'];
    status = json['status'];
    durations = json['durations'];
    notes = json['notes'];
    createdAt = json['created_at'];
  }
}
