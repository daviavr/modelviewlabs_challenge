import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/password_bloc.dart';

void main() {
  runApp(PasswordCheckerApp());
}

class PasswordCheckerApp extends StatelessWidget {
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

class PasswordInputScreen extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final password = _passwordController.text.trim();
                if (password.isNotEmpty) {
                  BlocProvider.of<PasswordBloc>(context)
                      .add(CheckPasswordEvent(password));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PasswordResultScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password cannot be empty')),
                  );
                }
              },
              child: Text('Check Password'),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Password Result')),
      body: BlocBuilder<PasswordBloc, PasswordState>(
        builder: (context, state) {
          if (state is PasswordLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PasswordSuccess) {
            return Center(child: Text(state.message));
          } else if (state is PasswordFailure) {
            return Center(
                child: Text(state.error, style: TextStyle(color: Colors.red)));
          } else {
            return Center(child: Text('No result yet.'));
          }
        },
      ),
    );
  }
}
