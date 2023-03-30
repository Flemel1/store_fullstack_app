import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mobile/domain/repositories/remote/remotre_repository.dart';
import 'package:store_mobile/presentation/viewmodels/events/register_event.dart';
import 'package:store_mobile/presentation/viewmodels/states/register_state.dart';
import 'package:store_mobile/utils/const/enum.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RemoteRepository _repository;

  RegisterBloc({required RemoteRepository repository})
      : _repository = repository,
        super(const RegisterState()) {
    on<RegisterUser>(_registerUser);
  }

  void _registerUser(
      RegisterUser event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final res = await _repository.register(request: event.request);
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