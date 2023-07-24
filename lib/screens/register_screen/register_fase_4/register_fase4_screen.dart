import 'package:flutter/material.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/screens/register_screen/register_fase_4/register_fase4_bloc.dart';
import 'package:mentor_app/screens/register_screen/widgets/footer_view.dart';
import 'package:mentor_app/screens/working_hours/widgets/edit_working_hour_bottomsheet.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/working_hours.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterFaze4Screen extends StatefulWidget {
  const RegisterFaze4Screen({super.key});

  @override
  State<RegisterFaze4Screen> createState() => _RegisterFaze4ScreenState();
}

class _RegisterFaze4ScreenState extends State<RegisterFaze4Screen> {
  final bloc = Register4Bloc();

  @override
  void didChangeDependencies() {
    bloc.fillListOfWorkingHourNotifier(context);

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
              pageCount: 4,
              pageTitle: AppLocalizations.of(context)!.workinghour,
              nextPageTitle: AppLocalizations.of(context)!.rateperhourtitle,
              enableNextButton: snapshot,
              nextPressed: () async {
                final navigator = Navigator.of(context);
                await bloc.box
                    .put(TempFieldToRegistrtConstant.workingHours, bloc.listOfWorkingHourNotifier.value.toString());
                await bloc.box.put(DatabaseFieldConstant.registrationStep, "4");
                navigator.pushNamed(RoutesConstants.registerfaze5Screen);
              },
            );
          }),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFieldsForFaze4();
        },
        child: ValueListenableBuilder<List<WorkingHourModel>>(
            valueListenable: bloc.listOfWorkingHourNotifier,
            builder: (context, snapshot, child) {
              return ListView.builder(
                  itemCount: bloc.listOfWorkingHourNotifier.value.length,
                  itemBuilder: (context, index) {
                    return WorkingHoursWidget(
                      workingHours: bloc.listOfWorkingHourNotifier.value[index].list,
                      dayName: bloc.listOfWorkingHourNotifier.value[index].dayName,
                      onSave: () {
                        EditWorkingHourBottomSheetsUtil().workingHour(
                          context: context,
                          dayname: bloc.listOfWorkingHourNotifier.value[index].dayName,
                          listOfWorkingHour: bloc.listOfWorkingHourNotifier.value[index].list,
                          onSave: (newList) {
                            bloc.listOfWorkingHourNotifier.value[index] = WorkingHourModel(
                                list: bloc.prepareList(context, newList),
                                dayName: bloc.listOfWorkingHourNotifier.value[index].dayName);

                            bloc.validateFieldsForFaze4();
                            setState(() {});
                          },
                        );
                      },
                    );
                  });
            }),
      ),
    );
  }
}
