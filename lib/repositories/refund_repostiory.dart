import 'package:cool_transaction/models/refund.dart';

class RefundRepository{
  
  var refunds = [
    Refund(
      id: 1,
      paymentId: 'payment_123',
      requestedDate: DateTime(2024, 3, 15),
      requestNo: 'R123',
      reason: 'Damaged product',
      description: 'Received a faulty product, need refund.',
    ),
    Refund(
      id: 2,
      paymentId: 'payment_456',
      requestedDate: DateTime(2024, 3, 16),
      requestNo: 'R456',
      reason: 'Wrong item',
      description: 'Received the wrong item, need refund or replacement.',
    ),
    Refund(
      id: 3,
      paymentId: 'payment_456',
      requestedDate: DateTime(2024, 3, 16),
      requestNo: 'R456',
      reason: 'Wrong item',
      description: 'Received the wrong item, need refund or replacement.',
    ),
    Refund(
      id: 4,
      paymentId: 'payment_456',
      requestedDate: DateTime(2024, 3, 16),
      requestNo: 'R456',
      reason: 'Wrong item ',
      description: 'Received the wrong item, need refund or replacement.',
    ),
  ];

  Future<Refund?> getRefundById(int id) async {
    return refunds.firstWhere((x) => x.id == id);
  }
}