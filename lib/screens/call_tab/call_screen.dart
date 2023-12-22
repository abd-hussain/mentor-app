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
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderHomePage(
            refreshCallBack: () {
              locator<MainContainerBloc>().getMentorAppointments(context);
            },
          ),
          ValueListenableBuilder<List<CalenderMeetings>>(
              valueListenable:
                  locator<MainContainerBloc>().meetingsListNotifier,
              builder: (context, snapshot, child) {
                if (snapshot != []) {
                  final appointment =
                      bloc.checkIfThereIsAnyMeetingTodayAndReturnTheNearOne(
                          snapshot);

                  if (appointment != null) {
                    DateTime timeDifference = DateTime(DateTime.now().year);

                    if (appointment.fromTime.isAfter(DateTime.now())) {
                      timeDifference = appointment.fromTime.subtract(Duration(
                        hours: DateTime.now().hour,
                        minutes: DateTime.now().minute,
                        seconds: DateTime.now().second,
                      ));
                    }

                    if (timeDifference.hour > 0 ||
                        timeDifference.minute > 0 ||
                        timeDifference.second > 0) {
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
                    } else {
                      if (chechIfMentorNotExiedTheTimeAllowedToEnter(
                          appointmentFromDate: appointment.fromTime)) {
                        return CallReadyView(channelId: appointment.channelID);
                      } else {
                        return noCallView();
                      }
                    }
                  } else {
                    return noCallView();
                  }
                } else {
                  return noCallView();
                }
              }),
        ],
      ),
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
