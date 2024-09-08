import 'package:equatable/equatable.dart';

import 'package:chicpic/models/auth/token.dart';
import 'package:chicpic/models/auth/user_additional.dart';
import 'package:intl/intl.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String username;
  final UserToken tokens;
  final bool isVerified;
  final DateTime? birthdate;
  final UserAdditional? userAdditional;

  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.tokens,
    required this.isVerified,
    this.birthdate,
    this.userAdditional,
  });

  User.fromMap(Map<String, dynamic> userData)
      : id = userData['id'],
        email = userData['email'],
        username = userData['username'],
        isVerified = userData['isVerified'],
        tokens = UserToken.fromJson(userData['tokens']),
        birthdate = userData['birthDate'] != null
            ? DateTime.parse(userData['birthDate'])
            : null,
        userAdditional = userData['additional'] != null
            ? UserAdditional.fromJson(userData['additional'])
            : null;

  User.fromSocialAuthResponse(Map<String, dynamic> socialResponse)
      : tokens = UserToken(
          accessToken: socialResponse['access'],
          refreshToken: socialResponse['refresh'],
        ),
        id = socialResponse['user']['id'],
        email = socialResponse['user']['email'],
        username = socialResponse['user']['username'],
        isVerified = socialResponse['user']['isVerified'],
        birthdate = socialResponse['user']['birthDate'] != null
            ? DateTime.parse(socialResponse['user']['birthDate'])
            : null,
        userAdditional = socialResponse['user']['additional'] != null
            ? UserAdditional.fromJson(socialResponse['user']['additional'])
            : null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'isVerified': isVerified,
      'tokens': tokens.toMap(),
      'birthdate': birthdate != null
          ? DateFormat('yyyy-MM-dd').format(birthdate!)
          : null,
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        isVerified,
        tokens,
        birthdate,
        userAdditional,
      ];

  User copyWith({
    int? id,
    String? email,
    String? username,
    UserToken? tokens,
    bool? isVerified,
    DateTime? birthdate,
    UserAdditional? userAdditional,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        tokens: tokens ?? this.tokens,
        isVerified: isVerified ?? this.isVerified,
        birthdate: birthdate ?? this.birthdate,
        userAdditional: userAdditional ?? this.userAdditional,
      );
}
