import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/screens/invite_friends/invite_friends_bloc.dart';
import 'package:mentor_app/screens/invite_friends/widgets/list_of_contacts_widget.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/shimmers/shimmer_list.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({Key? key}) : super(key: key);

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  final _bloc = InviteFriendsBloc();

  @override
  void didChangeDependencies() {
    _bloc.fetchContacts();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<List<Contact>>(
            valueListenable: _bloc.contactsNotifier,
            builder: (context, snapshot, child) {
              if (_bloc.permissionDenied) {
                return Column(
                  children: [
                    const SizedBox(height: 50),
                    Center(
                      child: CustomText(
                        title: AppLocalizations.of(context)!.permision_denied,
                        fontSize: 20,
                        textColor: Colors.black,
                      ),
                    ),
                  ],
                );
              } else {
                return snapshot != []
                    ? ListOfContactsWidget(
                        contacts: snapshot,
                      )
                    : const ShimmerListView(
                        count: 15,
                      );
              }
            },
          ),
        ],
      ),
    );
  }
}
