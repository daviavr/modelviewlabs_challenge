class PasswordSchema {
  final String password;

  PasswordSchema({required this.password});

  factory PasswordSchema.fromJson(Map<String, dynamic> json) {
    return PasswordSchema(
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
    };
  }
}
