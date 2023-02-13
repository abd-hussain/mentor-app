import 'package:mentor_app/models/model_checker.dart';

class Appointments {
  List<AppointmentData>? data;
  String? message;

  Appointments({this.data, this.message});

  Appointments.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? dateFrom;
  String? dateTo;
  int? clientId;
  int? mentorId;
  int? appointmentType;
  double? priceBeforeDiscount;
  int? discountId;
  int? state;
  String? profileImg;
  String? firstName;
  String? lastName;
  int? gender;
  String? dateOfBirth;
  int? countryId;

  AppointmentData({
    this.id,
    this.dateFrom,
    this.dateTo,
    this.clientId,
    this.mentorId,
    this.appointmentType,
    this.priceBeforeDiscount,
    this.discountId,
    this.state,
    this.profileImg,
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.countryId,
  });

  AppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateFrom = convertToString(json['date_from']);
    dateTo = convertToString(json['date_to']);
    clientId = json['client_id'];
    mentorId = json['mentor_id'];
    appointmentType = json['appointment_type'];
    priceBeforeDiscount = convertToDouble(json['price_before_discount']);
    discountId = json['discount_id'];
    state = json['state'];
    profileImg = convertToString(json['profile_img']);
    firstName = convertToString(json['first_name']);
    lastName = convertToString(json['last_name']);
    gender = json['gender'];
    dateOfBirth = convertToString(json['date_of_birth']);
    countryId = json['country_id'];
  }
}
