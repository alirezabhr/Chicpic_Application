class ResetPasswordData {
  String email;
  String password;
  String password2;

  ResetPasswordData({
    required this.email,
    required this.password,
    required this.password2,
  });

  Map<String, String> toMap() {
    return {
      'email': email,
      'password': password,
      'password2': password2,
    };
  }
}
