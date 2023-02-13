enum AppointmentsState { active, mentorCancel, clientCancel, clientMiss, mentorMiss, completed }

class CalenderMeetings {
  final String firstName;
  final String lastName;
  final String profileImg;
  final String gender;
  final AppointmentsState state;
  final int clientId;
  final int meetingId;
  final DateTime fromTime;
  final DateTime toTime;

  const CalenderMeetings({
    required this.firstName,
    required this.lastName,
    required this.profileImg,
    required this.clientId,
    required this.meetingId,
    required this.fromTime,
    required this.toTime,
    required this.gender,
    required this.state,
  });
}
