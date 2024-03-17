import 'package:cool_transaction/models/payment.dart';
import 'package:equatable/equatable.dart';

sealed class ScanPaymentEvent extends Equatable {
  const ScanPaymentEvent();

  @override
  List<Object?> get props => [];
}

class ScanQRCode extends ScanPaymentEvent {

  final String url;
  const ScanQRCode(this.url);

  @override
  List<Object> get props => [url];
}

class MakePaymentPressed extends ScanPaymentEvent {
  @override
  List<Object> get props => [];
}

