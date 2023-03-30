import 'package:equatable/equatable.dart';
import 'package:store_mobile/domain/models/responses/register_response.dart';
import 'package:store_mobile/utils/const/enum.dart';

class RegisterState extends Equatable {
  final RegisterResponse? response;
  final Status? status;

  const RegisterState({this.response, this.status = Status.initial});

  @override
  List<Object?> get props => [response, status];

  RegisterState copyWith({
    RegisterResponse? response,
    Status? status,
  }) {
    return RegisterState(
      response: response ?? this.response,
      status: status ?? this.status,
    );
  }
}