import 'package:equatable/equatable.dart';
import 'package:store_mobile/domain/models/requests/register_request.dart';

class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterUser extends RegisterEvent {
  final RegisterRequest request;

  RegisterUser({required this.request});
}