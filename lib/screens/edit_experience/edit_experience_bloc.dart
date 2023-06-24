import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/services/account_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class EditExperienceBloc extends Bloc<AccountService> {
  ValueNotifier<bool> enableSaveButton = ValueNotifier<bool>(false);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  TextEditingController bioController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  File? cv;
  List<File?> listOfCertificates = [];

  getUserExperiance() {
    categoryController.text = "abed";
  }

  validateFields() {
    if (bioController.text.isNotEmpty &&
        categoryController.text.isNotEmpty &&
        cv != null &&
        listOfCertificates.isNotEmpty) {
      enableSaveButton.value = true;
    }
  }

  @override
  onDispose() {}
}
