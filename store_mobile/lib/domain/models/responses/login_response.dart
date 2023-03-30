import 'package:store_mobile/domain/models/user.dart';

class LoginResponse {
  final int status_code;
  final String? errors;
  final String? token;
  final User? user;

  const LoginResponse({
    required this.status_code,
    this.user,
    this.errors,
    this.token
  });

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      status_code: map['status_code'] as int,
      errors: map['data']['message'] == null ? null : map['data']['message'] as String,
      token: map['data']['token'] == null ? null : map['data']['token'] as String,
      user: map['data']['user'] == null ? null :  User.fromMap(map['data']['user']),
    );
  }

}