import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/models/user.dart';

class Refund {
  int id;
  String paymentId;
  DateTime requestedDate;
  String requestNo;
  String reason;
  String description;
  String status;
  Transaction transaction;

  Refund({
    required this.id,
    required this.paymentId,
    required this.requestedDate,
    required this.requestNo,
    required this.reason,
    required this.description,
    required this.status,
    required this.transaction
  });
}
