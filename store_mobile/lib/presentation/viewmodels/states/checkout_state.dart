import 'package:equatable/equatable.dart';
import 'package:store_mobile/domain/models/responses/checkout_response.dart';
import 'package:store_mobile/utils/const/enum.dart';

class CheckoutState extends Equatable {
  final CheckoutResponse? response;
  final Status status;

  const CheckoutState({this.status = Status.initial, this.response});

  @override
  List<Object?> get props => [response, status];

  CheckoutState copyWith({
    CheckoutResponse? response,
    Status? status,
  }) {
    return CheckoutState(
      response: response ?? this.response,
      status: status ?? this.status,
    );
  }
}