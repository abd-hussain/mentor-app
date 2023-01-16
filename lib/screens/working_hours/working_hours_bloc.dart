import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/utils/mixins.dart';

class WorkingHoursBloc extends Bloc<AccountService> {
  List<WorkingHourModel> listOfWorkingHour = [
    WorkingHourModel(
      list: [
        WorkingHour(value: "1:00 pm", isEnable: true),
        WorkingHour(value: "2:00 pm", isEnable: false),
        WorkingHour(value: "3:00 pm", isEnable: true),
        WorkingHour(value: "4:00 pm", isEnable: false),
        WorkingHour(value: "5:00 pm", isEnable: false),
        WorkingHour(value: "6:00 pm", isEnable: false),
        WorkingHour(value: "7:00 pm", isEnable: false),
        WorkingHour(value: "8:00 pm", isEnable: true),
        WorkingHour(value: "9:00 pm", isEnable: true),
        WorkingHour(value: "10:00 pm", isEnable: true),
        WorkingHour(value: "11:00 pm", isEnable: true),
        WorkingHour(value: "12:00 pm", isEnable: false),
        WorkingHour(value: "1:00 am", isEnable: true),
        WorkingHour(value: "2:00 am", isEnable: false),
        WorkingHour(value: "3:00 am", isEnable: false),
        WorkingHour(value: "4:00 am", isEnable: false),
        WorkingHour(value: "5:00 am", isEnable: true),
        WorkingHour(value: "6:00 am", isEnable: true),
        WorkingHour(value: "7:00 am", isEnable: true),
        WorkingHour(value: "8:00 am", isEnable: true),
        WorkingHour(value: "9:00 am", isEnable: false),
        WorkingHour(value: "10:00 am", isEnable: true),
        WorkingHour(value: "11:00 am", isEnable: true),
        WorkingHour(value: "12:00 am", isEnable: true),
      ],
      dayName: "Sunday",
    ),
    WorkingHourModel(
      list: [
        WorkingHour(value: "1:00 pm", isEnable: true),
        WorkingHour(value: "2:00 pm", isEnable: false),
        WorkingHour(value: "3:00 pm", isEnable: true),
        WorkingHour(value: "4:00 pm", isEnable: true),
        WorkingHour(value: "5:00 pm", isEnable: true),
        WorkingHour(value: "6:00 pm", isEnable: true),
        WorkingHour(value: "7:00 pm", isEnable: true),
        WorkingHour(value: "8:00 pm", isEnable: true),
        WorkingHour(value: "9:00 pm", isEnable: true),
        WorkingHour(value: "10:00 pm", isEnable: true),
        WorkingHour(value: "11:00 pm", isEnable: true),
        WorkingHour(value: "12:00 pm", isEnable: false),
        WorkingHour(value: "1:00 am", isEnable: true),
        WorkingHour(value: "2:00 am", isEnable: false),
        WorkingHour(value: "3:00 am", isEnable: false),
        WorkingHour(value: "4:00 am", isEnable: false),
        WorkingHour(value: "5:00 am", isEnable: true),
        WorkingHour(value: "6:00 am", isEnable: true),
        WorkingHour(value: "7:00 am", isEnable: true),
        WorkingHour(value: "8:00 am", isEnable: true),
        WorkingHour(value: "9:00 am", isEnable: false),
        WorkingHour(value: "10:00 am", isEnable: true),
        WorkingHour(value: "11:00 am", isEnable: true),
        WorkingHour(value: "12:00 am", isEnable: true),
      ],
      dayName: "Monday",
    ),
  ];
  @override
  onDispose() {}
}
