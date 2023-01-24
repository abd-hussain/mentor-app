import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/home_response.dart';
import 'package:mentor_app/screens/home_tab/home_bloc.dart';
import 'package:mentor_app/screens/home_tab/widgets/event_bottom_sheet.dart';
import 'package:mentor_app/screens/home_tab/widgets/event_view.dart';
import 'package:mentor_app/screens/home_tab/widgets/header.dart';
import 'package:mentor_app/screens/home_tab/widgets/main_banner.dart';
import 'package:mentor_app/screens/home_tab/widgets/stories.dart';
import 'package:mentor_app/shared_widget/admob_banner.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/logger.dart';
import 'package:mentor_app/utils/routes.dart';

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
                          return MainBannerHomePage(
                            bannerList: snapshot,
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<List<MainStory>?>(
                      valueListenable: bloc.storiesListNotifier,
                      builder: (context, snapshot, child) {
                        if (snapshot != null && snapshot.isNotEmpty) {
                          return StoriesHomePage(
                            listOfStories: snapshot,
                            reportStory: (id) {
                              bloc.reportStory(storyId: id);
                            },
                            openMentorProfile: (id) {
                              //TODO
                              // Navigator.of(context, rootNavigator: true)
                              //     .pushNamed(RoutesConstants.mentorProfileScreen, arguments: {"id": id});
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                  const AddMobBanner(),
                  ValueListenableBuilder<List<MainEvent>?>(
                      valueListenable: bloc.eventListNotifier,
                      builder: (context, snapshot, child) {
                        if (snapshot != null && snapshot.isNotEmpty) {
                          return EventView(
                            language: bloc.box.get(DatabaseFieldConstant.language),
                            listOfEvents: snapshot,
                            onEventSelected: (event) {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(RoutesConstants.eventDetailsScreen, arguments: {"event_details": event});
                            },
                            onOptionSelected: (event) {
                              EventOptionBookingBottomSheetsUtil(
                                      context: context, language: bloc.box.get(DatabaseFieldConstant.language))
                                  .bookMeetingBottomSheet(report: () {
                                bloc.reportEvent(eventId: event.id!);
                              });
                            },
                            onAddEvent: () {
                              //TODO
                            },
                            onShare: (event) {
                              //TODO
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                  const SizedBox(height: 20),
                  const AddMobBanner(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
