class ErrorResponse {
  final String message;
  final List<String> errors;

  ErrorResponse({required this.message, required this.errors});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'] as String,
      errors: (json['errors'] as List).map((s) => s.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'errors': errors,
    };
  }
}
