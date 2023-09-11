import 'package:flutter/material.dart';
import 'package:mentor_app/screens/setup_screen/setup_bloc.dart';
import 'package:mentor_app/screens/setup_screen/widgets/change_language_widget.dart';
import 'package:mentor_app/screens/setup_screen/widgets/list_of_countries_widget.dart';
import 'package:mentor_app/screens/setup_screen/widgets/title_table_widget.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _bloc = SetupBloc();

  @override
  void didChangeDependencies() {
    _bloc.getSystemLanguage(context).whenComplete(() {
      _bloc.listOfCountries();
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<int>(
                valueListenable: _bloc.selectedLanguageNotifier,
                builder: (context, snapshot, child) {
                  return ChangeLanguageWidget(
                    selectionIndex: snapshot,
                    segmentChange: (index) async =>
                        await _bloc.setLanguageInStorage(context, index),
                  );
                }),
            const TitleTableWidget(),
            ListOfCountriesWidget(
                countriesListNotifier: _bloc.countriesListNotifier),
          ],
        ),
      ),
    );
  }
}
