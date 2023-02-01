import 'package:mentor_app/models/model_checker.dart';

class Appointment {
  List<AppointmentData>? data;
  String? message;

  Appointment({this.data, this.message});

  Appointment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AppointmentData>[];
      json['data'].forEach((v) {
        data!.add(AppointmentData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class AppointmentData with ModelChecker {
  String? dateFrom;
  int? id;
  int? mentorId;
  String? mentorPrefix;
  String? mentorFirstName;
  String? mentorLastName;
  String? categoryName;
  String? profileImg;
  int? appointmentType;
  int? state;

  double? priceBeforeDiscount;
  String? createdAt;
  String? dateTo;
  int? clientId;
  int? discountId;

  AppointmentData(
      {this.dateFrom,
      this.id,
      this.mentorId,
      this.priceBeforeDiscount,
      this.createdAt,
      this.dateTo,
      this.clientId,
      this.mentorPrefix,
      this.mentorFirstName,
      this.mentorLastName,
      this.appointmentType,
      this.profileImg,
      this.categoryName,
      this.discountId});

  AppointmentData.fromJson(Map<String, dynamic> json) {
    dateFrom = json['date_from'] as String?;
    id = json['id'];
    mentorId = json['mentor_id'] as int?;
    dateTo = json['date_to'] as String?;
    mentorPrefix = json['suffixe_name'] as String?;
    mentorFirstName = json['first_name'] as String?;
    mentorLastName = json['last_name'] as String?;
    categoryName = json['categoryName'] as String?;
    priceBeforeDiscount = convertToDouble(json['price_before_discount']);
    createdAt = json['created_at'] as String?;
    dateTo = json['date_to'] as String?;
    appointmentType = json['appointment_type'];
    state = json['state'];
    profileImg = json['profile_img'] as String?;
    clientId = json['client_id'] as int?;
    discountId = json['discount_id'] as int?;
  }
}
