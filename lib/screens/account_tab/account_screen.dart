import 'package:flutter/material.dart';
import 'package:mentor_app/screens/account_tab/account_bloc.dart';
import 'package:mentor_app/screens/account_tab/widgets/collection_list_option.dart';
import 'package:mentor_app/screens/account_tab/widgets/footer.dart';
import 'package:mentor_app/screens/account_tab/widgets/header.dart';
import 'package:mentor_app/screens/account_tab/widgets/title_view.dart';
import 'package:mentor_app/shared_widget/admob_banner.dart';
import 'package:mentor_app/utils/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final bloc = AccountBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Account init Called ...');
    bloc.readBiometricsInitValue();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleView(title: AppLocalizations.of(context)!.accountsettings),
                CollectionListOptionView(
                    listOfOptions: bloc.listOfAccountOptions(context),
                    containerHight: 560),
                TitleView(title: AppLocalizations.of(context)!.generalsettings),
                CollectionListOptionView(
                    listOfOptions: bloc.listOfSettingsOptions(context),
                    containerHight: 125),
                TitleView(title: AppLocalizations.of(context)!.reachouttous),
                CollectionListOptionView(
                    listOfOptions: bloc.listOfReachOutUsOptions(context),
                    containerHight: 125),
                TitleView(title: AppLocalizations.of(context)!.support),
                CollectionListOptionView(
                    listOfOptions: bloc.listOfSupportOptions(context),
                    containerHight: 200),
                const SizedBox(height: 8),
                const AddMobBanner(),
                const FooterView(),
                const SizedBox(height: 8),
              ],
            ),
          ),
        )
      ],
    );
  }
}
