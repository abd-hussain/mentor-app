import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/screens/invite_friends/invite_friends_bloc.dart';
import 'package:mentor_app/screens/invite_friends/widgets/client_share_view.dart';
import 'package:mentor_app/screens/invite_friends/widgets/mentor_share_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  final _bloc = InviteFriendsBloc();

  @override
  void didChangeDependencies() {
    _bloc.fetchContacts();
    _bloc.getProfileInformations();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.invite_friends),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ValueListenableBuilder<String>(
                valueListenable: _bloc.invitationCodeNotifier,
                builder: (context, snapshot, child) {
                  return Column(
                    children: [
                      MentorShareView(invitationCode: snapshot),
                      const SizedBox(height: 10),
                      ClientShareView(invitationCode: snapshot),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
