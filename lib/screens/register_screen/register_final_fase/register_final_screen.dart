import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mentor_app/screens/register_screen/register_final_fase/register_final_bloc.dart';

class RegisterFinalScreen extends StatefulWidget {
  const RegisterFinalScreen({super.key});

  @override
  State<RegisterFinalScreen> createState() => _RegisterFinalScreenState();
}

class _RegisterFinalScreenState extends State<RegisterFinalScreen> {
  final bloc = RegisterFinalBloc();

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
      body: LoadingIndicator(indicatorType: Indicator.audioEqualizer),
    );
  }
}
