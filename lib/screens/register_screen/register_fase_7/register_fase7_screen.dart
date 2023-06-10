import 'package:flutter/material.dart';
import 'package:mentor_app/screens/register_screen/register_fase_7/register_fase7_bloc.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';

class RegisterFaze7Screen extends StatefulWidget {
  const RegisterFaze7Screen({super.key});

  @override
  State<RegisterFaze7Screen> createState() => _RegisterFaze7ScreenState();
}

class _RegisterFaze7ScreenState extends State<RegisterFaze7Screen> {
  final bloc = Register7Bloc();

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
