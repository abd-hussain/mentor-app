import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/services/account_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class CallBloc extends Bloc<AccountService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  @override
  onDispose() {}
}
