import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

class TitleView extends StatelessWidget {
  final String title;
  const TitleView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16),
      child: CustomText(
        title: title,
        fontSize: 14,
        textColor: const Color(0xff444444),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
