import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/password_bloc.dart';

class PasswordResultScreen extends StatelessWidget {
  const PasswordResultScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Password Result')),
      body: BlocBuilder<PasswordBloc, PasswordState>(
        builder: (context, state) {
          if (state is PasswordSuccess) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No result yet.'));
          }
        },
      ),
    );
  }
}
