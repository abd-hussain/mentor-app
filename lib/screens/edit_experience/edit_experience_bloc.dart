import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class EditExperienceBloc extends Bloc<AccountService> {
  bool enableSaveButton = false;
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  @override
  onDispose() {}
}
