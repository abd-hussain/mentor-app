import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/screens/event_details/event_details_bloc.dart';
import 'package:mentor_app/shared_widget/appointment_details_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/loading_view.dart';
import 'package:mentor_app/utils/constants/constant.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/currency.dart';
import 'package:mentor_app/utils/day_time.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final bloc = EventDetailsBloc();

  @override
  void didChangeDependencies() {
    bloc.handleReadingArguments(context: context, arguments: ModalRoute.of(context)!.settings.arguments);
    bloc.getEventDetails(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.eventdetails, actions: [
        IconButton(
          onPressed: () {
            //TODO: handle share
          },
          icon: const Icon(Icons.share),
        )
      ]),
      body: SafeArea(
        child: ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatus,
            builder: (context, snapshot, child) {
              return snapshot == LoadingStatus.inprogress
                  ? const LoadingView()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.network(
                            bloc.image!,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: CustomText(
                                title: bloc.eventName!,
                                fontSize: 18,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                                maxLins: 3,
                                textColor: const Color(0xff444444),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              children: [
                                Expanded(
                                    child: eventInfoBox(
                                        title: AppLocalizations.of(context)!.eventdate, desc: bloc.eventDate!)),
                                Expanded(
                                    child: eventInfoBox(
                                        title: AppLocalizations.of(context)!.eventday,
                                        desc: bloc.box.get(DatabaseFieldConstant.language) == "en"
                                            ? bloc.eventDayName!
                                            : DayTime().convertDayToArabic(bloc.eventDayName!))),
                                Expanded(
                                    child: eventInfoBox(
                                        title: AppLocalizations.of(context)!.eventhour, desc: bloc.eventHour!)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: eventInfoBox(
                                        title: AppLocalizations.of(context)!.eventDuration, desc: bloc.eventDuration!)),
                                Expanded(
                                  flex: 3,
                                  child: eventInfoBox(
                                      title: AppLocalizations.of(context)!.price,
                                      desc: bloc.eventPrice! == 0
                                          ? "( ${AppLocalizations.of(context)!.free} )"
                                          : "( ${Currency().calculateHourRate(bloc.eventPrice!, Timing.hour)} )"),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              title: "-- ${AppLocalizations.of(context)!.eventdesc} --",
                              fontSize: 16,
                              textColor: const Color(0xff554d56),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              title: bloc.eventDescripton!,
                              fontSize: 14,
                              textAlign: TextAlign.center,
                              maxLins: 40,
                              textColor: const Color(0xff444444),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xff034061),
                                      radius: 40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: bloc.mentorProfileImage != ""
                                            ? FadeInImage(
                                                placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                                image: NetworkImage(
                                                    AppConstant.imagesBaseURLForMentors + bloc.mentorProfileImage!,
                                                    scale: 1),
                                              )
                                            : Image.asset(
                                                'assets/images/avatar.jpeg',
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width - 150,
                                          child: CustomText(
                                            title:
                                                "${bloc.mentorSuffixeName} ${bloc.mentorFirstName} ${bloc.mentorLastName}",
                                            fontSize: 14,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.bold,
                                            maxLins: 3,
                                            textColor: const Color(0xff554d56),
                                          ),
                                        ),
                                        const Expanded(child: SizedBox()),
                                        CustomText(
                                          title: bloc.mentorCategoryName!,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          textColor: const Color(0xff554d56),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          AppointmentDetailsView(
                            title: AppLocalizations.of(context)!.freeseat,
                            desc: (bloc.maxNumberOfAttendance - bloc.joiningClients).toString(),
                          ),
                        ],
                      ),
                    );
            }),
      ),
    );
  }

  Widget eventInfoBox({required String title, required String desc}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 0.3,
              offset: const Offset(0, 0.1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title: title,
              fontSize: 14,
              textColor: const Color(0xff554d56),
            ),
            CustomText(
              title: desc,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textColor: const Color(0xff554d56),
            ),
          ],
        ),
      ),
    );
  }
}
