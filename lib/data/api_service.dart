import 'package:http/http.dart' as http;
import 'package:modelviewlabs_challenge/model/error.dart';
import 'package:modelviewlabs_challenge/model/password.dart';
import 'package:modelviewlabs_challenge/model/success.dart';
import 'dart:convert';
import '../utils/retry.dart';

class ApiService {
  ApiService();
  final headers = {'Author': 'Davi Reis <daviavr@gmail.com>'};

  Future validatePassword(String password) async {
    final Uri url =
        Uri.https('desafioflutter-api.modelviewlabs.com', 'validate');
    final body = json.encode({'password': password});

    return await retry(
      () async {
        final response = await http.post(url, body: body, headers: headers);

        if (response.statusCode == 200 || response.statusCode == 202) {
          final data = json.decode(response.body);
          return ValidationSuccess.fromJson(data);
        } else if (response.statusCode == 400) {
          final data = json.decode(response.body);
          return ErrorResponse.fromJson(data);
        } else {
          throw Exception('Server error: ${response.statusCode}');
        }
      },
    );
  }

  Future generatePassword() async {
    final Uri url = Uri.https('desafioflutter-api.modelviewlabs.com', 'random');

    return await retry(
      () async {
        final response = await http.get(url, headers: headers);

        if (response.statusCode == 200 || response.statusCode == 202) {
          final data = json.decode(response.body);
          return PasswordSchema.fromJson(data);
        } else if (response.statusCode == 400) {
          final data = json.decode(response.body);
          return ErrorResponse.fromJson(data);
        } else {
          throw Exception('Server error: ${response.statusCode}');
        }
      },
    );
  }
}
