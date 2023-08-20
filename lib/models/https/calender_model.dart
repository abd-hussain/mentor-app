enum AppointmentsState { active, mentorCancel, clientCancel, clientMiss, mentorMiss, completed }

class CalenderMeetings {
  final String firstName;
  final String lastName;
  final String profileImg;
  final String gender;
  final String dateOfBirth;
  final int countryId;
  final String countryFlag;

  final AppointmentsState state;
  final int appointmentType;
  final int clientId;
  final int meetingId;
  final DateTime fromTime;
  final DateTime toTime;
  final double priceBefore;
  final double priceAfter;
  final String clientnote;
  final String mentornote;

  const CalenderMeetings({
    required this.dateOfBirth,
    required this.countryId,
    required this.countryFlag,
    required this.priceBefore,
    required this.priceAfter,
    required this.firstName,
    required this.lastName,
    required this.profileImg,
    required this.clientId,
    required this.meetingId,
    required this.fromTime,
    required this.toTime,
    required this.gender,
    required this.state,
    required this.appointmentType,
    required this.clientnote,
    required this.mentornote,
  });
}
