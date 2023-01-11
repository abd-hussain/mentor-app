import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

PreferredSizeWidget customAppBar({required String title, List<Widget>? actions}) {
  return AppBar(
    backgroundColor: const Color(0xff034061),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomText(
          title: "HelpEra",
          fontSize: 30,
          textColor: Colors.white,
        ),
        CustomText(
          title: title,
          fontSize: 12,
          textColor: Colors.white,
        )
      ],
    ),
    actions: actions,
  );
}
