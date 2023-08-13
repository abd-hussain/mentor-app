import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/home_response.dart';
import 'package:mentor_app/screens/home_tab/home_bloc.dart';
import 'package:mentor_app/screens/home_tab/widgets/header.dart';
import 'package:mentor_app/screens/home_tab/widgets/main_banner.dart';
import 'package:mentor_app/shared_widget/admob_banner.dart';
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
                          return const SizedBox();
                        }
                      }),
                  const AddMobBanner(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
