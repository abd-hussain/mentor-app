import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';

class Register5Bloc {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  TextEditingController ratePerHourController = TextEditingController();
  TextEditingController ibanController = TextEditingController();

  String ibanRes = "";

  validateFieldsForFaze5() {
    if (ratePerHourController.text.isNotEmpty) {
      double convertedText = double.tryParse(ratePerHourController.text) ?? 0.0;
      if (convertedText > 0) {
        enableNextBtn.value = true;
      } else {
        enableNextBtn.value = false;
      }
    } else {
      enableNextBtn.value = false;
    }
  }

  encreseRatePerHourBy1() {
    if (ratePerHourController.text.isEmpty) {
      ratePerHourController.text = "1.0";
    }

    double convertedText = double.tryParse(ratePerHourController.text) ?? 0.0;

    if (convertedText < 1000) {
      convertedText = convertedText + 1;
      ratePerHourController.text = convertedText.toStringAsFixed(2);
    }

    validateFieldsForFaze5();
  }

  decreseRatePerHourBy1() {
    if (ratePerHourController.text.isEmpty) {
      ratePerHourController.text = "1.0";
    }
    double convertedText = double.tryParse(ratePerHourController.text) ?? 0.0;

    if (convertedText > 1) {
      convertedText = convertedText - 1;
      ratePerHourController.text = convertedText.toStringAsFixed(2);
    }
    validateFieldsForFaze5();
  }
}
