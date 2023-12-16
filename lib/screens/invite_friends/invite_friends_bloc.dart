import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/contact_list_upload.dart';
import 'package:mentor_app/services/settings_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class InviteFriendsBloc extends Bloc<SettingService> {
  bool permissionDenied = true;
  ValueNotifier<List<Contact>> contactsNotifier = ValueNotifier<List<Contact>>([]);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future fetchContacts() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      contactsNotifier.value = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      permissionDenied = false;
      uploadContactsListToServer();
    } else {
      contactsNotifier.value = [];
      permissionDenied = true;
    }
  }

  Future<void> uploadContactsListToServer() async {
    var listOfContacts = UploadContact(list: []);

    for (var item in contactsNotifier.value) {
      String contactName = item.displayName != "" ? item.displayName : ("${item.name.first} ${item.name.last}");
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

  @override
  onDispose() {
    contactsNotifier.dispose();
  }
}
