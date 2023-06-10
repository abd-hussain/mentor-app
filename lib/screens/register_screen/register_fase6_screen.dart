import 'package:flutter/material.dart';
import 'package:mentor_app/screens/register_screen/register_bloc.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';

class RegisterFaze6Screen extends StatefulWidget {
  const RegisterFaze6Screen({super.key});

  @override
  State<RegisterFaze6Screen> createState() => _RegisterFaze6ScreenState();
}

class _RegisterFaze6ScreenState extends State<RegisterFaze6Screen> {
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
              pageCount: 6,
              pageTitle: "Verify Email & Phone",
              nextPageTitle: "Setup Password",
              enableNextButton: snapshot,
              nextPressed: () async {},
            );
          }),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFieldsForFaze6();
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
