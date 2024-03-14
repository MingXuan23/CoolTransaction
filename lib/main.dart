import 'package:cool_transaction/blocs/auth/login/login_bloc.dart';
import 'package:cool_transaction/blocs/transaction/transaction_history_bloc.dart';
import 'package:cool_transaction/pages/auth/login_page.dart';
import 'package:cool_transaction/pages/transaction/transaction_history.dart';
import 'package:cool_transaction/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cool_transaction/repositories/user_repository.dart';
import 'package:flutter/material.dart';

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
        BlocProvider<TransactionHistoryBloc>(
          create: (context) => TransactionHistoryBloc(TransactionHistoryInitial(), TransactionRepository()),
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