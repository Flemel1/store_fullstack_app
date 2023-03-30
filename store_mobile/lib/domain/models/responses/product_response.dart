import 'package:store_mobile/domain/models/product.dart';

class GetProductsReponse {
  final int statusCode;
  final List<Product> products;

  const GetProductsReponse({
    required this.statusCode,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'status_code': this.statusCode,
      'products': this.products,
    };
  }

  factory GetProductsReponse.fromMap(Map<String, dynamic> map) {
    List<Product> products = [];
    final extractedProducts = map['data'] as List<dynamic>;
    products = extractedProducts.map<Product>((product) => Product.fromMap(product)).toList();
    return GetProductsReponse(
      statusCode: map['status_code'] as int,
      products: products,
    );
  }
}

class GetProductResponse {
  final int statusCode;
  final Product product;

  const GetProductResponse({
    required this.statusCode,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return {
      'status_code': this.statusCode,
      'data': this.product,
    };
  }

  factory GetProductResponse.fromMap(Map<String, dynamic> map) {
    return GetProductResponse(
      statusCode: map['status_code'] as int,
      product: Product.fromMap(map['data']),
    );
  }

}