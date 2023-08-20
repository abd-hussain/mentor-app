import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mentor_app/models/https/calender_model.dart';
import 'package:mentor_app/screens/calender_tab/widgets/client_info_view.dart';
import 'package:mentor_app/screens/calender_tab/widgets/price_view.dart';
import 'package:mentor_app/shared_widget/appointment_details_view.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/utils/day_time.dart';

class CalenderBottomSheetsUtil {
  final BuildContext context;
  final CalenderMeetings metingDetails;
  final String language;

  CalenderBottomSheetsUtil({
    required this.context,
    required this.metingDetails,
    required this.language,
  });

  Future bookMeetingBottomSheet({
    required Function() cancel,
  }) async {
    return await showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        enableDrag: true,
        useRootNavigator: true,
        context: context,
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
            child: Wrap(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    const Expanded(child: SizedBox()),
                    CustomText(
                      title: AppLocalizations.of(context)!.meeting,
                      textColor: const Color(0xff444444),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                meetingView(),
                const SizedBox(),
                CustomButton(
                  enableButton: DateTime.now().isBefore(metingDetails.fromTime) &&
                      metingDetails.state == AppointmentsState.active,
                  padding: const EdgeInsets.all(8.0),
                  buttonColor: const Color(0xffda1100),
                  buttonTitle: AppLocalizations.of(context)!.cancelappointment,
                  onTap: () {
                    Navigator.pop(context);
                    cancel();
                  },
                )
              ],
            ),
          );
        });
  }

  Widget meetingView() {
    final difference = metingDetails.toTime.difference(metingDetails.fromTime).inMinutes;

    return Column(
      children: [
        Center(
          child: CustomText(
            title: AppLocalizations.of(context)!.witha,
            textColor: const Color(0xff444444),
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
        ),
        ClientInfoView(metingDetails: metingDetails),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventdate,
          desc: "${metingDetails.fromTime.year}/${metingDetails.fromTime.month}/${metingDetails.fromTime.day}",
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.eventday,
          desc: language == "en"
              ? DateFormat('EEEE').format(metingDetails.fromTime)
              : DayTime().convertDayToArabic(
                  DateFormat('EEEE').format(metingDetails.fromTime),
                ),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.sessiontype,
          desc: _sessionType(metingDetails.appointmentType),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingtime,
          desc: DayTime().convertingTimingWithMinToRealTime(metingDetails.fromTime.hour, metingDetails.fromTime.minute),
        ),
        AppointmentDetailsView(
          title: AppLocalizations.of(context)!.meetingduration,
          desc: "$difference ${AppLocalizations.of(context)!.min}",
        ),
        AppointmentDetailsView(
            title: AppLocalizations.of(context)!.meetingstatus,
            desc: _sessionStatusString(metingDetails.state),
            descColor: metingDetails.state == AppointmentsState.active ? Colors.green : Colors.red),
        PriceView(priceBeforeDiscount: metingDetails.priceBefore, priceAfterDiscount: metingDetails.priceAfter),
        Container(height: 1, color: const Color(0xff444444)),
      ],
    );
  }

  String _sessionType(int id) {
    if (id == 1) {
      return AppLocalizations.of(context)!.schudule;
    } else {
      return AppLocalizations.of(context)!.instant;
    }
  }

  String _sessionStatusString(AppointmentsState state) {
    switch (state) {
      case AppointmentsState.active:
        return AppLocalizations.of(context)!.active;

      case AppointmentsState.clientCancel:
        return AppLocalizations.of(context)!.clientcancelcall;

      case AppointmentsState.mentorCancel:
        return AppLocalizations.of(context)!.mentorcancelcall;

      case AppointmentsState.clientMiss:
        return AppLocalizations.of(context)!.clientmisscall;

      case AppointmentsState.mentorMiss:
        return AppLocalizations.of(context)!.mentormisscall;

      case AppointmentsState.completed:
        return AppLocalizations.of(context)!.compleated;
    }
  }
}
