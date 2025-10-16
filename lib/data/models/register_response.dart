class RegisterResponse {
  final String? email;

  RegisterResponse({this.email});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      email: json['email'] as String?,
    );
  }
}