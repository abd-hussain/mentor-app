import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/utils/routes.dart';

class HeaderHomePage extends StatefulWidget {
  const HeaderHomePage({Key? key}) : super(key: key);

  @override
  State<HeaderHomePage> createState() => _HeaderHomePageState();
}

class _HeaderHomePageState extends State<HeaderHomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(width: 8),
          const CustomText(
            title: "HelpEra",
            fontSize: 30,
            textColor: Color(0xff444444),
            fontWeight: FontWeight.bold,
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.notificationsScreen),
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xff034061),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}