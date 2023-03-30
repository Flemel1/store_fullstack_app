import 'package:equatable/equatable.dart';
import 'package:store_mobile/domain/models/requests/login_request.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnLogin extends LoginEvent {
  final LoginRequest request;

  OnLogin({required this.request});
}