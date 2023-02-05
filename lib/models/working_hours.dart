class WorkingHourModel {
  List<CheckBox> list;
  String dayName;

  WorkingHourModel({required this.list, required this.dayName});
}

class CheckBox {
  final String value;
  bool isEnable;

  CheckBox({required this.value, required this.isEnable});
}
