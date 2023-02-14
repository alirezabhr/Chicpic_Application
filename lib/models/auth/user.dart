import 'package:equatable/equatable.dart';
import 'package:chicpic/models/auth/token.dart';

class User extends Equatable {
  final int _id;
  final String _email;
  final String _username;
  final UserToken _tokens;
  late bool _isVerified;

  User.fromMap(Map<String, dynamic> userData)
      : _id = userData['id'],
        _email = userData['email'],
        _username = userData['username'],
        _isVerified = userData['isVerified'],
        _tokens = UserToken.fromJson(userData['tokens']);

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'email': _email,
      'username': _username,
      'isVerified': _isVerified,
      'tokens': _tokens.toMap(),
    };
  }

  int get id => _id;

  String get email => _email;

  String get username => _username;

  bool get isVerified => _isVerified;

  UserToken get tokens => _tokens;

  @override
  List<Object?> get props => [
        _id,
        _email,
        _username,
        _isVerified,
        _tokens,
      ];

  void verify() {
    _isVerified = true;
  }
}
