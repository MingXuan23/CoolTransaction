import 'package:cool_transaction/models/user.dart';

class  Transaction{
   final String type;
   final String status;
   final User? relatedUser;
   final User? user;
   final DateTime date;
   final double amount;


   Transaction(this.date,this.amount,this.type,this.status,this.user,this.relatedUser);
}