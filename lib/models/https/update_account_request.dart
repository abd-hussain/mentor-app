import 'dart:io';

class UpdateAccountRequest {
  String? suffix;
  String? firstName;
  String? lastName;
  int? gender;
  int countryId;
  List<String>? speackingLanguage;
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
