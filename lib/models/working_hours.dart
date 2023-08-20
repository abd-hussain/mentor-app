class WorkingHourModel {
  List<CheckBox> list;
  String dayName;

  WorkingHourModel({required this.list, required this.dayName});
}

class CheckBox {
  final int? id;
  final String value;
  bool isEnable;

  CheckBox({this.id, required this.value, required this.isEnable});
}
