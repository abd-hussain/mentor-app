import 'package:flutter/material.dart';
import 'package:mentor_app/services/mentor_properties_services.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/mixins.dart';

class RatePerHourBloc extends Bloc<MentorPropertiesService> {
  ValueNotifier<LoadingStatus> loadingStatusNotifier = ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  ValueNotifier<bool> enableSaveButton = ValueNotifier<bool>(false);

  TextEditingController ratePerHourController = TextEditingController();

  double recumendedRatePerHour = 22.0;

  void getHourPerRate() {
    loadingStatusNotifier.value = LoadingStatus.inprogress;
    ratePerHourController.text = "22.00";
    loadingStatusNotifier.value = LoadingStatus.finish;
  }

  Future<void> changeRateRequest() async {}

  validateFieldsForFaze5() {
    if (ratePerHourController.text.isNotEmpty) {
      double convertedText = double.tryParse(ratePerHourController.text) ?? 0.0;
      if (convertedText > 0) {
        enableSaveButton.value = true;
      } else {
        enableSaveButton.value = false;
      }
    } else {
      enableSaveButton.value = false;
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

  @override
  onDispose() {
    // TODO: implement onDispose
    throw UnimplementedError();
  }
}