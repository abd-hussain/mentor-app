import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/working_hour_request.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/screens/working_hours/widgets/edit_working_hour_bottomsheet.dart';
import 'package:mentor_app/screens/working_hours/widgets/info_working_hour_bottomsheet.dart';
import 'package:mentor_app/screens/working_hours/working_hours_bloc.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/loading_view.dart';
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
                          itemCount: bloc.listOfWorkingHourNotifier.value.length,
                          itemBuilder: (context, index) {
                            return item(
                              index: index,
                              workingHours: bloc.listOfWorkingHourNotifier.value[index].list,
                              dayName: bloc.listOfWorkingHourNotifier.value[index].dayName,
                            );
                          });
                    });
          }),
    );
  }

  Widget item({required List<CheckBox> workingHours, required String dayName, required int index}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    CustomText(
                      title: dayName,
                      fontSize: 13,
                      textColor: const Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                    IconButton(
                      onPressed: () {
                        EditWorkingHourBottomSheetsUtil().workingHour(
                          context: context,
                          dayname: dayName,
                          listOfWorkingHour: bloc.listOfWorkingHourNotifier.value[index].list,
                          onSave: (newList) async {
                            WorkingHoursRequest obj = WorkingHoursRequest(
                              dayName: dayName,
                              workingHours: newList,
                            );
                            bloc.updateWorkingHours(obj);
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xff444444),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 320,
                  child: GridView.builder(
                    itemCount: workingHours.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: workingHours[index].isEnable ? const Color(0xff4CB6EA) : Colors.grey[400],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: CustomText(
                            title: workingHours[index].value,
                            fontSize: 13,
                            textColor: workingHours[index].isEnable ? const Color(0xff444444) : const Color(0xffffffff),
                            fontWeight: workingHours[index].isEnable ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            color: const Color(0xff444444),
          )
        ],
      ),
    );
  }
}
