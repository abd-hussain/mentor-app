enum Type { event, meeting }

class CalenderMeetings {
  final String mentorPrefix;
  final String mentorFirstName;
  final String mentorLastName;
  final String categoryName;
  final Type type;
  final String? title;
  final String? profileImg;
  final String? eventImg;

  final int mentorId;
  final int meetingId;
  final DateTime fromTime;
  final DateTime toTime;
  const CalenderMeetings(
      {required this.mentorPrefix,
      required this.mentorFirstName,
      required this.mentorLastName,
      required this.categoryName,
      required this.mentorId,
      required this.meetingId,
      required this.fromTime,
      required this.toTime,
      required this.type,
      this.profileImg,
      this.eventImg,
      this.title});
}
