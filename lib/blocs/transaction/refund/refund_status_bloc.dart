import 'package:bloc/bloc.dart';
import 'package:cool_transaction/models/refund.dart';
import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/repositories/refund_repostiory.dart';
import 'package:equatable/equatable.dart';

part 'refund_status_event.dart';
part 'refund_status_state.dart';

class RefundStatusBloc extends Bloc<RefundStatusEvent, RefundStatusState> {
  final RefundRepository repo;

  RefundStatusBloc(RefundStatusState RefundStatusInitial, this.repo)
      : super(RefundStatusInitial) {
    on<GetRefundEvent>((event, emit) async {
      emit(RefundStatusLoading());

      var map = {
        "Refunded": ["You have been refunded RM${event.transaction.amount.toStringAsFixed(2)} to the bank acount.", "completed.png"],
        "Refund Pending": ["You are requesting refund RM${event.transaction.amount.toStringAsFixed(2)} to the bank acount.", "pending.png"],
        "Refund Rejected": ["You are rejected for refund RM${event.transaction.amount.toStringAsFixed(2)} to the bank acount.", "rejected.png"],
        "Refund Requesting": ["You have been requested for refund RM${event.transaction.amount.toStringAsFixed(2)} to the bank acount.", "withdraw.png"],
      };

      String text = map[event.transaction.status]?[0] ?? "";
      String imageName = map[event.transaction.status]?[1] ?? "";

      if (text.isNotEmpty) {
        emit(RefundStatusLoaded(text: text, imageName: imageName));
      } else {
        emit(RefundStatusLoadedFailure("Invalid refund status"));
      }
    });
  }
}
