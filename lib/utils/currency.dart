import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';

enum Timing { hour, halfHour, quarterHour }

class Currency {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  String calculateHourRate(double hourRate, Timing timing) {
    //TODO must save object and return obj
    String currency = "JD";
    if (box.get(DatabaseFieldConstant.language) != "en") {
      currency = "د.أ";
    }
    switch (timing) {
      case Timing.hour:
        return "$hourRate $currency";
      case Timing.halfHour:
        return "${hourRate / 2} $currency";
      case Timing.quarterHour:
        return "${hourRate / 4} $currency";
    }
  }

  String getHourRateWithoutCurrency(String hourRate) {
    String currency = "JD";
    if (box.get(DatabaseFieldConstant.language) != "en") {
      currency = "د.أ";
    }
    return hourRate.replaceAll(currency, "");
  }
}
