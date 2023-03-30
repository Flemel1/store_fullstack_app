import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:store_mobile/data/datasources/remote/api_service.dart';
import 'package:store_mobile/domain/repositories/remote/remotre_repository.dart';

import 'data/repositories/remote/remote_repository_impl.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  const storage = FlutterSecureStorage();
  final dio = Dio();

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<FlutterSecureStorage>(storage);

  locator.registerSingleton<ApiService>(
    ApiService(locator<Dio>()),
  );

  locator.registerSingleton<RemoteRepository>(
      RemoteRepositoryImpl(locator<ApiService>(), locator<FlutterSecureStorage>()));
}