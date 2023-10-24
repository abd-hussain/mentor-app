import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/suffix_model.dart';
import 'package:mentor_app/models/https/update_account_request.dart';
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
  String cvFileUrl = "";

  File? cert1;
  String cert1FileUrl = "";

  File? cert2;
  String cert2FileUrl = "";

  File? cert3;
  String cert3FileUrl = "";

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
      final data = value.data;

      if (data != null) {
        categoryController.text = data.categoryName ?? "";
        experianceSinceController.text = data.experienceSince ?? "";

        if (data.majors != null) {
          listOfMajorsNotifier.value = prepareListOfMajors(data.majors!);
        }

        cvFileUrl = data.cv ?? "";
        cert1FileUrl = data.cert1 ?? "";
        cert2FileUrl = data.cert2 ?? "";
        cert3FileUrl = data.cert3 ?? "";
      }
      loadingStatusNotifier.value = LoadingStatus.finish;
    });
  }

  Future<dynamic> updateProfileExperiance() {
    // loadingStatusNotifier.value = LoadingStatus.inprogress;

    return service.updateProfileExperiance(
      account: UpdateAccountExperianceRequest(
        experienceSince: experianceSinceController.text,
        majors: getIntegerListOfMajors(listOfMajorsNotifier.value),
        cv: cv,
        cert1: cert1,
        cert2: cert2,
        cert3: cert3,
      ),
    );
  }

  List<CheckBox> prepareListOfMajors(List<int> majors) {
    final List<CheckBox> list = listOfAllMajors.map((mainItem) {
      final isEnable = majors.contains(mainItem.id);
      return CheckBox(value: mainItem.name!, isEnable: isEnable, id: mainItem.id!);
    }).toList();

    return list;
  }

  List<int> getIntegerListOfMajors(List<CheckBox> majors) {
    List<int> list = [];

    for (var item in majors) {
      if (item.isEnable) {
        list.add(item.id!);
      }
    }

    return list;
  }

  validateFields() {
    enableSaveButton.value = false;

    if (experianceSinceController.text.isNotEmpty &&
        listOfMajorsNotifier.value.isNotEmpty &&
        (cv != null || cvFileUrl.isNotEmpty) &&
        (cert1 != null || cert1FileUrl.isNotEmpty) &&
        (cert2 != null || cert2FileUrl.isNotEmpty) &&
        (cert3 != null || cert3FileUrl.isNotEmpty)) {
      enableSaveButton.value = true;
    }
  }

  @override
  onDispose() {
    loadingStatusNotifier.dispose();
  }
}
