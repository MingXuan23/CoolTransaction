import 'package:bloc/bloc.dart';
import 'package:cool_transaction/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository repo;

  LoginBloc(LoginState loginInitial, this.repo) : super(loginInitial) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final bool success = await repo.login(event.email, event.password);
        if (success) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure('Login failed'));
        }
      } catch (error) {
        emit(LoginFailure(error.toString().replaceAll('Exception: ', '')));
      }
    });

     
  }
}
