import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';

class Register5Bloc {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);
  validateFieldsForFaze5() {}
}
