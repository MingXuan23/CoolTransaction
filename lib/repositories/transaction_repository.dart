import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/models/user.dart';

class TransactionRepository {
  var list = [
    Transaction(DateTime.parse("2024-03-15"), 50.5, "Pay", "Success", User(1, "aada", "asdads","John"),  User(2, "bbbb", "bbbb","David")),
    Transaction(DateTime.parse("2024-03-15"), 63, "Pay", "Refund", User(1, "aada", "asdads","John"),  User(2, "bbbb", "bbbb","David")),
    Transaction.pending(DateTime.parse("2024-03-15"), 75, "Pay", "Pending", User(1, "aada", "asdads","John"),  User(2, "bbbb", "bbbb","David"),DateTime.parse("2024-03-18")),
    Transaction(DateTime.now(), 50, "Receive", "Scam", User(1, "aada", "asdads","John"),  User(2, "bbbb", "bbbb","David"))
  ];

  Future<List<Transaction>> getTransactionHistory(int id) async {
    return list;
       
  }
}
