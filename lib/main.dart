import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modelviewlabs_challenge/views/password_input.dart';
import 'bloc/password_bloc.dart';

void main() {
  runApp(const PasswordCheckerApp());
}

class PasswordCheckerApp extends StatelessWidget {
  const PasswordCheckerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PasswordBloc>(
      create: (_) => PasswordBloc(),
      child: MaterialApp(
          title: 'Password Checker',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: PasswordInputScreen()),
    );
  }
}
