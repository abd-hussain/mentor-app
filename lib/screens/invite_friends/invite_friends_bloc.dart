import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/https/contact_list_upload.dart';
import 'package:mentor_app/services/account_service.dart';
import 'package:mentor_app/services/settings_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class InviteFriendsBloc extends Bloc<SettingService> {
  ValueNotifier<String> invitationCodeNotifier = ValueNotifier<String>("");

  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future fetchContacts() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      uploadContactsListToServer(await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true));
    }
  }

  Future<void> uploadContactsListToServer(List<Contact> contatctList) async {
    var listOfContacts = UploadContact(list: []);

    for (var item in contatctList) {
      String contactName = item.displayName != ""
          ? item.displayName
          : ("${item.name.first} ${item.name.last}");
      String phoneNumber = item.phones.isNotEmpty ? item.phones[0].number : "";
      String email = item.emails.isNotEmpty ? item.emails[0].address : "";

      listOfContacts.list.add(
        MyContact(
          fullName: contactName,
          mobileNumber: phoneNumber.replaceAll(" ", ""),
          email: email,
          mentorownerid: box.get(DatabaseFieldConstant.userid),
        ),
      );
    }

    await service.uploadContactList(contacts: listOfContacts);
  }

  void getProfileInformations() async {
    locator<AccountService>().getProfileInfo().then((value) {
      final data = value.data;

      if (data != null) {
        invitationCodeNotifier.value = data.invitationCode ?? "";
      }
    });
  }

  @override
  onDispose() {
    invitationCodeNotifier.dispose();
  }
}
