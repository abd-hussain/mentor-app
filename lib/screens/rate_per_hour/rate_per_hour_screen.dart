import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/screens/rate_per_hour/rate_per_hour_bloc.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:mentor_app/shared_widget/loading_view.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RatePerHourScreen extends StatefulWidget {
  const RatePerHourScreen({super.key});

  @override
  State<RatePerHourScreen> createState() => _RatePerHourScreenState();
}

class _RatePerHourScreenState extends State<RatePerHourScreen> {
  final bloc = RatePerHourBloc();

  @override
  void didChangeDependencies() {
    bloc.getHourPerRate();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F5),
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        title: AppLocalizations.of(context)!.rateperhour,
      ),
      body: ValueListenableBuilder<LoadingStatus>(
          valueListenable: bloc.loadingStatusNotifier,
          builder: (context, snapshot, child) {
            return snapshot == LoadingStatus.inprogress
                ? const LoadingView()
                : Padding(
                    padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 5,
                                offset: const Offset(0, 0.1),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                CustomText(
                                  title: AppLocalizations.of(context)!.rateperhourdesc1,
                                  fontSize: 14,
                                  maxLins: 3,
                                  textColor: const Color(0xff444444),
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(height: 20),
                                CustomText(
                                  title: AppLocalizations.of(context)!.rateperhourdesc2,
                                  fontSize: 14,
                                  maxLins: 3,
                                  textAlign: TextAlign.center,
                                  textColor: const Color(0xff444444),
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(height: 20),
                                CustomText(
                                  title: AppLocalizations.of(context)!.rateperhourdesc3,
                                  fontSize: 14,
                                  textAlign: TextAlign.center,
                                  textColor: const Color(0xff444444),
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(height: 20),
                                CustomText(
                                  title: "${bloc.recumendedRatePerHour} \$",
                                  fontSize: 16,
                                  textAlign: TextAlign.center,
                                  textColor: const Color(0xff444444),
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(height: 16),
                                Row(
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
                                      flex: 3,
                                      child: CustomTextField(
                                        controller: bloc.ratePerHourController,
                                        hintText: AppLocalizations.of(context)!.rateperhour,
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.5,
                                  blurRadius: 5,
                                  offset: const Offset(0, 0.1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CustomText(
                                    title: AppLocalizations.of(context)!.ibaninfo,
                                    fontSize: 14,
                                    textAlign: TextAlign.center,
                                    textColor: const Color(0xff444444),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(height: 8),
                                  CustomTextField(
                                    controller: bloc.ibanController,
                                    padding: const EdgeInsets.only(left: 8, right: 8),
                                    hintText: "",
                                    fontSize: 20,
                                    keyboardType: TextInputType.name,
                                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                                    onChange: (text) => bloc.validateFieldsForFaze5(),
                                    onEditingComplete: () => FocusManager.instance.primaryFocus?.unfocus(),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        ValueListenableBuilder<bool>(
                            valueListenable: bloc.enableSaveButton,
                            builder: (context, snapshot, child) {
                              return CustomButton(
                                  enableButton: snapshot,
                                  onTap: () {
                                    bloc.changeRateRequest().whenComplete(() {
                                      Navigator.of(context).pop();
                                    });
                                  });
                            }),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  );
          }),
    );
  }
}
