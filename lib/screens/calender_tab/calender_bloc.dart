import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/services/account_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalenderBloc extends Bloc<AccountService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<dynamic> cancelMeeting(int meetingId) async {
    //TODO
    // return locator<AppointmentsService>().cancelAppointment(id: meetingId);
  }

  @override
  onDispose() {}
}
