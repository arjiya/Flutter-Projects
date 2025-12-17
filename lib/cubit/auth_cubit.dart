
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:classico/cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  void login(String email, String password) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'abc@gmail.com' && password == '123') {
      emit(AuthSuccessState());
    } else {
      emit(AuthFailureState('Invalid Email or Password'));
    }
  } 

  void signup(String email, String password) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 2));

    emit(AuthSuccessState());
  }

  void logout() {
    emit(AuthInitialState());
  }
}
