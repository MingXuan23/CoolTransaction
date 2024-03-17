import 'package:cool_transaction/blocs/transaction/history/transaction_history_bloc.dart';
import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/widget/common/loading_widget.dart';
import 'package:cool_transaction/widget/transaction_widget/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => TransactionHisState();
}

class TransactionHisState extends State<TransactionHistoryPage> {
  List<Transaction> transactionList = [];

   @override
  void initState() {
    super.initState();
    // Dispatch the FetchTransactionHistory event when the page is loaded
    BlocProvider.of<TransactionHistoryBloc>(context).add(
      FetchTransactionHistory(userId: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      //backgroundColor: Colors.lightBlue,
     appBar: AppBar(
        backgroundColor: Color(0xFF5465FF), // Set AppBar background color
        title: Text(
          'Transaction History',
          style: TextStyle(color: Colors.white), 
          // Set text color to white
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocListener<TransactionHistoryBloc, TransactionHistoryState>(
        listener: (context, state) {
          if (state is TransactionHistoryFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }

          if (state is TransactionHistorySuccess) {
             transactionList = state.transactionList;
          }
        },
        child: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
          builder: (context, state) {

            if(state is TransactionHistoryLoading){
               return LoadingOverlay();
            }
            return SafeArea(
              child: transactionList.isNotEmpty 
                  ? ListView.builder(
                      itemCount: transactionList.length,
                      itemBuilder: (context, index) {
                        return TransactionCard(transaction: transactionList[index]);
                      },
                    )
                  : const Center(
                      child: Text("No record"),
                  )
            );
          },
      ),
    )
    );
  }
}