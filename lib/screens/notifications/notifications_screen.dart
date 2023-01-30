import 'package:flutter/material.dart';
import 'package:mentor_app/screens/notifications/notifications_bloc.dart';
import 'package:mentor_app/screens/notifications/widgets/list_notification_widget.dart';
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
    bloc.markNotificationReaded();
    bloc.listOfNotifications();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: AppLocalizations.of(context)!.notifications),
      body: RefreshIndicator(
        onRefresh: bloc.pullRefresh,
        child: NotificationsList(
          notificationsListNotifier: bloc.notificationsListNotifier,
          onDelete: (p0) {
            bloc.notificationsListNotifier.value!.remove(p0);
            bloc.deleteNotification(p0.id!);
          },
        ),
      ),
    );
  }
}
