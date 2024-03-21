import 'package:cool_transaction/models/refund.dart';
import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/models/user.dart';

class TransactionRepository {
  var list = [
    Transaction(DateTime.parse("2024-03-15"), 50.5, "Pay", "Success",
        User(1, "aada", "asdads", "John"), User(2, "bbbb", "bbbb", "David")),
    Transaction.hasRefund(
      DateTime.parse("2024-03-15"),
      63,
      "Pay",
      "Refund Requesting",
      User(1, "aada", "asdads", "John"),
      User(2, "bbbb", "bbbb", "David"),
      Refund(
        id: 1,
        paymentId: 'payment_123',
        requestedDate: DateTime(2024, 3, 15),
        requestNo: 'R123',
        reason: 'Damaged product',
        description: 'Received a faulty product, need refund.',
      ),
    ),
    Transaction.pending(
        DateTime.parse("2024-03-15"),
        75,
        "Pay",
        "Pending",
        User(1, "aada", "asdads", "John"),
        User(2, "bbbb", "bbbb", "David"),
        DateTime.parse("2024-03-18")),
    Transaction(DateTime.now(), 50, "Receive", "Scam",
        User(1, "aada", "asdads", "John"), User(2, "bbbb", "bbbb", "David")),
    Transaction.hasRefund(
      DateTime.parse("2024-03-15"),
      63,
      "Pay",
      "Refunded",
      User(1, "aada", "asdads", "John"),
      User(2, "bbbb", "bbbb", "David"),
      Refund(
        id: 1,
        paymentId: 'payment_123',
        requestedDate: DateTime(2024, 3, 15),
        requestNo: 'R123',
        reason: 'Damaged product',
        description: 'Received a faulty product, need refund.',
      ),
    ),
    Transaction.hasRefund(
      DateTime.parse("2024-03-15"),
      63,
      "Pay",
      "Refund Pending",
      User(1, "aada", "asdads", "John"),
      User(2, "bbbb", "bbbb", "David"),
      Refund(
        id: 2,
        paymentId: 'payment_456',
        requestedDate: DateTime(2024, 3, 16),
        requestNo: 'R456',
        reason: 'Wrong item',
        description: 'Received the wrong item, need refund or replacement.',
      ),
    ),
    Transaction.hasRefund(
      DateTime.parse("2024-03-15"),
      63,
      "Pay",
      "Refund Rejected",
      User(1, "aada", "asdads", "John"),
      User(2, "bbbb", "bbbb", "David"),
      Refund(
        id: 3,
        paymentId: 'payment_456',
        requestedDate: DateTime(2024, 3, 16),
        requestNo: 'R456',
        reason: 'Wrong item',
        description: 'Received the wrong item, need refund or replacement.',
      ),
    ),
  ];

  Future<List<Transaction>> getTransactionHistory(int id) async {
    return list;
  }
}
