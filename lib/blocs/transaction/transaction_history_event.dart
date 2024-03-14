part of 'transaction_history_bloc.dart';

sealed class TransactionHistoryEvent extends Equatable {
  const TransactionHistoryEvent();

  @override
  List<Object> get props => [];

}

class FetchTransactionHistory extends TransactionHistoryEvent {
  final int userId;
  //final String password;

  const FetchTransactionHistory({
    required this.userId,
  });
}


