import 'package:flutter/material.dart';
import 'package:mentor_app/screens/register_screen/register_bloc.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';

class RegisterFaze3Screen extends StatefulWidget {
  const RegisterFaze3Screen({super.key});

  @override
  State<RegisterFaze3Screen> createState() => _RegisterFaze3ScreenState();
}

class _RegisterFaze3ScreenState extends State<RegisterFaze3Screen> {
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
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFieldsForFaze3();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
