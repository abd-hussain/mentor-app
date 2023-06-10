import 'package:flutter/material.dart';
import 'package:mentor_app/screens/register_screen/register_bloc.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';

class RegisterFaze7Screen extends StatefulWidget {
  const RegisterFaze7Screen({super.key});

  @override
  State<RegisterFaze7Screen> createState() => _RegisterFaze7ScreenState();
}

class _RegisterFaze7ScreenState extends State<RegisterFaze7Screen> {
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
              pageCount: 7,
              pageTitle: "Setup Password",
              nextPageTitle: "You will be ready to go",
              enableNextButton: snapshot,
              nextPressed: () async {},
            );
          }),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFieldsForFaze7();
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
