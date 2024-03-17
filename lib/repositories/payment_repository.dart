import 'package:cool_transaction/models/payment.dart';
import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/models/user.dart';

class PaymentRepository {
  var list = [
    Payment.withPaymentId(100, "Fei's Popian Basah", 3, DateTime(2024,3,18),  User(2, "choonfei@test.com", "abc123","Fei"),"Payment1")

  ];

  Future<Payment> storePayment(Payment payment) async {

    //saving process
    payment.paymentId = "Payment1";
    payment.url = "http://coolingTransacion.my/getPayment/${payment.user.id}/${payment.paymentId}";

    return payment;
       
  }

  Future<Payment> getPaymentByManual(String paymentId) async {
   final paymentAny = list.any((element) => element.paymentId == paymentId);
   if(!paymentAny)
      throw Exception("Invalid Payment Id");

    final payment = list.firstWhere((element) => element.paymentId == paymentId);

    return payment;
       
  }

  Future<Payment> getPaymentByLink(String url) async {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;

      if (pathSegments.length < 3 || pathSegments[0] != 'getPayment') {
        throw Exception('Invalid URL format');
      }

      final userId = int.tryParse(pathSegments[1]);
      final paymentId = pathSegments[2];

      if (userId == null || paymentId.isEmpty) {
        throw Exception('Invalid user ID or payment ID');
      }

      final payment = list.firstWhere(
        (element) => element.user.id == userId && element.paymentId == paymentId,
        orElse: () => throw Exception('Payment not found'),
      );

      return payment;
}

}
