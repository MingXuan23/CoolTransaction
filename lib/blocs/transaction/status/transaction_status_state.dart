part of 'transaction_status_bloc.dart';

sealed class TransactionStatusState extends Equatable {
  const TransactionStatusState();

  @override
  List<Object> get props => [];
}

final class TransactionStatusInitial extends TransactionStatusState {}

class TransactionStatusLoading extends TransactionStatusState {}

class TransactionStatusLoaded extends TransactionStatusState {
  final String text;
  final String imageName;

  const TransactionStatusLoaded({required this.text, required this.imageName});
}

class TransactionStatusLoadedFailure extends TransactionStatusState {
  final String error;

  const TransactionStatusLoadedFailure(this.error);

  @override
  List<Object> get props => [error];
}
