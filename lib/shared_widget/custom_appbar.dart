import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

PreferredSizeWidget customAppBar({required String title, List<Widget>? actions}) {
  return AppBar(
    backgroundColor: const Color(0xff034061),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          title: title,
          fontSize: 14,
          textColor: Colors.white,
        )
      ],
    ),
    actions: actions,
  );
}
