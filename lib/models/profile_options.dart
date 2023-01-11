import 'package:flutter/material.dart';

enum AccountButtonType {
  aboutUs,
  inviteFriends,
  reportSuggestion,
  reportProblem,
  notificationSetting,
  country,
  language,
  tutorials,
  shakeSetting,
  logout,
  loyality
}

class ProfileOptions {
  final IconData icon;
  final Color iconColor;
  final String name;
  final Color nameColor;
  final String selectedItem;
  final Widget? selectedItemImage;

  final VoidCallback onTap;

  ProfileOptions(
      {required this.icon,
      this.iconColor = const Color(0xff034061),
      required this.name,
      this.nameColor = const Color(0xff034061),
      this.selectedItem = "",
      this.selectedItemImage,
      required this.onTap});
}
