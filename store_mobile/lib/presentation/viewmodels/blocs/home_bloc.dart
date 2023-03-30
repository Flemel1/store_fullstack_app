import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mobile/domain/repositories/remote/remotre_repository.dart';
import 'package:store_mobile/presentation/viewmodels/events/home_event.dart';
import 'package:store_mobile/presentation/viewmodels/states/home_state.dart';
import 'package:store_mobile/utils/const/enum.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RemoteRepository _repository;


  HomeBloc({required RemoteRepository repository})
      : _repository = repository,
        super(const HomeState()) {
    on<FetchProducts>(_fetchProducts);
  }

  void _fetchProducts(FetchProducts event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading, products: []));
    try {
      final res = await _repository.fetchProducts();
      if (res.statusCode == 200) {
        emit(state.copyWith(status: Status.success, products: res.products));
      } else {
        emit(state.copyWith(status: Status.error, products: []));
      }
    } catch (exception) {
      print(exception.toString());
      emit(state.copyWith(status: Status.error, products: []));
    }
  }
}
