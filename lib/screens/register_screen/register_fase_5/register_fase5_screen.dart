import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/screens/register_screen/register_fase_5/register_fase5_bloc.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        bloc.validateFieldsForFaze5();
      },
      child: Scaffold(
        appBar: customAppBar(title: ""),
        bottomNavigationBar: ValueListenableBuilder<bool>(
            valueListenable: bloc.enableNextBtn,
            builder: (context, snapshot, child) {
              return RegistrationFooterView(
                pageCount: 5,
                pageTitle: AppLocalizations.of(context)!.rateperhourtitle,
                nextPageTitle: AppLocalizations.of(context)!.setuppassword,
                enableNextButton: snapshot,
                nextPressed: () async {
                  final navigator = Navigator.of(context);
                  await bloc.box.put(TempFieldToRegistrtConstant.ratePerHour,
                      bloc.ratePerHourController.text);
                  await bloc.box
                      .put(DatabaseFieldConstant.registrationStep, "6");
                  navigator.pushNamed(RoutesConstants.registerfaze6Screen);
                },
              );
            }),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            bloc.validateFieldsForFaze5();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      title: AppLocalizations.of(context)!.rateperhourdesc1,
                      fontSize: 14,
                      maxLins: 3,
                      textColor: const Color(0xff444444),
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      title: AppLocalizations.of(context)!.rateperhourdesc2,
                      fontSize: 14,
                      maxLins: 3,
                      textAlign: TextAlign.center,
                      textColor: const Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      title: AppLocalizations.of(context)!.rateperhourdesc3,
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      textColor: const Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(
                      title: "22 \$",
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      textColor: Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.grey[200],
                            child: IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => bloc.decreseRatePerHourBy1(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            controller: bloc.ratePerHourController,
                            hintText:
                                AppLocalizations.of(context)!.rateperhourtitle,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                            ],
                            fontSize: 18,
                            textAlign: TextAlign.center,
                            padding: const EdgeInsets.all(0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.grey[200],
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => bloc.encreseRatePerHourBy1(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
