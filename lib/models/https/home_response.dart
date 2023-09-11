class HomeResponse {
  HomeResponseData? data;
  String? message;

  HomeResponse({this.data, this.message});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? HomeResponseData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class HomeResponseData {
  List<MainBanner>? mainBanner;

  HomeResponseData({this.mainBanner});

  HomeResponseData.fromJson(Map<String, dynamic> json) {
    if (json['main_banner'] != null) {
      mainBanner = <MainBanner>[];
      json['main_banner'].forEach((v) {
        mainBanner!.add(MainBanner.fromJson(v));
      });
    }
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
