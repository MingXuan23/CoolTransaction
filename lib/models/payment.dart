import 'package:cool_transaction/models/user.dart';

class  Payment{
  final double? amount;
   final String desc;
   final int coolingDay;
   final DateTime expiredDate;
   final User user;
  String paymentId ="";
  String url = "";
  

  Payment(this.amount,this.desc,this.coolingDay,this.expiredDate,this.user);
  Payment.withPaymentId(this.amount,this.desc,this.coolingDay,this.expiredDate,this.user,this.paymentId);


}