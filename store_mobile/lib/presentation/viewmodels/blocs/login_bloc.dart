import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_mobile/domain/models/responses/login_response.dart';
import 'package:store_mobile/domain/repositories/remote/remotre_repository.dart';
import 'package:store_mobile/presentation/viewmodels/events/login_event.dart';
import 'package:store_mobile/presentation/viewmodels/states/login_state.dart';
import 'package:store_mobile/utils/const/enum.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RemoteRepository _repository;
  final FlutterSecureStorage _storage;

  LoginBloc(
      {required RemoteRepository repository,
      required FlutterSecureStorage storage})
      : _repository = repository,
        _storage = storage,
        super(const LoginState()) {
    on<OnLogin>(_login);
  }

  void _login(OnLogin event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
        status: Status.loading, token: null, isLogin: false, message: null));
    try {
      final res = await _repository.login(request: event.request);
      if (res.status_code == 200) {
        await _storage.write(key: 'jwt', value: res.token);
        await _storage.write(key: 'user_name', value: res.user!.name);
        await _storage.write(key: 'user_photo', value: res.user!.photoUrl);
        emit(state.copyWith(
            isLogin: true,
            token: res.token,
            status: Status.success,
            message: null));
      } else if (res.status_code == 401) {
        emit(state.copyWith(
            status: Status.error,
            token: null,
            isLogin: false,
            message: res.errors));
      } else {
        emit(state.copyWith(
            status: Status.error, token: null, isLogin: false, message: null));
      }
    } on DioError catch (exception) {
      if (exception.response!.statusCode == 401) {

        emit(state.copyWith(
            status: Status.error, token: null, isLogin: false, message: exception.response?.data['data']['message']));
      } else {
        emit(state.copyWith(
            status: Status.error, token: null, isLogin: false, message: null));
      }
    } catch (exception) {
      print(exception.toString());
    }
  }
}
