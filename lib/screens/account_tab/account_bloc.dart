import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mentor_app/models/profile_options.dart';
import 'package:mentor_app/myApp.dart';
import 'package:mentor_app/screens/report/report_screen.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/shared_widget/bottom_sheet_util.dart';
import 'package:mentor_app/shared_widget/custom_switch.dart';
import 'package:mentor_app/utils/constants/constant.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/utils/routes.dart';

class AccountBloc extends Bloc<AccountService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  ValueNotifier<bool> toggleOfBiometrics = ValueNotifier<bool>(false);

  List<ProfileOptions> listOfAccountOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.account_box,
        name: AppLocalizations.of(context)!.editprofileinformations,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.editProfileScreen),
      ),
      ProfileOptions(
        icon: Icons.explore,
        name: AppLocalizations.of(context)!.editprofileeinexperiances,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.editExperienceScreen),
      ),
      ProfileOptions(
        icon: Icons.password,
        name: AppLocalizations.of(context)!.editprofilepassword,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.changePasswordScreen),
      ),
      ProfileOptions(
          icon: Ionicons.finger_print,
          name: AppLocalizations.of(context)!.biometrics,
          selectedItemImage: ValueListenableBuilder<bool>(
            valueListenable: toggleOfBiometrics,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return CustomSwitch(
                  value: toggleOfBiometrics.value,
                  language: box.get(DatabaseFieldConstant.language),
                  backgroundColorOfSelection:
                      toggleOfBiometrics.value ? const Color(0xff34C759) : const Color(0xffE74C4C),
                  onChanged: (_) async {
                    await box.put(DatabaseFieldConstant.biometricStatus, (!toggleOfBiometrics.value).toString());
                    toggleOfBiometrics.value = !toggleOfBiometrics.value;
                  });
            },
          ),
          onTap: () {}),
      ProfileOptions(
        icon: Icons.logout,
        name: AppLocalizations.of(context)!.logout,
        onTap: () => _logoutView(context),
      ),
      ProfileOptions(
        icon: Ionicons.bag_remove_outline,
        iconColor: Colors.red,
        name: AppLocalizations.of(context)!.deleteaccount,
        nameColor: Colors.red,
        onTap: () => _deleteAccountView(context),
      ),
    ];
  }

  List<ProfileOptions> listOfSettingsOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.translate,
        name: AppLocalizations.of(context)!.language,
        selectedItem: box.get(DatabaseFieldConstant.language) == "en" ? "English" : "العربية",
        onTap: () => _changeLanguage(context),
      ),
      ProfileOptions(
        icon: Icons.menu_book_rounded,
        name: AppLocalizations.of(context)!.usertutorials,
        onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.tutorialsScreen),
      ),
    ];
  }

  List<ProfileOptions> listOfReachOutUsOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.bug_report,
        name: AppLocalizations.of(context)!.reportproblem,
        onTap: () => Navigator.of(context, rootNavigator: true)
            .pushNamed(RoutesConstants.reportScreen, arguments: {AppConstant.argument1: ReportPageType.issue}),
      ),
      ProfileOptions(
        icon: Ionicons.balloon,
        name: AppLocalizations.of(context)!.reportsuggestion,
        onTap: () => Navigator.of(context, rootNavigator: true)
            .pushNamed(RoutesConstants.reportScreen, arguments: {AppConstant.argument1: ReportPageType.suggestion}),
      ),
    ];
  }

  List<ProfileOptions> listOfSupportOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Ionicons.color_palette,
        name: AppLocalizations.of(context)!.aboutus,
        onTap: () => _openAboutUs(context),
      ),
      ProfileOptions(
        icon: Ionicons.person_add,
        name: AppLocalizations.of(context)!.invite_friends,
        onTap: () => _openInviteFriends(context),
      ),
    ];
  }

  void _deleteAccountView(BuildContext context) {
    var nav = Navigator.of(context, rootNavigator: true);

    BottomSheetsUtil().areYouShoureButtomSheet(
        context: context,
        message: AppLocalizations.of(context)!.areyousuredeleteaccount,
        sure: () async {
          BottomSheetsUtil().areYouShoureButtomSheet(
              context: context,
              message: AppLocalizations.of(context)!.accountInformationwillbedeleted,
              sure: () async {
                service.removeAccount().whenComplete(() async {
                  final box = await Hive.openBox(DatabaseBoxConstant.userInfo);
                  box.deleteAll([
                    DatabaseFieldConstant.apikey,
                    DatabaseFieldConstant.token,
                    DatabaseFieldConstant.language,
                    DatabaseFieldConstant.userid,
                    DatabaseFieldConstant.countryId,
                    DatabaseFieldConstant.countryFlag,
                    DatabaseFieldConstant.isUserLoggedIn,
                    DatabaseFieldConstant.userFirstName,
                  ]);

                  await nav.pushNamedAndRemoveUntil(RoutesConstants.initialRoute, (Route<dynamic> route) => true);
                });
              });
        });
  }

  void _logoutView(BuildContext context) {
    var nav = Navigator.of(context, rootNavigator: true);
    BottomSheetsUtil().areYouShoureButtomSheet(
        context: context,
        message: AppLocalizations.of(context)!.areyousurelogout,
        sure: () async {
          final box = await Hive.openBox(DatabaseBoxConstant.userInfo);
          box.deleteAll([
            DatabaseFieldConstant.apikey,
            DatabaseFieldConstant.token,
            DatabaseFieldConstant.language,
            DatabaseFieldConstant.userid,
            DatabaseFieldConstant.countryId,
            DatabaseFieldConstant.countryFlag,
            DatabaseFieldConstant.isUserLoggedIn,
            DatabaseFieldConstant.userFirstName,
          ]);

          await nav.pushNamedAndRemoveUntil(RoutesConstants.initialRoute, (Route<dynamic> route) => true);
        });
  }

  void _openAboutUs(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen, arguments: {
      AppConstant.webViewPageUrl: AppConstant.aboutusLink,
      AppConstant.pageTitle: AppLocalizations.of(context)!.aboutus
    });
  }

  void _openInviteFriends(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.inviteFriendScreen);
  }

  void _changeLanguage(BuildContext context) async {
    await BottomSheetsUtil().areYouShoureButtomSheet(
        context: context,
        message: AppLocalizations.of(context)!.changelanguagemessage,
        sure: () {
          if (box.get(DatabaseFieldConstant.language) == "en") {
            box.put(DatabaseFieldConstant.language, "ar");
            _refreshAppWithLanguageCode(context);
          } else {
            box.put(DatabaseFieldConstant.language, "en");
            _refreshAppWithLanguageCode(context);
          }
        });
  }

  void _refreshAppWithLanguageCode(BuildContext context) async {
    MyApp.of(context)!.rebuild();
  }

  readBiometricsInitValue() {
    toggleOfBiometrics.value = box.get(DatabaseFieldConstant.biometricStatus) == "true";
  }

  @override
  onDispose() {}
}
