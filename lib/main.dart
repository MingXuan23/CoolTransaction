import 'package:cool_transaction/blocs/auth/login/login_bloc.dart';
import 'package:cool_transaction/blocs/home/home_bloc.dart';
import 'package:cool_transaction/blocs/payment/payment_bloc.dart';
import 'package:cool_transaction/blocs/payment/payment_state.dart';
import 'package:cool_transaction/blocs/scan_payment/scan_payment_bloc.dart';
import 'package:cool_transaction/blocs/scan_payment/scan_payment_state.dart';
import 'package:cool_transaction/blocs/transaction/history/transaction_history_bloc.dart';
import 'package:cool_transaction/blocs/transaction/refund/refund_status_bloc.dart';
import 'package:cool_transaction/pages/auth/login_page.dart';
import 'package:cool_transaction/pages/transaction/refund/refund_request_page.dart';
import 'package:cool_transaction/pages/transaction/refund/refund_status_page.dart';
import 'package:cool_transaction/pages/transaction/transaction_history.dart';
import 'package:cool_transaction/repositories/refund_repostiory.dart';
import 'package:cool_transaction/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cool_transaction/repositories/user_repository.dart';
import 'package:flutter/material.dart';

import 'repositories/payment_repository.dart';

void main() {
  runApp(MyApp(home: LoginPage()));
}

class MyApp extends StatelessWidget {
  final Widget home;
  MyApp({required this.home});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(LoginInitial(), UserRepository()),
        ),

        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<TransactionHistoryBloc>(
          create: (context) => TransactionHistoryBloc(TransactionHistoryInitial(), TransactionRepository()),
        ),
        BlocProvider<PaymentBloc>(
          create: (context) => PaymentBloc(PaymentInitialState(), PaymentRepository()),
        ),
        BlocProvider<ScanPaymentBloc>(
          create: (context) => ScanPaymentBloc(ScanPaymentInitial(), PaymentRepository()),
        ),
         BlocProvider<RefundStatusBloc>(
          create: (context) => RefundStatusBloc(RefundStatusInitial(), RefundRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cool Transaction',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: this.home,
      ),
    );
  }
}