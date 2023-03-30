import 'package:store_mobile/domain/models/requests/checkout_request.dart';
import 'package:store_mobile/domain/models/requests/login_request.dart';
import 'package:store_mobile/domain/models/requests/register_request.dart';
import 'package:store_mobile/domain/models/responses/checkout_response.dart';
import 'package:store_mobile/domain/models/responses/login_response.dart';
import 'package:store_mobile/domain/models/responses/product_response.dart';
import 'package:store_mobile/domain/models/responses/register_response.dart';

abstract class RemoteRepository {
  Future<LoginResponse> login({required LoginRequest request});
  Future<GetProductsReponse> fetchProducts();
  Future<GetProductResponse> fetchProduct({required int id});
  Future<CheckoutResponse> checkoutProducts({required CheckoutRequest request});
  Future<RegisterResponse> register({required RegisterRequest request});
}