import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modelviewlabs_challenge/views/password_result.dart';

import '../bloc/password_bloc.dart';

class PasswordInputScreen extends StatelessWidget {
  PasswordInputScreen({super.key});
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(builder: (context, state) {
      List<Text> errorText = <Text>[];
      Widget progress = Container();

      if (state is PasswordLoading) {
        progress = const CircularProgressIndicator();
      } else if (state is PasswordSuccess) {
        return const PasswordResultScreen();
      } else if (state is PasswordFailure) {
        for (var error in state.error) {
          errorText.add(Text(error, style: const TextStyle(color: Colors.red)));
        }
      }
      return Scaffold(
        appBar: AppBar(title: const Text('Insira a senha')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final password = _passwordController.text.trim();
                      if (password.isNotEmpty) {
                        BlocProvider.of<PasswordBloc>(context)
                            .add(CheckPasswordEvent(password));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Senha nao pode estar vazia')),
                        );
                      }
                    },
                    child: const Text('Validar senha'),
                  ),
                  progress
                ],
              ),
              ...errorText
            ],
          ),
        ),
      );
    });
  }
}
