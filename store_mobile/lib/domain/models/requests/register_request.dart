import 'dart:io';
import 'package:store_mobile/domain/models/user.dart';

class RegisterRequest {
  final File file;
  final User user;

  const RegisterRequest({
    required this.user,
    required this.file,
  });

  Map<String, dynamic> toMap() {
    return {...this.user.toMap(), 'photo': file};
  }
}