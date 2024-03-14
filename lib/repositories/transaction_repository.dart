import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/models/user.dart';

class TransactionRepository {
  var list = [
    Transaction(DateTime.now(), 50.5, "Pay", "Success", User(1, "aada", "asdads"),  User(2, "bbbb", "bbbb")),
    Transaction(DateTime.now(), 63, "Pay", "Refund", User(1, "aada", "asdads"),  User(2, "bbbb", "bbbb")),

    Transaction(DateTime.now(), 75, "Pay", "Pending", User(1, "aada", "asdads"),  User(2, "bbbb", "bbbb")),

    Transaction(DateTime.now(), 50, "Receive", "Scam", User(1, "aada", "asdads"),  User(2, "bbbb", "bbbb"))

  ];

  Future<List<Transaction>> getTransactionHistory(int id) async {
    return list;
       
  }
}
