import 'dart:async';

Future<T> retry<T>(
  Future<T> Function() action, {
  int maxRetries = 5,
  Duration delay = const Duration(seconds: 1),
}) async {
  int attempt = 0;

  while (attempt < maxRetries) {
    try {
      final result = await action();
      return result;
    } catch (e) {
      attempt++;
      if (attempt >= maxRetries) {
        rethrow;
      }
      await Future.delayed(delay);
    }
  }

  throw Exception('Retry limit reached');
}
