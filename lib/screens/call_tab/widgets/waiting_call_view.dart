import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/models/https/calender_model.dart';
import 'package:mentor_app/screens/calender_tab/widgets/client_info_view.dart';
import 'package:mentor_app/shared_widget/appointment_details_view.dart';
import 'package:mentor_app/shared_widget/cancel_booking_bottom_sheet.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'dart:async';

import 'package:mentor_app/shared_widget/custom_text.dart';

class WaitingCallView extends StatefulWidget {
  final int timerStartNumberHour;
  final int timerStartNumberMin;
  final int timerStartNumberSec;
  final String meetingduration;
  final String meetingtime;
  final String meetingday;

  final CalenderMeetings metingDetails;

  final Function() cancelMeetingTapped;

  const WaitingCallView(
      {super.key,
      required this.timerStartNumberHour,
      required this.timerStartNumberMin,
      required this.timerStartNumberSec,
      required this.cancelMeetingTapped,
      required this.meetingduration,
      required this.meetingtime,
      required this.meetingday,
      required this.metingDetails});

  @override
  State<WaitingCallView> createState() => _WaitingCallViewState();
}

class _WaitingCallViewState extends State<WaitingCallView> {
  Timer? timer;
  int timerStartNumberSec = 0;
  int timerStartNumberMin = 0;
  int timerStartNumberHour = 0;

  @override
  void didChangeDependencies() {
    timerStartNumberSec = widget.timerStartNumberSec;
    timerStartNumberMin = widget.timerStartNumberMin;
    timerStartNumberHour = widget.timerStartNumberHour;

    startTimer();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/lottie/115245-medical-heart-pressure-timer.zip',
            height: 200),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CustomText(
            title: AppLocalizations.of(context)!.remanintime,
            fontSize: 20,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: CustomText(
            title:
                "${timerStartNumberHour > 9 ? "$timerStartNumberHour" : "0$timerStartNumberHour"} : ${timerStartNumberMin > 9 ? "$timerStartNumberMin" : "0$timerStartNumberMin"} : ${timerStartNumberSec > 9 ? "$timerStartNumberSec" : "0$timerStartNumberSec"}",
            fontSize: 30,
            textColor: const Color(0xff554d56),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomText(
            title: "-- ${AppLocalizations.of(context)!.appointmentdetails} --",
            fontSize: 16,
            textColor: const Color(0xff554d56),
          ),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventday,
          desc: widget.meetingday,
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingtime,
          desc: widget.meetingtime,
          forceView: true,
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingduration,
          desc:
              "${widget.meetingduration} ${AppLocalizations.of(context)!.min}",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.clientnote,
          desc: widget.metingDetails.clientnote,
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.mentornote,
          desc: widget.metingDetails.mentornote,
        ),
        ClientInfoView(metingDetails: widget.metingDetails),
        CustomButton(
          enableButton:
              DateTime.now().isBefore(widget.metingDetails.fromTime) &&
                  widget.metingDetails.state == AppointmentsState.active,
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width / 2,
          buttonColor: const Color(0xffda1100),
          buttonTitle: AppLocalizations.of(context)!.cancelappointment,
          onTap: () {
            CancelBookingBottomSheetsUtil(context: context)
                .bookMeetingBottomSheet(
              confirm: () {
                widget.cancelMeetingTapped();
              },
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerStartNumberHour == 0 &&
            timerStartNumberMin == 0 &&
            timerStartNumberSec == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            if (timerStartNumberSec > 0) {
              timerStartNumberSec = timerStartNumberSec - 1;
            } else {
              if (timerStartNumberMin > 0) {
                timerStartNumberMin = timerStartNumberMin - 1;
                timerStartNumberSec = 59;
              } else {
                timerStartNumberHour = timerStartNumberHour - 1;
                timerStartNumberMin = 59;
                timerStartNumberSec = 59;
              }
            }
          });
        }
      },
    );
  }
}