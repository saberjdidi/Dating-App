class AuthResponse {
  UserAuth? user;
  String? token;

  AuthResponse({this.user, this.token});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserAuth.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class UserAuth {
  String? id;
  String? email;
  String? username;

  UserAuth({this.id, this.email, this.username});

  UserAuth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    return data;
  }
}