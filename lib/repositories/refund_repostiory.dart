import 'package:cool_transaction/models/refund.dart';
import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/models/user.dart';

class RefundRepository{
  
  var refunds = [
    Refund(
      id: 1,
      paymentId: 'payment_123',
      requestedDate: DateTime(2024, 3, 15),
      requestNo: 'R123',
      reason: 'Damaged product',
      description: 'Received a faulty product, need refund.',
      status: "completed",
      transaction: Transaction(DateTime.parse("2024-03-15"), 50.5, "Pay", "Success", User(2, "choonfei@test.com", "abc123","Fei"), User(1, "mx@test.com", "abc123","Mingxuan")),
    ),
    Refund(
      id: 2,
      paymentId: 'payment_456',
      requestedDate: DateTime(2024, 3, 16),
      requestNo: 'R456',
      reason: 'Wrong item',
      description: 'Received the wrong item, need refund or replacement.',
      status: "pending",
      transaction: Transaction(DateTime.parse("2024-03-15"), 50.5, "Pay", "Success", User(2, "choonfei@test.com", "abc123","Fei"), User(1, "mx@test.com", "abc123","Mingxuan")),
    ),
    Refund(
      id: 3,
      paymentId: 'payment_456',
      requestedDate: DateTime(2024, 3, 16),
      requestNo: 'R456',
      reason: 'Wrong item',
      description: 'Received the wrong item, need refund or replacement.',
      status: "rejected",
      transaction: Transaction(DateTime.parse("2024-03-15"), 50.5, "Pay", "Success", User(2, "choonfei@test.com", "abc123","Fei"), User(1, "mx@test.com", "abc123","Mingxuan")),
    ),
    Refund(
      id: 4,
      paymentId: 'payment_456',
      requestedDate: DateTime(2024, 3, 16),
      requestNo: 'R456',
      reason: 'Wrong item ',
      description: 'Received the wrong item, need refund or replacement.',
      status: "requesting",
      transaction: Transaction(DateTime.parse("2024-03-15"), 50.5, "Pay", "Success", User(2, "choonfei@test.com", "abc123","Fei"), User(1, "mx@test.com", "abc123","Mingxuan")),
    ),
  ];

  Future<Refund?> getRefundById(int id) async {
    return refunds.firstWhere((x) => x.id == id);
  }
}