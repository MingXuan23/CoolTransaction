import 'package:cool_transaction/blocs/transaction/refund/refund_status_bloc.dart';
import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/pages/transaction/report_scam_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefundStatusPage extends StatefulWidget {
  final Transaction transaction;
  const RefundStatusPage({super.key, required this.transaction});

  @override
  State<RefundStatusPage> createState() => _RefundStatusPageState();
}

class _RefundStatusPageState extends State<RefundStatusPage> {
  String text = "";
  String imgName = "";

  @override
  void initState() {
    super.initState();
    context
        .read<RefundStatusBloc>()
        .add(GetRefundEvent(transaction: widget.transaction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5465FF),
        title: const Text(
          'Refund Status',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocListener<RefundStatusBloc, RefundStatusState>(
        listener: (context, state) {
          if (state is RefundStatusInitial) {}

          if (state is RefundStatusLoading) {}

          if (state is RefundStatusLoaded) {
            setState(() {
              text = state.text;
              imgName = state.imageName;
            });
          }
        },
        child: BlocBuilder<RefundStatusBloc, RefundStatusState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 8 / 4,
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
                          'Transaction No:',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.transaction.refund!.paymentId,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Requested by:',
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
                          'Request at:',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.transaction.refund!.requestedDate.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Request No:',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.transaction.refund!.requestNo,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Reason:',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.transaction.refund!.reason,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  if (widget.transaction.status == 'Refund Requesting')
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
                              'Approve',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                              'Reject',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF5465FF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else if (widget.transaction.status == 'Refund Pending')
                    SizedBox(
                      width: double.infinity,
                      height: 55.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle cancel button click
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF5465FF),
                          ),
                        ),
                      ),
                    )
                  else if (widget.transaction.status == 'Refund Rejected')
                    SizedBox(
                      width: double.infinity,
                      height: 55.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle cancel button click
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ReportScamPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Report Scam',
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
      ),
    );
  }
}
