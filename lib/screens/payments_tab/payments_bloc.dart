import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/payment_report_request.dart';
import 'package:mentor_app/models/https/payments_response.dart';
import 'package:mentor_app/services/payment_services.dart';
import 'package:mentor_app/utils/mixins.dart';

class PaymentsBloc extends Bloc<PaymentService> {
  final ValueNotifier<List<PaymentResponseData>> paymentListNotifier = ValueNotifier<List<PaymentResponseData>>([]);
  double pendingTotalAmount = 0;
  double rejectedTotalAmount = 0;
  double recivedTotalAmount = 0;

  getListOfPayments() {
    service.listOfPayments().then((value) {
      if (value.data != null) {
        paymentListNotifier.value = value.data!;

        for (PaymentResponseData item in value.data!) {
          if (item.dBMentorPayments!.status == 1) {
            pendingTotalAmount = pendingTotalAmount + item.dBMentorPayments!.amount!;
          }
          if (item.dBMentorPayments!.status == 2) {
            recivedTotalAmount = recivedTotalAmount + item.dBMentorPayments!.amount!;
          }
          if (item.dBMentorPayments!.status == 3) {
            rejectedTotalAmount = rejectedTotalAmount + item.dBMentorPayments!.amount!;
          }
        }
      }
    });
  }

  Future<dynamic> reportPayment(int id, String message) async {
    PaymentReportRequest data = PaymentReportRequest(message: message, paymentId: id);
    return service.reportPayment(data);
  }

  @override
  onDispose() {}
}