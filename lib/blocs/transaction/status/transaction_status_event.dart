part of 'transaction_status_bloc.dart';

sealed class TransactionStatusEvent extends Equatable {
  const TransactionStatusEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionEvent extends TransactionStatusEvent {
  final Transaction transaction;

  const GetTransactionEvent({required this.transaction});
}
