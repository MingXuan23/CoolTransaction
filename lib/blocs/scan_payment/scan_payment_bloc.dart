import 'package:bloc/bloc.dart';
import 'package:cool_transaction/repositories/payment_repository.dart';
import 'scan_payment_event.dart';
import 'scan_payment_state.dart';

class ScanPaymentBloc extends Bloc<ScanPaymentEvent, ScanPaymentState> {
  final PaymentRepository repo;

  ScanPaymentBloc(ScanPaymentInitial scanPaymentInitial, this.repo) : super(scanPaymentInitial) {
    on<ScanQRCode>(_mapScanQRCodeToState);
    on<MakePaymentPressed>(makePaymentWithoutPayment);
  }

  void _mapScanQRCodeToState(ScanQRCode event, Emitter<ScanPaymentState> emit) async  {
   try{
      final payment = await repo.getPaymentByLink(event.url);
      emit (MakeNavigateWithPayment(payment));
      emit(ScanPaymentInitial());
   }catch(error){
    emit(ScanPaymentFailure(error.toString().replaceAll('Exception: ', '')));
   }
  }
 
  void makePaymentWithoutPayment(MakePaymentPressed event,Emitter<ScanPaymentState> emit) {
    emit(MakeNavigateWithoutPayment());
    emit(ScanPaymentInitial());
  }
}
