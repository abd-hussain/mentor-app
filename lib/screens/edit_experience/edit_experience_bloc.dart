import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/suffix_model.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/services/account_service.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/mixins.dart';

class EditExperienceBloc extends Bloc<AccountService> {
  ValueNotifier<bool> enableSaveButton = ValueNotifier<bool>(false);
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  ValueNotifier<List<CheckBox>> listOfMajorsNotifier = ValueNotifier<List<CheckBox>>([]);
  ValueNotifier<LoadingStatus> loadingStatusNotifier = ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  TextEditingController categoryController = TextEditingController();
  TextEditingController experianceSinceController = TextEditingController();

  File? cv;
  List<File?> listOfCertificates = [];
  List<SuffixData> listOfAllMajors = [];

  getListOfMajors() {
    locator<FilterService>().getMajors().then((value) {
      listOfAllMajors = value!;
    });
  }

  getProfileExperiance() {
    getListOfMajors();
    loadingStatusNotifier.value = LoadingStatus.inprogress;
    service.getProfileExperiance().then((value) {
      if (value.data != null) {
        if (value.data!.categoryName != null) {
          categoryController.text = value.data!.categoryName!;
        }
        if (value.data!.experienceSince != null) {
          experianceSinceController.text = value.data!.experienceSince!;
        }
        if (value.data!.majors != null) {
          listOfMajorsNotifier.value = prepareListOfMajors(value.data!.majors!);
        }
        if (value.data!.cv != null) {
          // categoryController.text = value.data!.categoryName!;
        }
        if (value.data!.cert1 != null) {
          // categoryController.text = value.data!.categoryName!;
        }
        if (value.data!.cert2 != null) {
          // categoryController.text = value.data!.categoryName!;
        }
        if (value.data!.cert3 != null) {
          // categoryController.text = value.data!.categoryName!;
        }
      }
      loadingStatusNotifier.value = LoadingStatus.finish;
    });
  }

  List<CheckBox> prepareListOfMajors(List<int> majors) {
    List<CheckBox> list = [];
    int counter = 0;

    for (var mainItem in listOfAllMajors) {
      list.add(CheckBox(value: mainItem.name!, isEnable: false));

      for (var item in majors) {
        if (mainItem.id == item) {
          list[counter].isEnable = true;
        }
      }
      counter = counter + 1;
    }

    return list;
  }

  validateFields() {
    if (categoryController.text.isNotEmpty &&
        experianceSinceController.text.isNotEmpty &&
        cv != null &&
        listOfCertificates.isNotEmpty) {
      enableSaveButton.value = true;
    }
  }

  @override
  onDispose() {
    loadingStatusNotifier.dispose();
  }
}
