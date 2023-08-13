import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/suffix_model.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/services/mentor_settings.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class EditExperienceBloc extends Bloc<MentorSettingsService> {
  ValueNotifier<bool> enableSaveButton = ValueNotifier<bool>(false);
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  ValueNotifier<List<CheckBox>> listOfMajorsNotifier = ValueNotifier<List<CheckBox>>([]);

  List<SuffixData> listOfMajors = [];

  TextEditingController categoryController = TextEditingController();

  File? cv;
  List<File?> listOfCertificates = [];

  getListOfMajors() {
    service.getMajors().then((value) {
      listOfMajors = value!;
    });
  }

  getUserExperiance() {
    categoryController.text = "abed";
  }

  validateFields() {
    if (categoryController.text.isNotEmpty && cv != null && listOfCertificates.isNotEmpty) {
      enableSaveButton.value = true;
    }
  }

  @override
  onDispose() {}
}
