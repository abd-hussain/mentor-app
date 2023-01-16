import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:mentor_app/models/working_hours.dart';
import 'package:mentor_app/screens/working_hours/widgets/edit_working_hour_bottomsheet.dart';
import 'package:mentor_app/screens/working_hours/working_hours_bloc.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
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
      appBar: customAppBar(title: AppLocalizations.of(context)!.workinghour),
      body: ListView.builder(
          itemCount: bloc.listOfWorkingHour.length,
          itemBuilder: (context, index) {
            return item(
              index: index,
              workingHours: bloc.listOfWorkingHour[index].list,
              dayName: bloc.listOfWorkingHour[index].dayName,
            );
          }),
    );
  }

  Widget item({required List<WorkingHour> workingHours, required String dayName, required int index}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  CustomText(
                    title: dayName,
                    fontSize: 16,
                    textColor: const Color(0xff444444),
                    fontWeight: FontWeight.bold,
                  ),
                  IconButton(
                      onPressed: () {
                        EditWorkingHourBottomSheetsUtil().workingHour(
                          context: context,
                          dayname: dayName,
                          listOfWorkingHour: bloc.listOfWorkingHour[index].list,
                          onSave: (newList) {
                            bloc.listOfWorkingHour[index].list = newList;
                            setState(() {});
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xff444444),
                      ))
                ],
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                height: 300,
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
