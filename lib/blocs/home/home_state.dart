import 'package:equatable/equatable.dart';
import 'package:cool_transaction/models/transaction.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadedState extends HomeState {
  final String username;
  final List<Transaction> transactions;

  const HomeLoadedState({
    required this.username,
    required this.transactions,
  });

  @override
  List<Object?> get props => [username, transactions];
}

class HomeLogoutState extends HomeState {}

class HomeLoginExpiredState extends HomeState {}
