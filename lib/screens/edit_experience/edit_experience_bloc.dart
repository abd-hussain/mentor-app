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
  ValueNotifier<List<CheckBox>> listOfMajorsNotifier =
      ValueNotifier<List<CheckBox>>([]);
  ValueNotifier<LoadingStatus> loadingStatusNotifier =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  TextEditingController categoryController = TextEditingController();
  TextEditingController experianceSinceController = TextEditingController();

  File? cv;
  File? cert1;
  File? cert2;
  File? cert3;
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
          if (value.data!.cv!.isNotEmpty) {
            cv = File("");
          }
        }

        if (value.data!.cert1 != null) {
          if (value.data!.cert1!.isNotEmpty) {
            cert1 = File("");
          }
        }

        if (value.data!.cert2 != null) {
          if (value.data!.cert2!.isNotEmpty) {
            cert2 = File("");
          }
        }

        if (value.data!.cert3 != null) {
          if (value.data!.cert3!.isNotEmpty) {
            cert3 = File("");
          }
        }
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
    List<CheckBox> list = [];
    int counter = 0;

    for (var mainItem in listOfAllMajors) {
      list.add(
          CheckBox(value: mainItem.name!, isEnable: false, id: mainItem.id!));

      for (var item in majors) {
        if (mainItem.id == item) {
          list[counter].isEnable = true;
        }
      }
      counter = counter + 1;
    }

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
        cv != null) {
      enableSaveButton.value = true;
    }
  }

  @override
  onDispose() {
    loadingStatusNotifier.dispose();
  }
}
