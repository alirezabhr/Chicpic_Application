import 'package:equatable/equatable.dart';

class SignupUserData extends Equatable {
  final String username;
  final String email;
  final String password;
  final String password2;

  const SignupUserData({
    required this.username,
    required this.email,
    required this.password,
    required this.password2,
  });

  Map<String, String> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'password2': password2,
    };
  }

  @override
  List<Object?> get props => [username, email, password, password2];
}
