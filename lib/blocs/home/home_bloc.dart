import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cool_transaction/models/user.dart';
import 'package:cool_transaction/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  UserRepository repo = UserRepository();

  HomeBloc() : super(HomeInitialState()) {
    on<HomeLoadedEvent>(_onHomeLoaded);
    on<LogoutButtonPressed>(_onLogoutPressed);
  }

  void _onHomeLoaded(HomeLoadedEvent event, Emitter<HomeState> emit) async {
    // Perform any necessary logic to fetch user data or transactions
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
        final userJson = prefs.getString('user');
        if(userJson == null){
          throw Exception('Login Expired');
        }
        final user = User.fromJson(json.decode(userJson));
        final username = user.name; // Replace this with your actual logic
        final transactions = [
          {'user': 'User A', 'amount': '+RM 50.00'},
          {'user': 'User B', 'amount': '-RM 100.00'}
        ];

        emit(HomeLoadedState(username: username, transactions: transactions));
    }catch(e){
       emit(HomeLoginExpiredState());
        await repo.logout();
    }
    
  }

  void _onLogoutPressed  (
    LogoutButtonPressed event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLogoutState());
    await repo.logout();
  }
}
