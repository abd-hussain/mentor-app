class AccountInfo {
  AccountInfoData? data;
  String? message;

  AccountInfo({this.data, this.message});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AccountInfoData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class AccountInfoData {
  String? profileImg;
  String? mobileNumber;
  String? suffixeName;
  String? dateOfBirth;
  String? firstName;
  String? email;
  String? lastName;
  int? gender;
  List<String>? speakingLanguage;
  int? countryId;
  DBCountries? dBCountries;
  String? referalCode;
  String? idImg;

  AccountInfoData(
      {this.profileImg,
      this.mobileNumber,
      this.suffixeName,
      this.dateOfBirth,
      this.firstName,
      this.email,
      this.lastName,
      this.gender,
      this.speakingLanguage,
      this.countryId,
      this.dBCountries,
      this.referalCode,
      this.idImg});

  AccountInfoData.fromJson(Map<String, dynamic> json) {
    profileImg = json['profile_img'];
    mobileNumber = json['mobile_number'];
    suffixeName = json['suffixe_name'];
    dateOfBirth = json['date_of_birth'];
    firstName = json['first_name'];
    email = json['email'];
    lastName = json['last_name'];
    gender = json['gender'];
    speakingLanguage = json['speaking_language'].cast<String>();
    countryId = json['country_id'];
    dBCountries = json['DB_Countries'] != null ? DBCountries.fromJson(json['DB_Countries']) : null;
    referalCode = json['referal_code'];
    idImg = json['id_img'];
  }
}

class DBCountries {
  String? flagImage;
  String? currencyArabic;
  String? nameArabic;
  String? prefixNumber;
  String? createdAt;
  String? nameEnglish;
  int? id;
  String? currencyEnglish;
  bool? published;

  DBCountries(
      {this.flagImage,
      this.currencyArabic,
      this.nameArabic,
      this.prefixNumber,
      this.createdAt,
      this.nameEnglish,
      this.id,
      this.currencyEnglish,
      this.published});

  DBCountries.fromJson(Map<String, dynamic> json) {
    flagImage = json['flag_image'];
    currencyArabic = json['currency_arabic'];
    nameArabic = json['name_arabic'];
    prefixNumber = json['prefix_number'];
    createdAt = json['created_at'];
    nameEnglish = json['name_english'];
    id = json['id'];
    currencyEnglish = json['currency_english'];
    published = json['published'];
  }
}
