import 'package:equatable/equatable.dart';



sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitialState extends PaymentState {}

class PaymentLoadedState extends PaymentState {
  final String username;
  final List<Map<String, String>> transactions;

  const PaymentLoadedState({
    required this.username,
    required this.transactions,
  });

  @override
  List<Object?> get props => [username, transactions];
}

class PaymentCreatedState extends PaymentState {
  final String paymentId;

  const PaymentCreatedState({required this.paymentId});

  @override
  List<Object?> get props => [paymentId];
}

class FormattedAmount extends PaymentState {
  final String formattedAmount;

  const FormattedAmount(this.formattedAmount);

  @override
  List<Object?> get props => [formattedAmount];
}

class FormattedCoolingPeriod extends PaymentState {
  final String days;
  final String message; 
  const FormattedCoolingPeriod(this.days ,this.message);

  @override
  List<Object?> get props => [days];
}

class FetchReceiverState extends PaymentState{
  final String receiverNmae;

  const FetchReceiverState(this.receiverNmae);

  @override
  List<Object?> get props => [receiverNmae];
}

class PaymentFailure extends PaymentState {
  final String error;

  const PaymentFailure(this.error);

  @override
  List<Object> get props => [error];
}