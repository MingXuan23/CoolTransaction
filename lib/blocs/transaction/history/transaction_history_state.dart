part of 'transaction_history_bloc.dart';

sealed class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();
  
  @override
  List<Object> get props => [];
}

final class TransactionHistoryInitial extends TransactionHistoryState {}

class TransactionHistoryLoading extends TransactionHistoryState {}

class TransactionHistorySuccess extends TransactionHistoryState {
  final List<Transaction> transactionList;

  const TransactionHistorySuccess(this.transactionList);

  @override
  List<Object> get props => [transactionList];

}

class TransactionHistoryEmpty extends TransactionHistoryState {}

class TransactionHistoryFailure extends TransactionHistoryState {
  final String error;

  const TransactionHistoryFailure(this.error);

  @override
  List<Object> get props => [error];
}