import 'package:equatable/equatable.dart';
import 'package:store_mobile/domain/models/product.dart';
import 'package:store_mobile/utils/const/enum.dart';

class ProductState extends Equatable {
  final List<Product> products;
  final Product? product;
  final Status status;

  const ProductState({this.status = Status.initial, this.product, this.products = const []});

  @override
  List<Object?> get props => [product, products, status];

  ProductState copyWith({
    List<Product>? products,
    Product? product,
    Status? status,
  }) {
    return ProductState(
      products: products ?? this.products,
      product: product ?? this.product,
      status: status ?? this.status,
    );
  }
}
