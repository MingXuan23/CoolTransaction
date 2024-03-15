import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cool_transaction/models/user.dart';
import 'package:cool_transaction/repositories/payment_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc(PaymentInitialState paymentInitialState, PaymentRepository paymentRepository) 
      : super(paymentInitialState) {
    on<AmountChangedEvent>(_amountChanged);
    on<CoolingPeriodChangedEvent>(_coolingPeriodChanged);
    on<FetchReceiverEvent>(_fetchReceiver);
    on<CreatePaymentEvent>(_createPayment);
  }

  void _amountChanged(AmountChangedEvent event, Emitter<PaymentState> emit) {
    String newValue =  event.newValue.replaceAll(RegExp(r'[^0-9]'), '');

 // newValue = newValue.replaceAll('.', '');
  if (newValue.length >= 2) {
    newValue = '${newValue.substring(0, newValue.length - 2)}.${newValue.substring(newValue.length - 2)}';
  } else {
    newValue = '0.${newValue.padLeft(2, '0')}';
  }

  if(newValue.startsWith('.')){
    newValue = '0${newValue.padLeft(2, '0')}';
  }
    newValue = newValue.replaceFirst(RegExp('^0+(?!\\.)'), '');
    newValue = 'RM $newValue';
    emit(FormattedAmount(newValue));
  }

  void _coolingPeriodChanged(CoolingPeriodChangedEvent event, Emitter<PaymentState> emit) {
    String newValue =  event.newValue.replaceAll(RegExp(r'[^0-9]'), '');
    String message = "";
    int parsedValue = 3;
      if (newValue == "") {
        parsedValue = 3 ;
        message = "The cooling period cannot less than 3 days";

      } else {
        parsedValue = int.tryParse(newValue) ?? 1; // Parse the value as an integer
        // If the parsed value is greater than 21, set it to "21"
        if (parsedValue > 21) {
          parsedValue = 21;
          message = "The cooling period cannot greater than 21 days";
        }else if (parsedValue < 3){
          parsedValue = 3;
          message = "The cooling period cannot less than 3 days";

        }

        newValue = parsedValue.toString();
      }
    emit(FormattedCoolingPeriod(newValue,message));
  }

  void _fetchReceiver(FetchReceiverEvent event, Emitter<PaymentState> emit) async {
      try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      if(userJson == null)
        throw Exception("Invalid User");

        final user = User.fromJson( json.decode(userJson));
        emit(FetchReceiverState(user.name));
      }
      catch(error){
        emit(PaymentFailure(error.toString()));
      }
      

  }

  void _createPayment(CreatePaymentEvent event, Emitter<PaymentState> emit) {
  }
}
