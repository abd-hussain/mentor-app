import 'package:mentor_app/utils/constants/constant.dart';

class CountriesModel {
  List<Country>? data;
  String? message;

  CountriesModel({this.data, this.message});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Country>[];
      json['data'].forEach((v) {
        data!.add(Country.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Country {
  int? id;
  String? flagImage;
  String? name;
  String? currency;
  String? prefixNumber;

  Country({this.id, this.flagImage, this.name, this.currency, this.prefixNumber});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flagImage = AppConstant.imagesBaseURLForCountries + json['flag_image'];
    name = json['name'];
    currency = json['currency'];
    prefixNumber = json['prefix_number'];
  }
}
