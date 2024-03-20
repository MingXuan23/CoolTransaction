import 'package:cool_transaction/blocs/payment/payment_bloc.dart';
import 'package:cool_transaction/blocs/payment/payment_event.dart';
import 'package:cool_transaction/blocs/payment/payment_state.dart';
import 'package:cool_transaction/pages/home/home_page.dart';
import 'package:cool_transaction/pages/payment/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cool_transaction/models/payment.dart';

class MakePaymentPage extends StatefulWidget {
  final Payment? payment;
  
  const MakePaymentPage({Key? key, this.payment}) : super(key: key);

  factory MakePaymentPage.empty() {
    return MakePaymentPage(payment: null);
  }

  @override
  _MakePaymentPageState createState() => _MakePaymentPageState();
}

class _MakePaymentPageState extends State<MakePaymentPage> {
  late String paymentId;
  Payment? payment;
  @override
  void initState() {
    super.initState();
    paymentId =  widget.payment?.paymentId ?? '';
    payment =  widget.payment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5465FF),
        title: const Text(
          'Make Payment',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if(state is PaymentFailure){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
          }

          if (state is FetchPaymentState){
            payment = state.payment;
          }
        },
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            //final payment = state.payment;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment ID',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    initialValue: paymentId,
                    enabled: payment == null ,
                    onChanged: (value) {
                      setState(() {
                        paymentId = value;
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: paymentId.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                // Dispatch search event
                                BlocProvider.of<PaymentBloc>(context).add(CheckPaymentEvent(paymentId));
                              },
                            )
                          : null,
                    ),
                  ),
                  if (payment != null) ...[
                    SizedBox(height: 16),
                    Text(
                      'Receiver Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(payment!.user.name),
                    SizedBox(height: 16),
                    Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text( payment!.desc),
                    SizedBox(height: 16),
                    Text(
                      'Amount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      initialValue:  payment!.amount.toString(),
                      enabled:  payment!.amount == null,
                    ),
                     SizedBox(height: 8),
                     Text(
                      'Service Charge: RM 1.00',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                     SizedBox(height: 8),
                     Text(
                      'Total: RM${(payment!.amount! +1).toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                           Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PaymentPage()),
                            );
                          },
                          child: Text('Confirm'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                           Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          },
                          child: Text('Reject'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
