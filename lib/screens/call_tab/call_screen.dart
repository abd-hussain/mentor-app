import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/calender_model.dart';
import 'package:mentor_app/screens/call_tab/call_bloc.dart';
import 'package:mentor_app/screens/call_tab/widgets/call_ready_view.dart';
import 'package:mentor_app/screens/call_tab/widgets/no_call_view.dart';
import 'package:mentor_app/screens/call_tab/widgets/waiting_call_view.dart';
import 'package:mentor_app/screens/home_tab/widgets/header.dart';
import 'package:mentor_app/screens/main_contaner/main_container_bloc.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/day_time.dart';
import 'package:mentor_app/utils/logger.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final bloc = CallBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Call init Called ...');
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
            locator<MainContainerBloc>().getMentorAppointments(context);
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ValueListenableBuilder<List<CalenderMeetings>>(
              valueListenable:
                  locator<MainContainerBloc>().meetingsListNotifier,
              builder: (context, snapshot, child) {
                if (snapshot.isEmpty) {
                  return noCallView();
                }

                final appointment = bloc.getNearestMeetingToday(snapshot);

                if (appointment == null) {
                  return noCallView();
                }
                DateTime now = DateTime.now();
                DateTime timeDifference = appointment.fromTime.isAfter(now)
                    ? appointment.fromTime.subtract(Duration(
                        hours: now.hour,
                        minutes: now.minute,
                        seconds: now.second,
                      ))
                    : DateTime(now.year, now.month, now.day);

                if (bloc.isTimeDifferencePositive(timeDifference)) {
                  return WaitingCallView(
                    timerStartNumberHour: timeDifference.hour,
                    timerStartNumberMin: timeDifference.minute,
                    timerStartNumberSec: timeDifference.second,
                    metingDetails: appointment,
                    meetingtime:
                        DateFormat('hh:mm a').format(appointment.fromTime),
                    meetingduration:
                        "${appointment.toTime.difference(appointment.fromTime).inMinutes}",
                    meetingday:
                        bloc.box.get(DatabaseFieldConstant.language) == "en"
                            ? DateFormat('EEEE').format(timeDifference)
                            : DayTime().convertDayToArabic(
                                DateFormat('EEEE').format(timeDifference)),
                    cancelMeetingTapped: () {
                      bloc
                          .cancelAppointment(id: appointment.meetingId)
                          .then((value) async {
                        locator<MainContainerBloc>()
                            .getMentorAppointments(context);
                      });
                    },
                    timesup: () {
                      setState(() {});
                    },
                  );
                }

                if (chechIfMentorNotExiedTheTimeAllowedToEnter(
                    appointmentFromDate: appointment.fromTime)) {
                  return CallReadyView(
                    channelId: appointment.channelID,
                    appointmentId: appointment.meetingId,
                    meetingDurationInMin: appointment.toTime
                        .difference(appointment.fromTime)
                        .inMinutes,
                    callEnd: () {
                      locator<MainContainerBloc>()
                          .getMentorAppointments(context);
                    },
                  );
                } else {
                  return noCallView();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  bool chechIfMentorNotExiedTheTimeAllowedToEnter(
      {required DateTime appointmentFromDate}) {
    final currentDate = DateTime.now();
    final difference = currentDate.difference(appointmentFromDate).inMinutes;
    return difference < 10;
  }

  Widget noCallView() {
    return NoCallView(
      language: bloc.box.get(DatabaseFieldConstant.language),
    );
  }
}
