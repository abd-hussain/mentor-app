import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mentor_app/models/profile_options.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/utils/constants/constant.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/utils/routes.dart';

class AccountBloc extends Bloc<AccountService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  ValueNotifier<LoadingStatus> loadingStatus = ValueNotifier<LoadingStatus>(LoadingStatus.idle);

  List<ProfileOptions> listOfAccountOptions(BuildContext context) {
    return [
      ProfileOptions(
          icon: Icons.account_box,
          name: AppLocalizations.of(context)!.editprofileinformations,
          onTap: () {
            //TODO
          }
          // Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.editProfileScreen),
          ),
      ProfileOptions(
        icon: Icons.logout,
        name: AppLocalizations.of(context)!.logout,
        onTap: () {
          //TODO
          //_logoutView(context);
        },
      ),
      ProfileOptions(
        icon: Ionicons.bag_remove_outline,
        iconColor: Colors.red,
        name: AppLocalizations.of(context)!.deleteaccount,
        nameColor: Colors.red,
        onTap: () {
          //TODO
          //   _deleteAccountView(context);
        },
      ),
    ];
  }

  List<ProfileOptions> listOfSettingsOptions(BuildContext context) {
    return [
      ProfileOptions(
          icon: Icons.menu_book_rounded,
          name: AppLocalizations.of(context)!.usertutorials,
          onTap: () {
            //TODO
          }
          //=> Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.tutorialsScreen),
          ),
      ProfileOptions(
        icon: Icons.translate,
        name: AppLocalizations.of(context)!.language,
        selectedItem: box.get(DatabaseFieldConstant.language) == "en" ? "English" : "العربية",
        onTap: () {
          //TODO
          // _changeLanguage(context);
        },
      ),
    ];
  }

  List<ProfileOptions> listOfReachOutUsOptions(BuildContext context) {
    return [
      ProfileOptions(
          icon: Icons.bug_report,
          name: AppLocalizations.of(context)!.reportproblem,
          onTap: () {
            //TODO
          }
          // => Navigator.of(context, rootNavigator: true)
          //     .pushNamed(RoutesConstants.reportScreen, arguments: {AppConstant.argument1: ReportPageType.issue}),
          ),
      ProfileOptions(
          icon: Ionicons.balloon,
          name: AppLocalizations.of(context)!.reportsuggestion,
          onTap: () {
            //TODO
          }

          //  => Navigator.of(context, rootNavigator: true)
          //     .pushNamed(RoutesConstants.reportScreen, arguments: {AppConstant.argument1: ReportPageType.suggestion}),
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

  void _openAboutUs(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen, arguments: {
      AppConstant.webViewPageUrl: AppConstant.aboutusLink,
      AppConstant.pageTitle: AppLocalizations.of(context)!.aboutus
    });
  }

  void _openInviteFriends(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.inviteFriendScreen);
  }

  @override
  onDispose() {}
}
