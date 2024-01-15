import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/register_model.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/services/register_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/day_time.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/gender_format.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/version.dart';

class RegisterFinalBloc extends Bloc<RegisterService> {
  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<dynamic> handleCreatingTheProfile(BuildContext context) async {
    String? version = await Version().getApplicationVersion();
    int gender = 0;
    if (context.mounted) {
      gender = GenderFormat().convertStringToIndex(
          context, box.get(TempFieldToRegistrtConstant.gender));
    }

    List<WorkingHourUTCModel> workingHoursUTC = DayTime().prepareTimingToUTC(
      workingHoursSaturday:
          box.get(TempFieldToRegistrtConstant.saturdayWH) ?? [],
      workingHoursSunday: box.get(TempFieldToRegistrtConstant.sundayWH) ?? [],
      workingHoursMonday: box.get(TempFieldToRegistrtConstant.mondayWH) ?? [],
      workingHoursTuesday: box.get(TempFieldToRegistrtConstant.tuesdayWH) ?? [],
      workingHoursWednesday:
          box.get(TempFieldToRegistrtConstant.wednesdayWH) ?? [],
      workingHoursThursday:
          box.get(TempFieldToRegistrtConstant.thursdayWH) ?? [],
      workingHoursFriday: box.get(TempFieldToRegistrtConstant.fridayWH) ?? [],
    );

    final model = Register(
      appVersion: version,
      gender: gender,
      suffixeName: box.get(TempFieldToRegistrtConstant.suffix) ?? "",
      firstName: box.get(TempFieldToRegistrtConstant.firstName) ?? "",
      lastName: box.get(TempFieldToRegistrtConstant.lastName) ?? "",
      dateOfBirth: box.get(TempFieldToRegistrtConstant.dateOfBirth) ?? "",
      hourRate: box.get(TempFieldToRegistrtConstant.ratePerHour) ?? "",
      iban: box.get(TempFieldToRegistrtConstant.iban) ?? "",
      password: box.get(TempFieldToRegistrtConstant.password) ?? "",
      bio: box.get(TempFieldToRegistrtConstant.bio) ?? "",
      categoryId: box.get(TempFieldToRegistrtConstant.category) ?? "",
      countryId: box.get(TempFieldToRegistrtConstant.country) ?? "",
      email: box.get(TempFieldToRegistrtConstant.email) ?? "",
      mobileNumber: box.get(TempFieldToRegistrtConstant.phoneNumber) ?? "",
      referalCode: box.get(TempFieldToRegistrtConstant.referalCode) ?? "",
      speakingLanguage:
          box.get(TempFieldToRegistrtConstant.speakingLanguages) ?? [],
      profileImg: box.get(TempFieldToRegistrtConstant.profileImage),
      cv: box.get(TempFieldToRegistrtConstant.cv),
      idImg: box.get(TempFieldToRegistrtConstant.idImage),
      cert1: box.get(TempFieldToRegistrtConstant.certificates1),
      cert2: box.get(TempFieldToRegistrtConstant.certificates2),
      cert3: box.get(TempFieldToRegistrtConstant.certificates3),
      pushToken: box.get(DatabaseFieldConstant.pushNotificationToken),
      workingHoursSaturday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.saturday)
          .first
          .list,
      workingHoursSunday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.sunday)
          .first
          .list,
      workingHoursMonday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.monday)
          .first
          .list,
      workingHoursTuesday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.tuesday)
          .first
          .list,
      workingHoursWednesday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.wednesday)
          .first
          .list,
      workingHoursThursday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.thursday)
          .first
          .list,
      workingHoursFriday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.friday)
          .first
          .list,
      experienceSince:
          box.get(TempFieldToRegistrtConstant.experianceSince) ?? "",
      majors: box.get(TempFieldToRegistrtConstant.majors) ?? [],
    );

    return await service.callRegister(data: model);
  }

  Future<void> clearRegistrationData() async {
    await box.deleteAll([
      TempFieldToRegistrtConstant.gender,
      TempFieldToRegistrtConstant.suffix,
      TempFieldToRegistrtConstant.firstName,
      TempFieldToRegistrtConstant.lastName,
      TempFieldToRegistrtConstant.dateOfBirth,
      TempFieldToRegistrtConstant.ratePerHour,
      TempFieldToRegistrtConstant.iban,
      TempFieldToRegistrtConstant.password,
      TempFieldToRegistrtConstant.bio,
      TempFieldToRegistrtConstant.category,
      TempFieldToRegistrtConstant.country,
      TempFieldToRegistrtConstant.email,
      TempFieldToRegistrtConstant.phoneNumber,
      TempFieldToRegistrtConstant.referalCode,
      TempFieldToRegistrtConstant.speakingLanguages,
      TempFieldToRegistrtConstant.profileImage,
      TempFieldToRegistrtConstant.cv,
      TempFieldToRegistrtConstant.idImage,
      TempFieldToRegistrtConstant.certificates1,
      TempFieldToRegistrtConstant.certificates2,
      TempFieldToRegistrtConstant.certificates3,
      TempFieldToRegistrtConstant.saturdayWH,
      TempFieldToRegistrtConstant.sundayWH,
      TempFieldToRegistrtConstant.mondayWH,
      TempFieldToRegistrtConstant.tuesdayWH,
      TempFieldToRegistrtConstant.wednesdayWH,
      TempFieldToRegistrtConstant.thursdayWH,
      TempFieldToRegistrtConstant.fridayWH,
      TempFieldToRegistrtConstant.experianceSince,
      TempFieldToRegistrtConstant.majors,
      DatabaseFieldConstant.registrationStep
    ]);
  }

  @override
  onDispose() {
    loadingStatus.dispose();
  }
}
