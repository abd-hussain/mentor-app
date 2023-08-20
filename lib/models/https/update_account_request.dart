import 'dart:io';

class UpdateAccountRequest {
  String? suffix;
  String? firstName;
  String? lastName;
  int? gender;
  int countryId;
  String? speackingLanguage;
  File? profileImage;
  File? iDImage;
  String dateOfBirth;
  String? mobileNumber;

  UpdateAccountRequest({
    required this.suffix,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.countryId,
    this.speackingLanguage,
    required this.profileImage,
    required this.iDImage,
    required this.dateOfBirth,
    this.mobileNumber,
  });
}

class UpdateAccountExperianceRequest {
  String? experienceSince;
  List<int>? majors;
  File? cv;
  File? cert1;
  File? cert2;
  File? cert3;

  UpdateAccountExperianceRequest({
    required this.experienceSince,
    required this.majors,
    required this.cv,
    required this.cert1,
    required this.cert2,
    required this.cert3,
  });
}
