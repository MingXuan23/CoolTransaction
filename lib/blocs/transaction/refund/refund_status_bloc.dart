import 'package:bloc/bloc.dart';
import 'package:cool_transaction/models/refund.dart';
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

      Refund? refund = await this.repo.getRefundById(event.id);

      if (refund == null) {
        emit(RefundStatusLoadedFailure("Invalid refund"));
        return;
      }

      var map = {
        "completed": ["You have been refunded", "completed.png"],
        "pending": ["You are requesting refund", "pending.png"],
        "rejected": ["You are rejected for refund", "rejected.png"],
        "requesting": ["You have been requested for refund", "withdraw.png"],
      };

      String text = map[refund.status]?[0] ?? "";
      String imageName = map[refund.status]?[1] ?? "";

      if (text.isNotEmpty) {
        emit(RefundStatusLoaded(refund: refund, text: text, imageName: imageName));
      } else {
        emit(RefundStatusLoadedFailure("Invalid refund status"));
      }
    });
  }
}
