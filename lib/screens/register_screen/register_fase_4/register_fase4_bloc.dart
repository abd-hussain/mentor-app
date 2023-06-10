import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';

class Register4Bloc {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  ValueNotifier<List<WorkingHourModel>> listOfWorkingHourNotifier = ValueNotifier<List<WorkingHourModel>>([]);
  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  List<CheckBox> prepareList(List<int> theList) {
    List<CheckBox> list = [];

    list.add(CheckBox(value: "1:00 pm", isEnable: theList.contains(1)));
    list.add(CheckBox(value: "2:00 pm", isEnable: theList.contains(2)));
    list.add(CheckBox(value: "3:00 pm", isEnable: theList.contains(3)));
    list.add(CheckBox(value: "4:00 pm", isEnable: theList.contains(4)));
    list.add(CheckBox(value: "5:00 pm", isEnable: theList.contains(5)));
    list.add(CheckBox(value: "6:00 pm", isEnable: theList.contains(6)));
    list.add(CheckBox(value: "7:00 pm", isEnable: theList.contains(7)));
    list.add(CheckBox(value: "8:00 pm", isEnable: theList.contains(8)));
    list.add(CheckBox(value: "9:00 pm", isEnable: theList.contains(9)));
    list.add(CheckBox(value: "10:00 pm", isEnable: theList.contains(10)));
    list.add(CheckBox(value: "11:00 pm", isEnable: theList.contains(11)));
    list.add(CheckBox(value: "12:00 pm", isEnable: theList.contains(12)));
    list.add(CheckBox(value: "1:00 am", isEnable: theList.contains(13)));
    list.add(CheckBox(value: "2:00 am", isEnable: theList.contains(14)));
    list.add(CheckBox(value: "3:00 am", isEnable: theList.contains(15)));
    list.add(CheckBox(value: "4:00 am", isEnable: theList.contains(16)));
    list.add(CheckBox(value: "5:00 am", isEnable: theList.contains(17)));
    list.add(CheckBox(value: "6:00 am", isEnable: theList.contains(18)));
    list.add(CheckBox(value: "7:00 am", isEnable: theList.contains(19)));
    list.add(CheckBox(value: "8:00 am", isEnable: theList.contains(20)));
    list.add(CheckBox(value: "9:00 am", isEnable: theList.contains(21)));
    list.add(CheckBox(value: "10:00 am", isEnable: theList.contains(22)));
    list.add(CheckBox(value: "11:00 am", isEnable: theList.contains(23)));
    list.add(CheckBox(value: "12:00 am", isEnable: theList.contains(0)));

    return list;
  }

  fillListOfWorkingHourNotifier() {
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: prepareList([]), dayName: "Saturday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: prepareList([]), dayName: "Sunday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: prepareList([]), dayName: "Monday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: prepareList([]), dayName: "Tuesday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: prepareList([]), dayName: "Wednesday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: prepareList([]), dayName: "Thursday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: prepareList([]), dayName: "Friday"));
  }

  validateFieldsForFaze4() {
    bool isButtonEnabled = false;

    for (var weekDay in listOfWorkingHourNotifier.value) {
      for (var items in weekDay.list) {
        if (items.isEnable) {
          isButtonEnabled = true;
          break;
        }
      }
    }

    enableNextBtn.value = isButtonEnabled;
  }
}
