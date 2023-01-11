import 'package:intl/intl.dart';

class DayTime {
  String gettheCorrentImageDependOnCurrentTime() {
    final currentTime = DateTime.now();
    if (currentTime.hour > 8 && currentTime.hour < 20) {
      return "assets/images/days/sun.png";
    }
    return "assets/images/days/moon.png";
  }

  String dateFormatter(String dateAsString) {
    var parsedDate = DateTime.parse(dateAsString);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(parsedDate);
  }

  String convertingTimingToRealTime(int time) {
    if (time > 0 && time <= 9) {
      return "0$time:00 am";
    } else if (time > 9 && time <= 12) {
      return "$time:00 am";
    } else {
      return "${time - 12}:00 pm";
    }
  }

  String convertingTimingWithMinToRealTime(int hour, int min) {
    if (hour > 0 && hour <= 9) {
      return "0$hour:${_minFraction(min)} am";
    } else if (hour > 9 && hour <= 12) {
      return "$hour:${_minFraction(min)} am";
    } else {
      return "${hour - 12}:${_minFraction(min)} pm";
    }
  }

  String _minFraction(int min) {
    if (min >= 0 && min <= 9) {
      return "0$min";
    } else {
      return "$min";
    }
  }

  int getHourFromTimeString(String time) {
    if (time.contains("a.m")) {
      String result = time.replaceAll(" a.m", "");
      var parts = result.split(':');
      return int.parse(parts[0].trim());
    } else {
      String result = time.replaceAll(" p.m", "");
      var parts = result.split(':');
      return _getHourPm(int.parse(parts[0].trim()));
    }
  }

  int _getHourPm(int hour) {
    if (hour == 1) {
      return 13;
    } else if (hour == 2) {
      return 14;
    } else if (hour == 2) {
      return 14;
    } else if (hour == 3) {
      return 15;
    } else if (hour == 4) {
      return 16;
    } else if (hour == 5) {
      return 17;
    } else if (hour == 6) {
      return 18;
    } else if (hour == 7) {
      return 19;
    } else if (hour == 8) {
      return 20;
    } else if (hour == 9) {
      return 21;
    } else if (hour == 10) {
      return 22;
    } else if (hour == 11) {
      return 23;
    } else {
      return 0;
    }
  }

  int getMinFromTimeString(String time) {
    if (time.contains("a.m")) {
      String result = time.replaceAll(" a.m", "");
      var parts = result.split(':');
      return int.parse(parts.sublist(1).join(':').trim());
    } else {
      String result = time.replaceAll(" p.m", "");
      var parts = result.split(':');
      return int.parse(parts.sublist(1).join(':').trim());
    }
  }

  String convertDayToArabic(String dayName) {
    switch (dayName) {
      case "Saturday":
        return "السبت";
      case "Sunday":
        return "الاحد";
      case "Monday":
        return "الاثنين";
      case "Tuesday":
        return "الثلاثاء";
      case "Wednesday":
        return "الاربعاء";
      case "Thursday":
        return "الخميس";
      case "Friday":
        return "الجمعة";
      default:
        return "";
    }
  }
}
