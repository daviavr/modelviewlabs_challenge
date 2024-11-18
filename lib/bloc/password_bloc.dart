import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modelviewlabs_challenge/data/api_service.dart';
import 'package:modelviewlabs_challenge/model/error.dart';
import 'package:modelviewlabs_challenge/model/success.dart';

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

class PasswordFailure extends PasswordState {
  final List<String> error;
  PasswordFailure(this.error);
}

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordInitial()) {
    on<CheckPasswordEvent>(_onCheckPasswordEvent);
  }

  Future<void> _onCheckPasswordEvent(
      CheckPasswordEvent event, Emitter<PasswordState> emit) async {
    emit(PasswordLoading());

    try {
      ApiService request = ApiService();
      dynamic result = await request.validatePassword(event.password);
      if (result is ValidationSuccess) {
        emit(PasswordSuccess(result.message));
      } else if (result is ErrorResponse) {
        emit(PasswordFailure(result.errors));
      } else {
        emit(PasswordFailure(["Unkown Errror"]));
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
