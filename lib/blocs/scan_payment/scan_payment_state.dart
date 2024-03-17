import 'package:cool_transaction/models/payment.dart';
import 'package:equatable/equatable.dart';

abstract class ScanPaymentState extends Equatable {
  const ScanPaymentState();
  
  @override
  List<Object?> get props => [];
}

class ScanPaymentInitial extends ScanPaymentState {
  @override
  List<Object> get props => [];
}

class QRCodeScanned extends ScanPaymentState {
  final String scanResult;

  const QRCodeScanned(this.scanResult);

  @override
  List<Object> get props => [scanResult];
}

class ScanPaymentFailure extends ScanPaymentState{
  final String error;

  const ScanPaymentFailure(this.error);

  @override
  List<Object> get props => [error];
}


class MakeNavigateWithPayment extends ScanPaymentState{

  final Payment payment;

  const MakeNavigateWithPayment(this.payment);
  @override
  List<Object> get props => [payment];

}

class MakeNavigateWithoutPayment extends ScanPaymentState{

}