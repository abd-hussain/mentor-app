import 'package:mentor_app/models/https/payment_report_request.dart';
import 'package:mentor_app/models/https/payments_response.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/repository/http_repository.dart';
import 'package:mentor_app/utils/repository/method_name_constractor.dart';

class PaymentService with Service {
  Future<PaymentResponse> listOfPayments() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.payments,
    );
    return PaymentResponse.fromJson(response);
  }

  Future<dynamic> reportPayment(PaymentReportRequest reportBody) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.paymentReport,
      postBody: reportBody,
    );
    return response;
  }
}
