
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/auth_cubit.dart';
import 'cubit/auth/auth_state.dart';
import 'cubit/product_cubit.dart';
import 'services/api_service.dart';
import 'Home/home_screen.dart';
import 'Home/login_screen.dart';
import 'Home/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiService = ApiService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()..checkLoginStatus()),
        BlocProvider(create: (_) => ProductCubit(apiService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (_) => const HomeScreen(),
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
       
      },
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
