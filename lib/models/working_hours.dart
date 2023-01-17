class WorkingHourModel {
  List<WorkingHour> list;
  String dayName;

  WorkingHourModel({required this.list, required this.dayName});
}

class WorkingHour {
  final String value;
  bool isEnable;

  WorkingHour({required this.value, required this.isEnable});
}