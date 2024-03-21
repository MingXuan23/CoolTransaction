import 'package:bloc/bloc.dart';
import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/repositories/transaction_repository.dart';
import 'package:equatable/equatable.dart';

part 'transaction_status_event.dart';
part 'transaction_status_state.dart';

class TransactionStatusBloc
    extends Bloc<TransactionStatusEvent, TransactionStatusState> {
  TransactionRepository repo;
  TransactionStatusBloc(
      TransactionStatusState TransactionStatusInitial, this.repo)
      : super(TransactionStatusInitial) {
    on<GetTransactionEvent>((event, emit) async {
      emit(TransactionStatusLoading());

      var map = {
        "Success": ["You have paid RM${event.transaction.amount.toStringAsFixed(2)} to the bank account. Your transaction was successful.", "completed.png"],
        "Pending": ["Your payment of RM${event.transaction.amount.toStringAsFixed(2)} to the bank account is still pending.", "pending.png"],
        "Scam Reported": ["You are rejected for refund. The RM${event.transaction.amount.toStringAsFixed(2)} transaction to the bank account has been reported as a scam.", "danger.png"],
      };

      String text = map[event.transaction.status]?[0] ?? "";
      String imageName = map[event.transaction.status]?[1] ?? "";

      if (text.isNotEmpty) {
        emit(TransactionStatusLoaded(text: text, imageName: imageName));
      } else {
        emit(TransactionStatusLoadedFailure("Invalid transaction status"));
      }
    });
  }
}
