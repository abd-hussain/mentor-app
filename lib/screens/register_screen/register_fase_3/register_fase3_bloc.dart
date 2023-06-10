import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/categories_model.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';

class Register3Bloc {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  TextEditingController bioController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  File? cv;
  List<File?> listOfCertificates = [];
  Category? selectedCategory;

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);
  ValueNotifier<List<Category>> listOfCategories = ValueNotifier<List<Category>>([]);

  validateFieldsForFaze3() {
    if (bioController.text.isNotEmpty &&
        categoryController.text.isNotEmpty &&
        cv != null &&
        listOfCertificates.isNotEmpty) {
      enableNextBtn.value = true;
    }
  }

  void getlistOfCategories() {
    locator<FilterService>().categories().then((value) {
      listOfCategories.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
    });
  }
}
