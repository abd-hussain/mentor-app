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
  List<MainEvent>? mainEvent;

  HomeResponseData({this.mainBanner, this.mainEvent});

  HomeResponseData.fromJson(Map<String, dynamic> json) {
    if (json['main_banner'] != null) {
      mainBanner = <MainBanner>[];
      json['main_banner'].forEach((v) {
        mainBanner!.add(MainBanner.fromJson(v));
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
