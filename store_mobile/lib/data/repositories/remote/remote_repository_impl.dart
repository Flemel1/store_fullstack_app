import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_mobile/data/datasources/remote/api_service.dart';
import 'package:store_mobile/domain/models/requests/checkout_request.dart';
import 'package:store_mobile/domain/models/requests/login_request.dart';
import 'package:store_mobile/domain/models/requests/register_request.dart';
import 'package:store_mobile/domain/models/responses/checkout_response.dart';
import 'package:store_mobile/domain/models/responses/login_response.dart';
import 'package:store_mobile/domain/models/responses/product_response.dart';
import 'package:store_mobile/domain/models/responses/register_response.dart';
import 'package:store_mobile/domain/repositories/remote/remotre_repository.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final ApiService _apiService;
  final FlutterSecureStorage _storage;

  RemoteRepositoryImpl(this._apiService, this._storage);

  @override
  Future<LoginResponse> login({required LoginRequest request}) async {
    try {
      final res = await _apiService.login(request: request);
      if (res.response.statusCode == 200) {
        return res.data;
      } else {
        return res.data;
      }
    } on DioError catch (ex) {
      throw ex;
    }
  }

  @override
  Future<GetProductsReponse> fetchProducts() async {
    try {
      final String token = await _storage.read(key: 'jwt') ?? 'token';
      final res = await _apiService.fetchProducts('Bearer $token');
      if (res.response.statusCode == 200) {
        return res.data;
      } else {
        return res.data;
      }
    } catch (exception) {
      throw Exception(exception.toString());
    }
  }

  @override
  Future<GetProductResponse> fetchProduct({required int id}) async {
    try {
      final String token = await _storage.read(key: 'jwt') ?? 'token';
      final res = await _apiService.fetchProduct('Bearer $token', id);
      if (res.response.statusCode == 200) {
        return res.data;
      } else {
        return res.data;
      }
    } catch (exception) {
      throw Exception(exception.toString());
    }
  }

  @override
  Future<CheckoutResponse> checkoutProducts(
      {required CheckoutRequest request}) async {
    try {
      final String token = await _storage.read(key: 'jwt') ?? 'token';
      final res =
          await _apiService.checkoutProducts('Bearer $token', request: request);
      if (res.response.statusCode == 200) {
        return res.data;
      } else {
        return res.data;
      }
    } catch (exception) {
      throw Exception(exception.toString());
    }
  }

  @override
  Future<RegisterResponse> register({required RegisterRequest request}) async {
    try {
      final res = await _apiService.register(
          name: request.user.name,
          email: request.user.email,
          password: request.user.password!,
          address: request.user.address,
          phone: request.user.phone,
          fileImage: request.file);
      if (res.response.statusCode == 200) {
        return res.data;
      } else {
        return res.data;
      }
    } catch (exception) {
      throw Exception(exception.toString());
    }
  }
}
