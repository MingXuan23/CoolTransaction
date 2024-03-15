import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cool_transaction/blocs/payment/payment_bloc.dart';
import 'package:cool_transaction/blocs/payment/payment_event.dart';
import 'package:cool_transaction/blocs/payment/payment_state.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({Key? key}) : super(key: key);

  @override
  State<AddPaymentPage> createState() => AddPaymentState();
}

class AddPaymentState extends State<AddPaymentPage> {
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _coolingPeriodController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _paymentId;


  @override
  void initState(){
    super.initState();
     BlocProvider.of<PaymentBloc>(context).add(
      FetchReceiverEvent(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5465FF),
        title: Text(
          'Add Payment',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentCreatedState) {
            // Update the UI with the created payment details
            setState(() {
              _paymentId = state.paymentId;
            });
          }
          if(state is PaymentFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
          }
          if(state is FormattedAmount){
            _amountController.text = state.formattedAmount;
          }

          if(state is FormattedCoolingPeriod){
            _coolingPeriodController.text = state.days;
            if(state.message != ""){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          }

          if(state is FetchReceiverState){
            _receiverNameController.text = state.receiverNmae;

          }
        },
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _receiverNameController,
                    decoration: const InputDecoration(labelText: 'Receiver Name',labelStyle: TextStyle(color: Colors.black),),
                    style: const TextStyle(color: Colors.black),
                    enabled: false,
                  ),
                 TextFormField(
                   controller: _amountController,
                    keyboardType: TextInputType.number,
                    onChanged: (amount) {
                      BlocProvider.of<PaymentBloc>(context).add(
                        AmountChangedEvent(amount),
                      );

                      if(state is FormattedAmount){
                        _amountController.text = state.formattedAmount;
                      }
                    },
                    decoration: InputDecoration(labelText: 'Amount (RM)'),
                    //initialValue: '0.00',
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextFormField(
                    controller: _coolingPeriodController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Cooling Period (Days)'),
                    onChanged: (day){
                      BlocProvider.of<PaymentBloc>(context).add(
                        CoolingPeriodChangedEvent(day),
                      );

                      if(state is FormattedCoolingPeriod){
                        _coolingPeriodController.text = state.days;
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text('Expired Date: '),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Dispatch event to create payment
                      BlocProvider.of<PaymentBloc>(context).add(
                        CreatePaymentEvent(
                          receiverName: _receiverNameController.text,
                          amount: _amountController.text,
                          description: _descriptionController.text,
                          integer: _coolingPeriodController.text,
                          date: _selectedDate,
                        ),
                      );
                    },
                    child: Text('Create'),
                  ),
                  if (_paymentId != null) ...[
                    Container(
                      padding: EdgeInsets.all(20.0),
                      color: Colors.grey.shade200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Payment ID: $_paymentId'),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => _copyPaymentId(context),
                                child: Text('Copy'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () => _downloadQR(context),
                                child: Text('Download QR'),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          // QR Code Widget can be added here
                        ],
                      ),
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


  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _copyPaymentId(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _paymentId ?? ''));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Payment ID copied to clipboard'),
    ));
  }

  void _downloadQR(BuildContext context) {
    // Placeholder method for downloading QR code
    // Generate QR code based on payment ID
    // Download the QR code image
    // This is a placeholder method, replace with actual logic
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Downloading QR code...'),
    ));
  }
}
