class LoginUserData {
  String username;
  String password;

  LoginUserData({required this.username, required this.password});

  Map<String, String> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
}