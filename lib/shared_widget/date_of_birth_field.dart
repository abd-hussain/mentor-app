import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';

class DateOfBirthField extends StatelessWidget {
  final String? selectedDate;
  final Function(String) dateSelected;

  final String language;
  const DateOfBirthField({required this.selectedDate, required this.language, required this.dateSelected, super.key});

  @override
  Widget build(BuildContext context) {
    late DateTime date;
    if (selectedDate != null) {
      print(selectedDate);
      date = DateFormat('dd/MM/yyyy').parse(selectedDate!);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: DatePickerWidget(
        firstDate: DateTime(1945, 01, 01),
        lastDate: DateTime(DateTime.now().year - 10, 1, 1),
        initialDate: date,
        dateFormat: "yyyy/MM/dd",
        locale: DatePicker.localeFromString(language),
        onChange: (DateTime newDate, _) {
          dateSelected(DateFormat("dd/MM/yyyy").format(newDate));
        },
        pickerTheme: const DateTimePickerTheme(
          itemTextStyle: TextStyle(color: Color(0xff384048), fontSize: 15),
        ),
      ),
    );
  }
}
