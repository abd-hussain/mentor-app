import 'package:flutter/material.dart';
import 'package:mentor_app/screens/register_screen/register_bloc.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';

class RegisterFaze4Screen extends StatefulWidget {
  const RegisterFaze4Screen({super.key});

  @override
  State<RegisterFaze4Screen> createState() => _RegisterFaze4ScreenState();
}

class _RegisterFaze4ScreenState extends State<RegisterFaze4Screen> {
  final bloc = RegisterBloc();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: ""),
      bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: bloc.enableNextBtn,
          builder: (context, snapshot, child) {
            return RegistrationFooterView(
              pageCount: 4,
              pageTitle: "Working Hours",
              nextPageTitle: "Rate Per Hour",
              enableNextButton: snapshot,
              nextPressed: () async {},
            );
          }),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFieldsForFaze4();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
