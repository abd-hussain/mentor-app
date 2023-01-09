import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/myApp.dart';
import 'package:mentor_app/services/filter_services.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class SetupBloc extends Bloc<FilterService> {
  final ValueNotifier<int> selectedLanguageNotifier = ValueNotifier<int>(0);
  final ValueNotifier<List<Country>> countriesListNotifier = ValueNotifier<List<Country>>([]);

  Future<void> getSystemLanguage(BuildContext context) async {
    var box = await Hive.openBox(DatabaseBoxConstant.userInfo);
    final String? savedLanguage = box.get(DatabaseFieldConstant.language);
    if (savedLanguage == null) {
      _setLanguageFromTheSystem(context: context, box: box);
    } else {
      _setLanguageFromTheSavedData(context: context, savedLanguage: savedLanguage);
    }
  }

  void _setLanguageFromTheSystem({required BuildContext context, required Box<dynamic> box}) {
    Locale activeLocale = Localizations.localeOf(context);

    selectedLanguageNotifier.value = 0;
    box.put(DatabaseFieldConstant.language, "en");
    if (activeLocale.languageCode == "ar") {
      box.put(DatabaseFieldConstant.language, "ar");
      selectedLanguageNotifier.value = 1;
    }
  }

  void _setLanguageFromTheSavedData({required BuildContext context, required String savedLanguage}) {
    if (savedLanguage == "ar") {
      selectedLanguageNotifier.value = 1;
      _refreshAppWithLanguageCode(context, 'ar');
    } else {
      selectedLanguageNotifier.value = 0;
      _refreshAppWithLanguageCode(context, 'en');
    }
  }

  void listOfCountries() {
    service.countries().then((value) {
      countriesListNotifier.value = value.data!..sort((a, b) => a.id!.compareTo(b.id!));
    });
  }

  Future<void> setLanguageInStorage(BuildContext context, int index) async {
    final box = await Hive.openBox(DatabaseBoxConstant.userInfo);

    if (index == 0) {
      _setLanguageToEnglish(context: context, box: box);
    } else {
      _setLanguageToArabic(context: context, box: box);
    }
    selectedLanguageNotifier.value = index;

    listOfCountries();
  }

  void _setLanguageToArabic({required BuildContext context, required Box<dynamic> box, String code = "ar"}) {
    box.put(DatabaseFieldConstant.language, code);
    _refreshAppWithLanguageCode(context, code);
  }

  void _setLanguageToEnglish({required BuildContext context, required Box<dynamic> box, String code = "en"}) {
    box.put(DatabaseFieldConstant.language, code);
    _refreshAppWithLanguageCode(context, code);
  }

  void _refreshAppWithLanguageCode(BuildContext context, String code) async {
    await Hive.box(DatabaseBoxConstant.userInfo).put(DatabaseFieldConstant.language, code == "en" ? "ar" : "en");
    MyApp.of(context)!.rebuild();
  }

  @override
  onDispose() {
    selectedLanguageNotifier.dispose();
    countriesListNotifier.dispose();
  }
}
