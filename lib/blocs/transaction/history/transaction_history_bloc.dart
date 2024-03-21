import 'package:bloc/bloc.dart';
import 'package:cool_transaction/models/transaction.dart';
import 'package:cool_transaction/pages/transaction/transaction_repository.dart';
import 'package:equatable/equatable.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {

TransactionRepository repo;
TransactionHistoryBloc(TransactionHistoryState transactionHistoryInitial, this.repo):super(transactionHistoryInitial){
    on<FetchTransactionHistory>((event, emit) async{
        emit(TransactionHistoryLoading());
        try{
           final List<Transaction> transactionList = await repo.getTransactionHistory(event.userId);
            if (transactionList.isNotEmpty) {
          emit(TransactionHistorySuccess(transactionList));
        } else {
          emit(TransactionHistoryEmpty());
        }
        }
        catch(error){
           emit(TransactionHistoryFailure(error.toString().replaceAll('Exception: ', '')));
        }
    });
}
  // LoginBloc(LoginState LoginInitial, this.repo) : super(LoginInitial) {
  //    on<LoginButtonPressed>((event, emit) async {
  //     emit(LoginLoading());
  //     try {
  //       final bool success = repo.login(event.email, event.password);
  //       if (success) {
  //         emit(LoginSuccess());
  //       } else {
  //         emit(LoginFailure('Login failed'));
  //       }
  //     } catch (error) {
  //       emit(LoginFailure(error.toString()));
  //     }
  //   });
  // }
}