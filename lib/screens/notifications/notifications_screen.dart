import 'package:flutter/material.dart';
import 'package:mentor_app/screens/notifications/notifications_bloc.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/utils/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final bloc = NotificationsBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Notifications init Called ...');

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.notifications),
    );
  }
}
