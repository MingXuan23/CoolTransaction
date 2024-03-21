part of 'refund_status_bloc.dart';

sealed class RefundStatusEvent extends Equatable {
  const RefundStatusEvent();

  @override
  List<Object> get props => [];
}


class GetRefundEvent extends RefundStatusEvent {
  final Transaction transaction;

  const GetRefundEvent({required this.transaction});
}