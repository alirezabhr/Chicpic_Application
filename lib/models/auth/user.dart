import 'package:equatable/equatable.dart';

import 'package:chicpic/models/auth/token.dart';
import 'package:chicpic/models/auth/user_additional.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String username;
  final UserToken tokens;
  final bool isVerified;
  final UserAdditional? userAdditional;

  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.tokens,
    required this.isVerified,
    this.userAdditional,
  });

  User.fromMap(Map<String, dynamic> userData)
      : id = userData['id'],
        email = userData['email'],
        username = userData['username'],
        isVerified = userData['isVerified'],
        tokens = UserToken.fromJson(userData['tokens']),
        userAdditional = userData['additional'] != null
            ? UserAdditional.fromJson(userData['additional'])
            : null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'isVerified': isVerified,
      'tokens': tokens.toMap(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        isVerified,
        tokens,
        userAdditional,
      ];

  User copyWith({
    int? id,
    String? email,
    String? username,
    UserToken? tokens,
    bool? isVerified,
    UserAdditional? userAdditional,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        tokens: tokens ?? this.tokens,
        isVerified: isVerified ?? this.isVerified,
        userAdditional: userAdditional ?? this.userAdditional,
      );
}
