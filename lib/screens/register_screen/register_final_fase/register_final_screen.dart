import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mentor_app/screens/register_screen/register_final_fase/register_final_bloc.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/animation_lm3q2kl2.zip',
                width: MediaQuery.of(context).size.width - 16),
            CustomText(
              title: AppLocalizations.of(context)!.createprofile,
              fontSize: 22,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              title: AppLocalizations.of(context)!.createprofiledesc,
              fontSize: 16,
              textColor: const Color(0xff444444),
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                bloc.handleCreatingTheProfile(context);
              },
              child: Text("Submit Profile"),
            )
          ],
        ),
      ),
    );
  }
}
