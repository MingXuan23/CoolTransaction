import 'package:cool_transaction/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  TransactionCard({required this.transaction});


String getDateFormat(DateTime ?date){
  if(date == null){
    return "";
  }
  return 
    '${date.year}/${date.month}/${date.day} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}' ;

}
  @override
  Widget build(BuildContext context) {

    final Map<String, Color> colors = {
      'Scam': Color(0xFFFF5959),
      'Refund': Color(0xFFFF5959),

      'Pending': Color(0xFFF5C71A),
      'Success': Color(0xFF5465FF),
    };

    final String operator = transaction.type == 'Pay'?'-':'+';
    final String hint = transaction.type == 'Pay'?'To ':'From ';

     return GestureDetector(
      onTap: () {
       
      },
      child: Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: colors[transaction.status],
        borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Existing content wrapped in a Column
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Text(
                '$operator RM ${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
              ),
              Text(
                '$hint ${transaction.relatedUser?.email ?? 'Unknown'}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                getDateFormat(transaction.date),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
            Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [
              Text(
                transaction.status,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 25),
              ),

              if(transaction.status=="Pending")
                Text(
                    getDateFormat(transaction.estimateSuccessTime??null),
                    style: TextStyle( color: Colors.white),
                  ),
            ],
          ),
          // Status widget placed on the right-hand side
          
        ],
      ),

    ));

  }
}