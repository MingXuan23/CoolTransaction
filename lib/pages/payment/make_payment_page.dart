import 'package:flutter/material.dart';
import 'package:cool_transaction/models/payment.dart';

class MakePaymentPage extends StatelessWidget {
  final Payment? payment;

  // Constructor with payment parameter
  MakePaymentPage({Key? key, required this.payment}) : super(key: key);

  // Constructor with no parameters
  MakePaymentPage.empty({Key? key}) : payment = null, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              payment != null ? 'Payment ID: ${payment!.paymentId}' : 'No Payment ID provided',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality here
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
