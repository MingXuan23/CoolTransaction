part of 'refund_status_bloc.dart';

sealed class RefundStatusState extends Equatable {
  const RefundStatusState();
  
  @override
  List<Object> get props => [];
}

final class RefundStatusInitial extends RefundStatusState {}

class RefundStatusLoading extends RefundStatusState {}

class RefundStatusLoaded extends RefundStatusState {
  final Refund refund;
  final String text;
  final String imageName;

  const RefundStatusLoaded({required this.refund, required this.text, required this.imageName}); 
}

class RefundStatusLoadedFailure extends RefundStatusState {
  final String error;

  const RefundStatusLoadedFailure(this.error);

  @override
  List<Object> get props => [error];
}
