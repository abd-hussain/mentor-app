import 'package:flutter/material.dart';
import 'package:mentor_app/screens/rate_per_hour/hour_rate_view.dart';
import 'package:mentor_app/screens/rate_per_hour/iban_view.dart';
import 'package:mentor_app/screens/rate_per_hour/rate_per_hour_bloc.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
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
      body: GestureDetector(
        onTap: () {
          // FocusScope.of(context).unfocus();
        },
        child: ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatusNotifier,
            builder: (context, snapshot, child) {
              return snapshot == LoadingStatus.inprogress
                  ? const LoadingView()
                  : SingleChildScrollView(
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 16, right: 16),
                          child: Column(
                            children: [
                              HourRateView(
                                controller: bloc.ratePerHourController,
                                onTapPlus: () => bloc.encreseRatePerHourBy1(),
                                onTapMinus: () => bloc.decreseRatePerHourBy1(),
                              ),
                              IbanView(
                                controller: bloc.ibanController,
                                onChange: (value) {
                                  bloc.validateFieldsForFaze5();
                                },
                              ),
                              const SizedBox(height: 8),
                              ValueListenableBuilder<bool>(
                                  valueListenable: bloc.enableSaveButton,
                                  builder: (context, snapshot, child) {
                                    return CustomButton(
                                        enableButton: snapshot,
                                        onTap: () {
                                          bloc
                                              .changeRateRequest()
                                              .whenComplete(() {
                                            Navigator.of(context).pop();
                                          });
                                        });
                                  }),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
            }),
      ),
    );
  }
}
