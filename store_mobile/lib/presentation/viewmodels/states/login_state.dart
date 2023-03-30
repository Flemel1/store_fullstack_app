import 'package:equatable/equatable.dart';
import 'package:store_mobile/utils/const/enum.dart';

class LoginState extends Equatable {
  final String? token;
  final String? message;
  final bool isLogin;
  final Status status;
  @override
  List<Object?> get props => [token,isLogin, status];

  const LoginState({this.token, this.isLogin = false, this.status = Status.initial, this.message});

  LoginState copyWith({
    String? token,
    String? message,
    bool? isLogin,
    Status? status,
  }) {
    return LoginState(
      token: token,
      isLogin: isLogin ?? this.isLogin,
      status: status ?? this.status,
      message: message
    );
  }
}