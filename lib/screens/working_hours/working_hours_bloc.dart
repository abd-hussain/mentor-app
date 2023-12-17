import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/working_hour_request.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/services/mentor_properties_services.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkingHoursBloc extends Bloc<MentorPropertiesService> {
  ValueNotifier<LoadingStatus> loadingStatusNotifier = ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  ValueNotifier<List<WorkingHourModel>> listOfWorkingHourNotifier = ValueNotifier<List<WorkingHourModel>>([]);
  var box = Hive.box(DatabaseBoxConstant.userInfo);

  List<CheckBox> _prepareList({required BuildContext context, required List<int> theList}) {
    List<CheckBox> list = [];

    list.add(CheckBox(value: "1:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(1)));
    list.add(CheckBox(value: "2:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(2)));
    list.add(CheckBox(value: "3:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(3)));
    list.add(CheckBox(value: "4:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(4)));
    list.add(CheckBox(value: "5:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(5)));
    list.add(CheckBox(value: "6:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(6)));
    list.add(CheckBox(value: "7:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(7)));
    list.add(CheckBox(value: "8:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(8)));
    list.add(CheckBox(value: "9:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(9)));
    list.add(CheckBox(value: "10:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(10)));
    list.add(CheckBox(value: "11:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(11)));
    list.add(CheckBox(value: "12:00 ${AppLocalizations.of(context)!.pm}", isEnable: theList.contains(12)));
    list.add(CheckBox(value: "1:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(13)));
    list.add(CheckBox(value: "2:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(14)));
    list.add(CheckBox(value: "3:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(15)));
    list.add(CheckBox(value: "4:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(16)));
    list.add(CheckBox(value: "5:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(17)));
    list.add(CheckBox(value: "6:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(18)));
    list.add(CheckBox(value: "7:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(19)));
    list.add(CheckBox(value: "8:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(20)));
    list.add(CheckBox(value: "9:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(21)));
    list.add(CheckBox(value: "10:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(22)));
    list.add(CheckBox(value: "11:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(23)));
    list.add(CheckBox(value: "12:00 ${AppLocalizations.of(context)!.am}", isEnable: theList.contains(0)));

    return list;
  }

  void getWorkingHours(BuildContext context) {
    loadingStatusNotifier.value = LoadingStatus.inprogress;

    service.getWorkingHours().then((value) {
      loadingStatusNotifier.value = LoadingStatus.finish;
      if (value.data != null) {
        List<WorkingHourModel> theList = [];
        if (value.data!.workingHoursSaturday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(context: context, theList: value.data!.workingHoursSaturday!), dayName: "Saturday"));
        }
        if (value.data!.workingHoursSunday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(context: context, theList: value.data!.workingHoursSunday!), dayName: "Sunday"));
        }
        if (value.data!.workingHoursMonday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(context: context, theList: value.data!.workingHoursMonday!), dayName: "Monday"));
        }
        if (value.data!.workingHoursTuesday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(context: context, theList: value.data!.workingHoursTuesday!), dayName: "Tuesday"));
        }
        if (value.data!.workingHoursWednesday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(context: context, theList: value.data!.workingHoursWednesday!), dayName: "Wednesday"));
        }
        if (value.data!.workingHoursThursday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(context: context, theList: value.data!.workingHoursThursday!), dayName: "Thursday"));
        }
        if (value.data!.workingHoursFriday != null) {
          theList.add(WorkingHourModel(
              list: _prepareList(context: context, theList: value.data!.workingHoursFriday!), dayName: "Friday"));
        }

        listOfWorkingHourNotifier.value = theList;
      }
    });
  }

  void updateWorkingHours({required BuildContext context, required WorkingHoursRequest obj}) async {
    loadingStatusNotifier.value = LoadingStatus.inprogress;

    await service.updateWorkingHours(data: obj).whenComplete(() {
      loadingStatusNotifier.value = LoadingStatus.finish;
      getWorkingHours(context);
    });
  }

  @override
  onDispose() {
    loadingStatusNotifier.dispose();
    listOfWorkingHourNotifier.dispose();
  }
}
