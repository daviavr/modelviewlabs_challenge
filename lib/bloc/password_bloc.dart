import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class PasswordEvent {}

class CheckPasswordEvent extends PasswordEvent {
  final String password;
  CheckPasswordEvent(this.password);
}

abstract class PasswordState {}

class PasswordInitial extends PasswordState {}

class PasswordLoading extends PasswordState {}

class PasswordSuccess extends PasswordState {
  final String message;
  PasswordSuccess(this.message);
}

class ServiceUnavailable extends PasswordState {
  final String error;
  ServiceUnavailable(this.error);
}

class PasswordFailure extends PasswordState {
  final String error;
  PasswordFailure(this.error);
}

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordInitial()) {
    on<CheckPasswordEvent>(_onCheckPasswordEvent);
  }

  Future<void> _onCheckPasswordEvent(
      CheckPasswordEvent event, Emitter<PasswordState> emit) async {
    emit(PasswordLoading());
    const int maxRetries = 5;
    int attempt = 0;
    bool responseReceived = false;

    while (attempt < maxRetries && !responseReceived) {
      try {
        final url =
            Uri.https('desafioflutter-api.modelviewlabs.com', 'validate');
        final response = await http.post(url,
            body: json.encode({"password": event.password}),
            headers: {
              'Content-Type': 'application/json',
              'Author': 'Davi Reis <daviavr@gmail.com>',
            });

        print('$attempt $responseReceived ${response.statusCode}');
        if (response.statusCode == 202) {
          final data = json.decode(response.body);
          responseReceived = true;
          emit(PasswordSuccess(data["message"]));
        } else if (response.statusCode == 400) {
          final data = json.decode(response.body);
          responseReceived = true;
          emit(PasswordFailure(data["errors"][0]));
        } else if (response.statusCode == 502 || response.statusCode == 422) {
          if (attempt >= maxRetries) {
            emit(ServiceUnavailable(
                'Service unavailable. Please try again later.'));
          } //1 second delay before trying to make the request again
          await Future.delayed(const Duration(seconds: 1));
        }
      } catch (e) {
        throw Exception('Error $e');
      }
    }
  }
}
