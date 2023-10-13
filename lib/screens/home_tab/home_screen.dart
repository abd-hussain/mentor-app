import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/home_response.dart';
import 'package:mentor_app/models/https/notifications_response.dart';
import 'package:mentor_app/screens/home_tab/home_bloc.dart';
import 'package:mentor_app/screens/home_tab/widgets/announcements_view.dart';
import 'package:mentor_app/screens/home_tab/widgets/header.dart';
import 'package:mentor_app/screens/home_tab/widgets/main_banner.dart';
import 'package:mentor_app/screens/home_tab/widgets/shimmer_notifications.dart';
import 'package:mentor_app/shared_widget/admob_banner.dart';
import 'package:mentor_app/shared_widget/loading_view.dart';
import 'package:mentor_app/utils/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Home init Called ...');
    bloc.getHome();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          const HeaderHomePage(),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ValueListenableBuilder<List<MainBanner>?>(
                      valueListenable: bloc.bannerListNotifier,
                      builder: (context, snapshot, child) {
                        if (snapshot != null && snapshot.isNotEmpty) {
                          return MainBannerHomePage(bannerList: snapshot);
                        } else {
                          return const SizedBox(height: 250, child: LoadingView());
                        }
                      }),
                  const AddMobBanner(),
                  FutureBuilder<List<NotificationsResponseData>?>(
                      initialData: null,
                      future: bloc.listOfNotifications(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null && snapshot.hasData) {
                          return const SizedBox(height: 300, child: ShimmerNotificationsView());
                        } else {
                          return SizedBox(
                            height: double.maxFinite,
                            child: AnnouncementsView(notificationsList: snapshot.data ?? []),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
