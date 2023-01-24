import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/models/https/home_response.dart';
import 'package:mentor_app/services/event_services.dart';
import 'package:mentor_app/utils/constants/constant.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/day_time.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/mixins.dart';

class EventDetailsBloc extends Bloc<EventService> {
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  String? image = "";
  int? mentorId = 0;
  String? mentorProfileImage = "";
  String? mentorSuffixeName = "";
  String? mentorFirstName = "";
  String? mentorLastName = "";
  String? mentorCategoryName = "";
  double? eventPrice = 0;
  String? eventName = "";
  String? eventDate = "";
  String? eventDayName = "";
  String? eventHour = "";
  String? eventDuration = "";
  String? eventDescripton = "";
  int eventId = 0;
  int maxNumberOfAttendance = 0;
  int joiningClients = 0;

  bool isEventFree = false;

  final box = Hive.box(DatabaseBoxConstant.userInfo);

  void handleReadingArguments({required BuildContext context, required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      MainEvent event = newArguments["event_details"] as MainEvent;
      eventId = event.id!;
      eventName = event.title!;
      eventPrice = event.price!;
      image = AppConstant.imagesBaseURLForEvents + event.image!;

      final fromDateTime = DateTime.parse(event.dateFrom!);
      final toDateTime = DateTime.parse(event.dateTo!);
      eventDayName = DateFormat('EEEE').format(fromDateTime);
      final difference = toDateTime.difference(fromDateTime).inMinutes;
      eventDate = "${fromDateTime.year}/${fromDateTime.month}/${fromDateTime.day}";
      eventDuration = "$difference ${AppLocalizations.of(context)!.min}";
      eventHour = DayTime().convertingTimingWithMinToRealTime(fromDateTime.hour, fromDateTime.minute);
    }
  }

  void getEventDetails(BuildContext context) {
    loadingStatus.value = LoadingStatus.inprogress;
    service.getEventDetails(eventId: eventId).then((value) {
      if (value.data != null) {
        eventName = value.data!.title!;
        eventPrice = value.data!.price!;
        eventId = value.data!.id!;
        image = AppConstant.imagesBaseURLForEvents + value.data!.image!;
        final fromDateTime = DateTime.parse(value.data!.dateFrom!);
        final toDateTime = DateTime.parse(value.data!.dateTo!);
        eventDayName = DateFormat('EEEE').format(fromDateTime);
        final difference = toDateTime.difference(fromDateTime).inMinutes;
        eventDate = "${fromDateTime.year}/${fromDateTime.month}/${fromDateTime.day}";
        eventDuration = "$difference ${AppLocalizations.of(context)!.min}";
        eventHour = DayTime().convertingTimingWithMinToRealTime(fromDateTime.hour, fromDateTime.minute);
        eventDescripton = value.data!.description!;
        mentorCategoryName = value.data!.categoryName!;
        mentorProfileImage = value.data!.mentorProfileImg!;
        mentorSuffixeName = value.data!.mentorSuffixName!;
        mentorFirstName = value.data!.mentorFirstName!;
        mentorLastName = value.data!.mentorLastName!;
        mentorId = value.data!.mentorId!;
        joiningClients = value.data!.joiningClients!;
        maxNumberOfAttendance = value.data!.maxNumberOfAttendance!;

        loadingStatus.value = LoadingStatus.finish;
      }
    });
  }

  @override
  onDispose() {}
}
