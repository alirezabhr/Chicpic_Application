class UserToken {
  late String accessToken;
  late String refreshToken;

  UserToken({required this.accessToken, required this.refreshToken});

  factory UserToken.fromJson(Map<String, dynamic> jsonData) => UserToken(
        accessToken: jsonData['access'] as String,
        refreshToken: jsonData['refresh'] as String,
      );

  Map<String, dynamic> toMap() {
    return {
      'access': accessToken,
      'refresh': refreshToken,
    };
  }
}
