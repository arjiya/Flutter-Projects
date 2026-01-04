import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());


  void signup(String email, String password) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('savedEmail', email);
    await prefs.setString('savedPassword', password);
    await prefs.setBool('isLoggedIn', true); 

    emit(AuthSuccessState());
  }

  void login(String email, String password) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('savedEmail');
    final savedPassword = prefs.getString('savedPassword');

    if (email == savedEmail && password == savedPassword) {
      await prefs.setBool('isLoggedIn', true); 
      emit(AuthSuccessState());
    } else {
      emit(AuthFailureState('Invalid Email or Password'));
    }
  }


  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); 
    emit(AuthInitialState());
  }


  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      emit(AuthSuccessState());
    } else {
      emit(AuthInitialState());
    }
  }
}
