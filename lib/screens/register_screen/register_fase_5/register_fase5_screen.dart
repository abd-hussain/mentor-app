import 'package:flutter/material.dart';
import 'package:mentor_app/screens/register_screen/register_fase_5/register_fase5_bloc.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';

class RegisterFaze5Screen extends StatefulWidget {
  const RegisterFaze5Screen({super.key});

  @override
  State<RegisterFaze5Screen> createState() => _RegisterFaze5ScreenState();
}

class _RegisterFaze5ScreenState extends State<RegisterFaze5Screen> {
  final bloc = Register5Bloc();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //TODO we are here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: ""),
      bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: bloc.enableNextBtn,
          builder: (context, snapshot, child) {
            return RegistrationFooterView(
              pageCount: 5,
              pageTitle: "Rate Per Hour",
              nextPageTitle: "Verify Email & Phone",
              enableNextButton: snapshot,
              nextPressed: () async {},
            );
          }),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFieldsForFaze5();
        },
        child: const SafeArea(
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
