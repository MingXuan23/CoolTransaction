import 'package:cool_transaction/blocs/transaction/status/transaction_status_bloc.dart';
import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/pages/transaction/refund_request_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class TransactionStatusPage extends StatefulWidget {
  final Transaction transaction;

  const TransactionStatusPage({super.key, required this.transaction});

  @override
  State<TransactionStatusPage> createState() => _TransactionStatusPageState();
}

class _TransactionStatusPageState extends State<TransactionStatusPage> {
  String text = "";
  String imgName = "";

  @override
  void initState() {
    super.initState();
    context
        .read<TransactionStatusBloc>()
        .add(GetTransactionEvent(transaction: widget.transaction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF5465FF),
          title: const Text(
            'Transaction Status',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: BlocListener<TransactionStatusBloc, TransactionStatusState>(
          listener: (context, state) {
            if (state is TransactionStatusInitial) {}

            if (state is TransactionStatusLoading) {}

            if (state is TransactionStatusLoaded) {
              setState(() {
                text = state.text;
                imgName = state.imageName;
              });
            }
          },
          child: BlocBuilder<TransactionStatusBloc, TransactionStatusState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      childAspectRatio: 1,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            text,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              imgName != ""
                                  ? "assets/images/" + imgName
                                  : "assets/images/loading.png",
                              fit: BoxFit.cover, // Adjust the fit as needed
                            ),
                          ),
                        ),
                      ],
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      childAspectRatio: 3,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Receiver Name:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.transaction.relatedUser!.name,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Payment Id',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "payment123",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Release Date:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.transaction.date.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    if (widget.transaction.status == 'Pending')
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 55.0,
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle approve button click
                              },
                              child: Text(
                                'Release Now',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xFF5465FF),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10), // Add spacing between buttons
                          SizedBox(
                            width: double.infinity,
                            height: 55.0,
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle reject button click
                              },
                              child: Text(
                                'Extend Date',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xFF5465FF),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10), 
                          SizedBox(
                            width: double.infinity,
                            height: 55.0,
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle reject button click
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RefundRequestPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Refund',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xFF5465FF),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (widget.transaction.status == 'Scam Reported')
                      SizedBox(
                        width: double.infinity,
                        height: 55.0,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle cancel button click
                          },
                          child: Text(
                            'View Report',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF5465FF),
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox.shrink()
                  ],
                ),
              );
            },
          ),
        ));
  }
}
