import 'package:flutter/material.dart';
import 'package:mentor_app/utils/routes.dart';

class TabNavigator extends StatelessWidget {
  final String initialRoute;
  const TabNavigator({Key? key, required this.initialRoute}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => routes[settings.name]!,
        );
      },
    );
  }
}
