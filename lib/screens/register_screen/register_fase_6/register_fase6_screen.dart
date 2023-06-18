import 'package:flutter/material.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/register_fase6_bloc.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/fields_fase_1.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/fields_fase_2.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/fields_fase_3.dart';
import 'package:mentor_app/screens/register_screen/register_fase_6/widgets/fields_fase_4.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/routes.dart';

class RegisterFaze6Screen extends StatefulWidget {
  const RegisterFaze6Screen({super.key});

  @override
  State<RegisterFaze6Screen> createState() => _RegisterFaze6ScreenState();
}

class _RegisterFaze6ScreenState extends State<RegisterFaze6Screen> {
  final bloc = Register6Bloc();

  @override
  void didChangeDependencies() {
    bloc.listOfCountries();
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
              enableNextButton: true, //snapshot,
              nextPressed: () async {
                final navigator = Navigator.of(context);
                // await bloc.box.put(TempFieldToRegistrtConstant.ratePerHour, bloc.ratePerHourController.text);
                await bloc.box.put(DatabaseFieldConstant.registrationStep, "6");
                navigator.pushNamed(RoutesConstants.registerfaze7Screen);
              },
            );
          }),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFieldsForFaze6();
        },
        child: SafeArea(
          child: ValueListenableBuilder<LoadingStatus>(
              valueListenable: bloc.loadingStatus,
              builder: (context, loadingStatus, child) {
                if (loadingStatus == LoadingStatus.inprogress) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return SingleChildScrollView(
                    child: ValueListenableBuilder<FieldCanShow>(
                        valueListenable: bloc.fieldShowingStatus,
                        builder: (context, fieldShowingStatus, child) {
                          return Column(
                            children: [
                              FieldsFase1(bloc: bloc),
                              FieldsFase2(bloc: bloc, fieldShowingStatus: fieldShowingStatus),
                              FieldsFase3(bloc: bloc, fieldShowingStatus: fieldShowingStatus),
                              fieldShowingStatus == FieldCanShow.phoneNumberOTP ? FieldsFase4(bloc: bloc) : Container(),
                            ],
                          );
                        }),
                  );
                }
              }),
        ),
      ),
    );
  }
}
