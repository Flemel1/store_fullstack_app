import 'package:store_mobile/domain/models/user.dart';

class RegisterResponse {
  final int statusCode;
  final User user;

  const RegisterResponse({
    required this.statusCode,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'statusCode': this.statusCode,
      'user': this.user,
    };
  }

  factory RegisterResponse.fromMap(Map<String, dynamic> map) {
    return RegisterResponse(
      statusCode: map['status_code'] as int,
      user: User.fromMap(map['data']),
    );
  }
}