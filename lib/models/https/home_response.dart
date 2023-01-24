class HomeResponse {
  HomeResponseData? data;
  String? message;

  HomeResponse({this.data, this.message});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? HomeResponseData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class HomeResponseData {
  List<MainBanner>? mainBanner;
  List<MainStory>? mainStory;
  List<MainEvent>? mainEvent;

  HomeResponseData({this.mainBanner, this.mainStory, this.mainEvent});

  HomeResponseData.fromJson(Map<String, dynamic> json) {
    if (json['main_banner'] != null) {
      mainBanner = <MainBanner>[];
      json['main_banner'].forEach((v) {
        mainBanner!.add(MainBanner.fromJson(v));
      });
    }
    if (json['main_story'] != null) {
      mainStory = <MainStory>[];
      json['main_story'].forEach((v) {
        mainStory!.add(MainStory.fromJson(v));
      });
    }
    if (json['main_event'] != null) {
      mainEvent = <MainEvent>[];
      json['main_event'].forEach((v) {
        mainEvent!.add(MainEvent.fromJson(v));
      });
    }
  }
}

class EventRespose {
  List<MainEvent>? data;
  String? message;

  EventRespose({this.data, this.message});

  EventRespose.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MainEvent>[];
      json['data'].forEach((v) {
        data!.add(MainEvent.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class MainEvent {
  int? id;
  String? title;
  String? image;
  String? description;
  int? joiningClients;
  int? maxNumberOfAttendance;
  String? dateFrom;
  String? dateTo;
  double? price;
  int? state;

  MainEvent({
    this.id,
    this.title,
    this.image,
    this.description,
    this.joiningClients,
    this.maxNumberOfAttendance,
    this.dateFrom,
    this.dateTo,
    this.price,
    this.state,
  });

  MainEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    joiningClients = json['joining_clients'];
    maxNumberOfAttendance = json['max_number_of_attendance'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    price = json['price'];
    state = json['state'];
  }
}

class MainBanner {
  String? image;
  String? actionType;

  MainBanner({this.image, this.actionType});

  MainBanner.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    actionType = json['action_type'];
  }
}

class StoryRespose {
  List<MainStory>? data;
  String? message;

  StoryRespose({this.data, this.message});

  StoryRespose.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MainStory>[];
      json['data'].forEach((v) {
        data!.add(MainStory.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class MainStory {
  int? id;
  String? assets;
  Owner? owner;

  MainStory({this.id, this.assets, this.owner});

  MainStory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assets = json['assets'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }
}

class Owner {
  int? id;
  String? firstName;
  String? lastName;
  int? gender;
  bool? blocked;
  String? profileImg;
  int? countryId;

  Owner({this.id, this.firstName, this.lastName, this.gender, this.blocked, this.profileImg, this.countryId});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    blocked = json['blocked'];
    profileImg = json['profile_img'];
    countryId = json['country_id'];
  }
}
