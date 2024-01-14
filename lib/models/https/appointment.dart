import 'package:mentor_app/models/model_checker.dart';

enum AppointmentsState {
  active,
  mentorCancel,
  clientCancel,
  clientMiss,
  mentorMiss,
  completed
}

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
  String? channelId;
  String? noteFromMentor;
  String? noteFromClient;
  double? price;
  double? discountedPrice;
  int? state;
  String? mentorJoinCall;
  String? clientJoinCall;
  String? mentorDateOfClose;
  String? clientDateOfClose;
  String? currencyEnglish;
  String? currencyArabic;
  bool? isFree;
  double? mentorHourRate;
  int? discountId;
  String? profileImg;
  String? firstName;
  String? lastName;
  int? gender;
  String? dateOfBirth;
  int? countryId;
  String? flagImage;

  AppointmentData({
    this.id,
    this.dateFrom,
    this.dateTo,
    this.clientId,
    this.mentorId,
    this.appointmentType,
    this.channelId,
    this.noteFromMentor,
    this.noteFromClient,
    this.price,
    this.discountedPrice,
    this.state,
    this.mentorJoinCall,
    this.clientJoinCall,
    this.mentorDateOfClose,
    this.clientDateOfClose,
    this.currencyEnglish,
    this.currencyArabic,
    this.isFree,
    this.mentorHourRate,
    this.discountId,
    this.profileImg,
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.countryId,
    this.flagImage,
  });

  AppointmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateFrom = convertToString(json['date_from']);
    dateTo = convertToString(json['date_to']);
    clientId = json['client_id'];
    mentorId = json['mentor_id'];
    appointmentType = json['appointment_type'];
    channelId = convertToString(json['channel_id']);
    noteFromMentor = convertToString(json['note_from_mentor']);
    noteFromClient = convertToString(json['note_from_client']);
    price = convertToDouble(json['price']);
    discountedPrice = convertToDouble(json['discounted_price']);
    state = json['state'];
    mentorJoinCall = convertToString(json['mentor_join_call']);
    clientJoinCall = convertToString(json['client_join_call']);
    mentorDateOfClose = convertToString(json['mentor_date_of_close']);
    clientDateOfClose = convertToString(json['client_date_of_close']);
    currencyEnglish = json['currency_english'];
    currencyArabic = json['currency_arabic'];
    isFree = json['is_free'];
    mentorHourRate = convertToDouble(json['mentor_hour_rate']);
    discountId = json['discount_id'];
    profileImg = convertToString(json['profile_img']);
    firstName = convertToString(json['first_name']);
    lastName = convertToString(json['last_name']);
    gender = json['gender'];
    dateOfBirth = convertToString(json['date_of_birth']);
    countryId = json['country_id'];
    flagImage = convertToString(json['flag_image']);
  }
}
