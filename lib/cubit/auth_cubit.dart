import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  // SIGNUP: Save email & password
  void signup(String email, String password) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();

    // Save email & password in SharedPreferences
    await prefs.setString('savedEmail', email);
    await prefs.setString('savedPassword', password);
    await prefs.setBool('isLoggedIn', true); // Auto-login after signup

    emit(AuthSuccessState());
  }

  // LOGIN: Check credentials against saved email & password
  void login(String email, String password) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('savedEmail');
    final savedPassword = prefs.getString('savedPassword');

    if (email == savedEmail && password == savedPassword) {
      await prefs.setBool('isLoggedIn', true); // set login flag
      emit(AuthSuccessState());
    } else {
      emit(AuthFailureState('Invalid Email or Password'));
    }
  }

  // LOGOUT
  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Keep credentials, just logout
    emit(AuthInitialState());
  }

  // AUTO-LOGIN CHECK
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
