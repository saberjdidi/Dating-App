class AuthData {
  final String? email;
  final String? token; // si le backend renvoie token, sinon null

  AuthData({this.email, this.token});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      email: json['email'] as String?,
      token: json['token'] as String?,
    );
  }
}