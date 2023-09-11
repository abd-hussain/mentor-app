import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/working_hour_request.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/screens/working_hours/widgets/edit_working_hour_bottomsheet.dart';
import 'package:mentor_app/screens/working_hours/widgets/info_working_hour_bottomsheet.dart';
import 'package:mentor_app/screens/working_hours/working_hours_bloc.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/loading_view.dart';
import 'package:mentor_app/shared_widget/working_hours.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkingHoursScreen extends StatefulWidget {
  const WorkingHoursScreen({super.key});

  @override
  State<WorkingHoursScreen> createState() => _WorkingHoursScreenState();
}

class _WorkingHoursScreenState extends State<WorkingHoursScreen> {
  final bloc = WorkingHoursBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Working Hours init Called ...');
    bloc.getWorkingHours();
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
        title: AppLocalizations.of(context)!.workinghour,
        actions: [
          IconButton(
            onPressed: () => InfoWorkingHourBottomSheetsUtil().info(context),
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: ValueListenableBuilder<LoadingStatus>(
          valueListenable: bloc.loadingStatusNotifier,
          builder: (context, snapshot, child) {
            return snapshot == LoadingStatus.inprogress
                ? const LoadingView()
                : ValueListenableBuilder<List<WorkingHourModel>>(
                    valueListenable: bloc.listOfWorkingHourNotifier,
                    builder: (context, snapshot, child) {
                      return ListView.builder(
                          itemCount:
                              bloc.listOfWorkingHourNotifier.value.length,
                          itemBuilder: (context, index) {
                            return WorkingHoursWidget(
                              workingHours: bloc
                                  .listOfWorkingHourNotifier.value[index].list,
                              dayName: bloc.listOfWorkingHourNotifier
                                  .value[index].dayName,
                              onSave: () {
                                EditWorkingHourBottomSheetsUtil().workingHour(
                                  context: context,
                                  dayname: bloc.listOfWorkingHourNotifier
                                      .value[index].dayName,
                                  listOfWorkingHour: bloc
                                      .listOfWorkingHourNotifier
                                      .value[index]
                                      .list,
                                  onSave: (newList) async {
                                    WorkingHoursRequest obj =
                                        WorkingHoursRequest(
                                      dayName: bloc.listOfWorkingHourNotifier
                                          .value[index].dayName,
                                      workingHours: newList,
                                    );
                                    bloc.updateWorkingHours(obj);
                                  },
                                );
                              },
                            );
                          });
                    });
          }),
    );
  }
}
