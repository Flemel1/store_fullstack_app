import 'package:equatable/equatable.dart';
import 'package:store_mobile/domain/models/requests/checkout_request.dart';

class CheckoutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckoutProducts extends CheckoutEvent {
  final CheckoutRequest request;

  CheckoutProducts({required this.request});
}