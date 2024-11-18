import 'package:http/http.dart' as http;
import 'package:modelviewlabs_challenge/model/error.dart';
import 'package:modelviewlabs_challenge/model/success.dart';
import 'dart:convert';
import '../utils/retry.dart';

class ApiService {
  final Uri _url =
      Uri.https('desafioflutter-api.modelviewlabs.com', 'validate');
  ApiService();

  Future validatePassword(String password) async {
    return await retry(
      () async {
        final body = json.encode({'password': password});
        final headers = {'Author': 'Davi Reis <daviavr@gmail.com>'};
        final response = await http.post(_url, body: body, headers: headers);

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
}
