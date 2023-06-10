import 'package:flutter/material.dart';
import 'package:mentor_app/models/working_hours.dart';

class Register4Bloc {
  ValueNotifier<List<WorkingHourModel>> listOfWorkingHourNotifier = ValueNotifier<List<WorkingHourModel>>([]);
  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  fillListOfWorkingHourNotifier() {
    List<CheckBox> list = [
      CheckBox(value: "1:00 pm", isEnable: false),
      CheckBox(value: "2:00 pm", isEnable: false),
      CheckBox(value: "3:00 pm", isEnable: false),
      CheckBox(value: "4:00 pm", isEnable: false),
      CheckBox(value: "5:00 pm", isEnable: false),
      CheckBox(value: "6:00 pm", isEnable: false),
      CheckBox(value: "7:00 pm", isEnable: false),
      CheckBox(value: "8:00 pm", isEnable: false),
      CheckBox(value: "9:00 pm", isEnable: false),
      CheckBox(value: "10:00 pm", isEnable: false),
      CheckBox(value: "11:00 pm", isEnable: false),
      CheckBox(value: "12:00 pm", isEnable: false),
      CheckBox(value: "1:00 am", isEnable: false),
      CheckBox(value: "2:00 am", isEnable: false),
      CheckBox(value: "3:00 am", isEnable: false),
      CheckBox(value: "4:00 am", isEnable: false),
      CheckBox(value: "5:00 am", isEnable: false),
      CheckBox(value: "6:00 am", isEnable: false),
      CheckBox(value: "7:00 am", isEnable: false),
      CheckBox(value: "8:00 am", isEnable: false),
      CheckBox(value: "9:00 am", isEnable: false),
      CheckBox(value: "10:00 am", isEnable: false),
      CheckBox(value: "11:00 am", isEnable: false),
      CheckBox(value: "12:00 am", isEnable: false),
    ];

    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: list, dayName: "Saturday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: list, dayName: "Sunday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: list, dayName: "Monday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: list, dayName: "Tuesday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: list, dayName: "Wednesday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: list, dayName: "Thursday"));
    listOfWorkingHourNotifier.value.add(WorkingHourModel(list: list, dayName: "Friday"));
  }

  validateFieldsForFaze4() {}
}
