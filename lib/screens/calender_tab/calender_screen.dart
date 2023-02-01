import 'package:flutter/material.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/calender_model.dart';
import 'package:mentor_app/screens/calender_tab/calender_bloc.dart';
import 'package:mentor_app/screens/calender_tab/widgets/meeting_datasource.dart';
import 'package:mentor_app/screens/home_tab/widgets/header.dart';
import 'package:mentor_app/screens/main_contaner/main_container_bloc.dart';
import 'package:mentor_app/utils/logger.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final bloc = CalenderBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Calender init Called ...');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderHomePage(),
        const SizedBox(height: 8),
        Expanded(
          child: ValueListenableBuilder<List<CalenderMeetings>>(
              valueListenable: locator<MainContainerBloc>().meetingsListNotifier,
              builder: (context, snapshot, child) {
                return SfCalendar(
                    view: CalendarView.month,
                    firstDayOfWeek: 6,
                    allowAppointmentResize: true,
                    initialSelectedDate: DateTime.now(),
                    todayHighlightColor: const Color(0xff4CB6EA),
                    dataSource: MeetingDataSource(context, snapshot),
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                      showAgenda: true,
                      numberOfWeeksInView: 6,
                      appointmentDisplayCount: 10,
                      agendaStyle: AgendaStyle(
                        backgroundColor: Color(0xffE8E8E8),
                        dayTextStyle: TextStyle(fontSize: 16, color: Colors.black),
                        dateTextStyle: TextStyle(fontSize: 25, color: Colors.black),
                        placeholderTextStyle: TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                    ),
                    onTap: (calendarTapDetails) {
                      //TODO
                      // if (calendarTapDetails.appointments != null &&
                      //     calendarTapDetails.targetElement == CalendarElement.appointment) {
                      //   final item = calendarTapDetails.appointments![0] as CalenderMeetings;
                      //   CalenderBottomSheetsUtil(
                      //     context: context,
                      //     metingDetails: item,
                      //     language: bloc.box.get(DatabaseFieldConstant.language),
                      //   ).bookMeetingBottomSheet(
                      //     cancel: () {
                      //       // bloc.cancelMeeting(item.meetingId).whenComplete(() async {
                      //       //   locator<MainContainerBloc>().getAppointmentsAndEvents();
                      //       //   setState(() {});
                      //       // });
                      //     },
                      //   );
                      // }
                    });
              }),
        ),
      ],
    );
  }
}
