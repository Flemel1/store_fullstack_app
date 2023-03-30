import 'package:equatable/equatable.dart';
import 'package:store_mobile/domain/models/product.dart';
import 'package:store_mobile/utils/const/enum.dart';

class HomeState extends Equatable {
  final List<Product>? products;
  final Status status;

  const HomeState({this.status = Status.initial, List<Product>? products})
      : products = products ?? const [];

  @override
  List<Object?> get props => [products, status];

  HomeState copyWith({
    List<Product>? products,
    Status? status,
  }) {
    return HomeState(
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }
}
