import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mobile/domain/repositories/remote/remotre_repository.dart';
import 'package:store_mobile/presentation/viewmodels/events/checkout_event.dart';
import 'package:store_mobile/presentation/viewmodels/states/checkout_state.dart';
import 'package:store_mobile/utils/const/enum.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final RemoteRepository _repository;

  CheckoutBloc({required RemoteRepository repository})
      : _repository = repository,
        super(const CheckoutState()) {
    on<CheckoutProducts>(_checkoutProducts);
  }

  void _checkoutProducts(
      CheckoutProducts event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final res = await _repository.checkoutProducts(request: event.request);
      if (res.statusCode == 200) {
        emit(state.copyWith(status: Status.success, response: res));
      } else {
        emit(state.copyWith(status: Status.error, response: null));
      }
    } catch (exception) {
      print(exception.toString());
      emit(state.copyWith(status: Status.error, response: null));
    }
  }
}
