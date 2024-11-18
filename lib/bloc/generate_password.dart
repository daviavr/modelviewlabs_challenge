import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modelviewlabs_challenge/data/api_service.dart';
import 'package:modelviewlabs_challenge/model/error.dart';
import 'package:modelviewlabs_challenge/model/password.dart';

class GeneratePasswordEvent {}

abstract class GeneratePasswordState {}

class NoPasswordGenerated extends GeneratePasswordState {}

class CreatingPassword extends GeneratePasswordState {
  final String password;
  CreatingPassword(this.password);
}

class GeneratePasswordBloc
    extends Bloc<GeneratePasswordEvent, GeneratePasswordState> {
  GeneratePasswordBloc() : super(NoPasswordGenerated()) {
    on<GeneratePasswordEvent>(_onCheckGeneratePassword);
  }

  Future<void> _onCheckGeneratePassword(
      GeneratePasswordEvent event, Emitter<GeneratePasswordState> emit) async {
    try {
      ApiService request = ApiService();
      dynamic result = await request.generatePassword();
      emit(CreatingPassword(result.password));
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
