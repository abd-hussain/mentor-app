import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/categories_model.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';

class Register3Bloc {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  TextEditingController bioController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  File? cv;
  List<File?> listOfCertificates = [];
  Category? selectedCategory;

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);
  ValueNotifier<List<Category>> listOfCategories = ValueNotifier<List<Category>>([]);
  StreamController<LoadingStatus> loadingStatusController = StreamController<LoadingStatus>();
  ValueNotifier<List<CheckBox>> listOfSpeakingLanguageNotifier = ValueNotifier<List<CheckBox>>([]);

  validateFieldsForFaze3() {
    if (bioController.text.isNotEmpty &&
        categoryController.text.isNotEmpty &&
        cv != null &&
        listOfCertificates.isNotEmpty &&
        listOfSpeakingLanguageNotifier.value.isNotEmpty) {
      enableNextBtn.value = true;
    }
  }

  void getlistOfCategories() {
    loadingStatusController.sink.add(LoadingStatus.inprogress);

    locator<FilterService>().categories().then((value) {
      listOfCategories.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
      listOfSpeakingLanguageNotifier.value = _prepareList();
      loadingStatusController.sink.add(LoadingStatus.finish);
    });
  }

  List<CheckBox> _prepareList() {
    List<CheckBox> list = [];

    list.add(CheckBox(value: "English", isEnable: false));
    list.add(CheckBox(value: "العربية", isEnable: true));
    list.add(CheckBox(value: "Français", isEnable: false));
    list.add(CheckBox(value: "Español", isEnable: false));
    list.add(CheckBox(value: "Türkçe", isEnable: false));

    return list;
  }
}
