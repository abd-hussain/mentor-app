import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/add_comment_appointment.dart';
import 'package:mentor_app/models/https/appointment.dart';
import 'package:mentor_app/screens/calender_tab/calender_bloc.dart';
import 'package:mentor_app/screens/calender_tab/widgets/calender_bottom_sheet.dart';
import 'package:mentor_app/screens/calender_tab/widgets/meeting_datasource.dart';
import 'package:mentor_app/screens/home_tab/widgets/header.dart';
import 'package:mentor_app/shared_widget/cancel_booking_bottom_sheet.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
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
    bloc.getMentorAppointments(context);
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
        HeaderHomePage(
          refreshCallBack: () {
            bloc.getMentorAppointments(context);
          },
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ValueListenableBuilder<List<AppointmentData>>(
              valueListenable: bloc.meetingsListNotifier,
              builder: (context, snapshot, child) {
                return SfCalendar(
                    view: CalendarView.month,
                    firstDayOfWeek: 6,
                    allowAppointmentResize: true,
                    initialSelectedDate: DateTime.now(),
                    todayHighlightColor: const Color(0xff4CB6EA),
                    dataSource: MeetingDataSource(context, snapshot),
                    monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.indicator,
                      showAgenda: true,
                      numberOfWeeksInView: 6,
                      appointmentDisplayCount: 10,
                      agendaStyle: AgendaStyle(
                        backgroundColor: Color(0xffE8E8E8),
                        dayTextStyle:
                            TextStyle(fontSize: 16, color: Colors.black),
                        dateTextStyle:
                            TextStyle(fontSize: 25, color: Colors.black),
                        placeholderTextStyle:
                            TextStyle(fontSize: 25, color: Colors.grey),
                      ),
                    ),
                    onTap: (calendarTapDetails) {
                      if (calendarTapDetails.appointments != null &&
                          calendarTapDetails.targetElement ==
                              CalendarElement.appointment) {
                        final item = calendarTapDetails.appointments![0]
                            as AppointmentData;

                        CalenderBottomSheetsUtil(
                          context: context,
                          metingDetails: item,
                          language:
                              bloc.box.get(DatabaseFieldConstant.language),
                        ).bookMeetingBottomSheet(
                          cancel: () {
                            CancelBookingBottomSheetsUtil(context: context)
                                .bookMeetingBottomSheet(
                              confirm: () {
                                bloc
                                    .cancelMeeting(item.id!)
                                    .whenComplete(() async {
                                  bloc.getMentorAppointments(context);
                                  setState(() {});
                                });
                              },
                            );
                          },
                          addNote: () {
                            CalenderBottomSheetsUtil(
                              context: context,
                              metingDetails: item,
                              language:
                                  bloc.box.get(DatabaseFieldConstant.language),
                            ).showAddEditNoteDialog(
                                note: item.noteFromMentor ?? "",
                                confirm: (note) {
                                  var body = AddCommentToAppointment(
                                      id: item.id!, comment: note);
                                  bloc.addNote(body).whenComplete(() async {
                                    bloc.getMentorAppointments(context);
                                    setState(() {});
                                  });
                                });
                          },
                        );
                      }
                    });
              }),
        ),
      ],
    );
  }
}
