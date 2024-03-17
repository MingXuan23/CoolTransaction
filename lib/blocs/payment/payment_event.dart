import 'package:equatable/equatable.dart';


sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class PaymentLoadedEvent extends PaymentEvent {}

class CreatePaymentEvent extends PaymentEvent {
  final String receiverName;
  final String amount;
  final String description;
  final String coolingPeriod;
  final DateTime date;

  const CreatePaymentEvent({
    required this.receiverName,
    required this.amount,
    required this.description,
    required this.coolingPeriod,
    required this.date,
  });

  @override
  List<Object?> get props => [receiverName, amount, description, coolingPeriod, date];
}


class AmountChangedEvent extends PaymentEvent {
  final String newValue;

  const AmountChangedEvent(this.newValue);

  @override
  List<Object?> get props => [newValue];
}

class FetchReceiverEvent extends PaymentEvent{

}


class CoolingPeriodChangedEvent extends PaymentEvent {
  final String newValue;

  const CoolingPeriodChangedEvent(this.newValue);

  @override
  List<Object?> get props => [newValue];
}