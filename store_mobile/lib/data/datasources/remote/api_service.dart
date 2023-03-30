import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:store_mobile/domain/models/requests/checkout_request.dart';
import 'package:store_mobile/domain/models/requests/login_request.dart';
import 'package:store_mobile/domain/models/requests/register_request.dart';
import 'package:store_mobile/domain/models/responses/checkout_response.dart';
import 'package:store_mobile/domain/models/responses/login_response.dart';
import 'package:store_mobile/domain/models/responses/product_response.dart';
import 'package:store_mobile/domain/models/responses/register_response.dart';
import 'package:store_mobile/utils/const/string.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.MapSerializable)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/auth/login')
  Future<HttpResponse<LoginResponse>> login(
      {@Body() required LoginRequest request});

  @POST('/auth/register')
  @MultiPart()
  Future<HttpResponse<RegisterResponse>> register(
      {@Part(name: 'name') required String name,
        @Part(name: 'email') required String email,
        @Part(name: 'address') required String address,
        @Part(name: 'phone') required String phone,
        @Part(name: 'password') required String password,
        @Part(fileName: 'photo', name: 'photo') required File fileImage});

  @GET('/products')
  @Headers({
    'accept' : 'application/json'
  })
  Future<HttpResponse<GetProductsReponse>> fetchProducts(
      @Header('Authorization') String token);

  @GET('/products/{product}')
  Future<HttpResponse<GetProductResponse>> fetchProduct(
      @Header('Authorization') String token, @Path('product') int id);

  @PUT('/products/buy')
  Future<HttpResponse<CheckoutResponse>> checkoutProducts(
      @Header('Authorization') String token,
      {@Body() required CheckoutRequest request});
}
