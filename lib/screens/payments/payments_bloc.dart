import 'package:mentor_app/models/https/payment_model.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/utils/mixins.dart';

class PaymentsBloc extends Bloc<AccountService> {
  List<Payment> listOfPayments = [
    Payment(
      id: 1,
      name:
          "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest",
      amount: 210,
      status: "pending",
      date: "2013",
    ),
    Payment(
      id: 2,
      name: "test 2",
      amount: 250,
      status: "pending",
      date: "2016",
    ),
  ];

  @override
  onDispose() {}
}
