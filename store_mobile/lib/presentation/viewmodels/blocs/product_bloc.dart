import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mobile/domain/repositories/remote/remotre_repository.dart';
import 'package:store_mobile/presentation/viewmodels/events/product_event.dart';
import 'package:store_mobile/presentation/viewmodels/states/product_state.dart';
import 'package:store_mobile/utils/const/enum.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final RemoteRepository _repository;


  ProductBloc({required RemoteRepository repository})
      : _repository = repository,
        super(const ProductState()) {
    on<GetProduct>(_fetchProduct);
    on<AddNewProduct>(_addNewProduct);
    on<RemoveProduct>(_removeProduct);
    on<IncreasedProduct>(_increaseProduct);
    on<DecreasedProduct>(_decreaseProduct);
    on<ResetCartProducts>(_resetCart);
  }

  void _fetchProduct(GetProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final res = await _repository.fetchProduct(id: event.id);
      if (res.statusCode == 200) {
        emit(state.copyWith(status: Status.success, product: res.product));
      } else {
        emit(state.copyWith(status: Status.error, product: null));
      }
    } catch (exception) {
      print(exception.toString());
      emit(state.copyWith(status: Status.error, product: null));
    }
  }

  void _resetCart(ResetCartProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(products: []));
  }

  void _addNewProduct(AddNewProduct event, Emitter<ProductState> emit) {
    event.product.pcs += 1;
    final products = [...state.products, event.product];
    emit(state.copyWith(products: products, product: event.product));
  }

  void _removeProduct(RemoveProduct event, Emitter<ProductState> emit) {
    final products = [...state.products];
    products.removeWhere((product) => product.id == event.product.id);
    final product = event.product.copyWith(product: event.product);
    product.pcs = 0;
    emit(state.copyWith(products: products, product: product));
  }

  void _increaseProduct(IncreasedProduct event, Emitter<ProductState> emit) {
    final products = [...state.products];
    final index = products.indexWhere((product) => product.id == event.product.id);
    final product = products[index].copyWith(product: products[index]);
    product.pcs += 1;
    products[index] = product;
    emit(state.copyWith(products: products, product: product));
  }

  void _decreaseProduct(DecreasedProduct event, Emitter<ProductState> emit) {
    final products = [...state.products];
    final index = products.indexWhere((product) => product.id == event.product.id);
    final product = products[index].copyWith(product: products[index]);
    if (product.pcs > 0) {
      product.pcs -= 1;
      products[index] = product;
      emit(state.copyWith(products: products, product: product));
    }
  }
}
