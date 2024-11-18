class ValidationSuccess {
  final String id;
  final String message;

  ValidationSuccess({required this.id, required this.message});

  factory ValidationSuccess.fromJson(Map<String, dynamic> json) {
    return ValidationSuccess(
      id: json['id'] as String,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
    };
  }
}
