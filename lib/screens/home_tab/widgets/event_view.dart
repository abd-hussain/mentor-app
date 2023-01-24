import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mentor_app/models/https/home_response.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/utils/constants/constant.dart';
import 'package:mentor_app/utils/currency.dart';
import 'package:mentor_app/utils/day_time.dart';

class EventView extends StatelessWidget {
  final String language;
  final List<MainEvent> listOfEvents;
  final Function(MainEvent) onEventSelected;
  final Function(MainEvent) onOptionSelected;
  final Function(MainEvent) onShare;

  final Function() onAddEvent;

  const EventView(
      {super.key,
      required this.listOfEvents,
      required this.onEventSelected,
      required this.onOptionSelected,
      required this.language,
      required this.onAddEvent,
      required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleView(context),
          ListView.builder(
              itemCount: listOfEvents.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final MainEvent event = listOfEvents[index];
                final fromDateTime = DateTime.parse(event.dateFrom!);
                final toDateTime = DateTime.parse(event.dateTo!);
                final dayName = DateFormat('EEEE').format(fromDateTime);

                final difference = toDateTime.difference(fromDateTime).inMinutes;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => onEventSelected(event),
                    child: Container(
                      height: 430,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xff444444), width: 0.5),
                      ),
                      child: Expanded(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                  child: event.image != ""
                                      ? FadeInImage(
                                          placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                          image: NetworkImage(
                                            AppConstant.imagesBaseURLForEvents + event.image!,
                                            scale: 1,
                                          ),
                                        )
                                      : Image.asset(
                                          'assets/images/avatar.jpeg',
                                          fit: BoxFit.fill,
                                          height: 100,
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () => onOptionSelected(event),
                                    child: Container(
                                      width: 50,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.more_horiz,
                                          color: Color(0xff444444),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 4, left: 8, right: 8),
                              child: SizedBox(
                                height: 15,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      title: "${fromDateTime.year}/${fromDateTime.month}/${fromDateTime.day}",
                                      fontSize: 14,
                                      textAlign: TextAlign.center,
                                      textColor: const Color(0xff444444),
                                    ),
                                    CustomText(
                                      title: language == "en" ? dayName : DayTime().convertDayToArabic(dayName),
                                      fontSize: 14,
                                      textAlign: TextAlign.center,
                                      textColor: const Color(0xff444444),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 8, left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    title: DayTime()
                                        .convertingTimingWithMinToRealTime(fromDateTime.hour, fromDateTime.minute),
                                    fontSize: 14,
                                    textAlign: TextAlign.center,
                                    textColor: const Color(0xff444444),
                                  ),
                                  CustomText(
                                    title: "$difference ${AppLocalizations.of(context)!.min}",
                                    fontSize: 14,
                                    textAlign: TextAlign.center,
                                    textColor: const Color(0xff444444),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    title: event.title!,
                                    fontSize: 18,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.bold,
                                    maxLins: 3,
                                    textColor: const Color(0xff444444),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            CustomText(
                              title:
                                  "${event.joiningClients!} ${AppLocalizations.of(context)!.intrestedfrom} ${event.maxNumberOfAttendance}",
                              fontSize: 14,
                              textAlign: TextAlign.center,
                              textColor: const Color(0xff444444),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          borderRadius: BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: CustomText(
                                            title: event.price == 0
                                                ? "${AppLocalizations.of(context)!.registernow} ( ${AppLocalizations.of(context)!.free} )"
                                                : "${AppLocalizations.of(context)!.registernow} ( ${Currency().calculateHourRate(event.price!, Timing.hour)} )",
                                            fontSize: 16,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.bold,
                                            textColor: const Color(0xff444444),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    InkWell(
                                      onTap: () => onShare(event),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          borderRadius: BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        width: 40,
                                        child: const Center(
                                          child: Icon(Icons.share_sharp),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget titleView(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      color: Colors.grey[300],
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          CustomText(
            title: AppLocalizations.of(context)!.comingevent,
            fontSize: 16,
            textColor: const Color(0xff444444),
            fontWeight: FontWeight.bold,
          ),
          const Expanded(child: SizedBox()),
          IconButton(
              onPressed: () => onAddEvent(),
              icon: Container(
                color: Colors.white,
                child: const Icon(
                  Icons.add,
                  color: Color(0xff444444),
                ),
              ))
        ],
      ),
    );
  }
}
