class PaymentModel {
  List<Payment>? data;
  String? message;

  PaymentModel({this.data, this.message});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Payment>[];
      json['data'].forEach((v) {
        data!.add(Payment.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Payment {
  int? id;
  String? name;
  double? amount;
  String? status;
  String? date;

  Payment({this.id, this.name, this.amount, this.status, this.date});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    status = json['status'];
    date = json['date'];
  }
}
