import 'package:equatable/equatable.dart';
import 'package:store_mobile/domain/models/product.dart';

class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProduct extends ProductEvent {
  final int id;

  GetProduct({required this.id});
}

class AddNewProduct extends ProductEvent {
  final Product product;

  AddNewProduct({required this.product});
}

class RemoveProduct extends ProductEvent {
  final Product product;

  RemoveProduct({required this.product});
}

class IncreasedProduct extends ProductEvent {
  final Product product;

  IncreasedProduct({required this.product});
}

class DecreasedProduct extends ProductEvent {
  final Product product;

  DecreasedProduct({required this.product});
}

class ResetCartProducts extends ProductEvent {}