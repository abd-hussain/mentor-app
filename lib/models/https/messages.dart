class MessagesList {
  List<MessagesListData>? data;
  String? message;

  MessagesList({this.data, this.message});

  MessagesList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MessagesListData>[];
      json['data'].forEach((v) {
        data!.add(MessagesListData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class MessagesListData {
  int? id;
  int? clientId;
  int? mentorId;
  String? firstName;
  String? lastName;
  String? profileImg;

  MessagesListData({this.id, this.clientId, this.mentorId, this.firstName, this.lastName, this.profileImg});

  MessagesListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    mentorId = json['mentor_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImg = json['profile_img'];
  }
}
