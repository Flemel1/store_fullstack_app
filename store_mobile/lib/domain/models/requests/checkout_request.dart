class CheckoutRequest {
  final List<CheckoutItem> checkoutProducts;

  const CheckoutRequest({
    required this.checkoutProducts,
  });

  Map<String, dynamic> toMap() {
    return {
      'products': this.checkoutProducts.map<dynamic>((item) => item.toMap()).toList(),
    };
  }

  factory CheckoutRequest.fromMap(Map<String, dynamic> map) {
    return CheckoutRequest(
      checkoutProducts: map['products'] as List<CheckoutItem>,
    );
  }
}

class CheckoutItem {
  final int id;
  final int pcs;

  const CheckoutItem({
    required this.id,
    required this.pcs,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'pcs': this.pcs,
    };
  }

  factory CheckoutItem.fromMap(Map<String, dynamic> map) {
    return CheckoutItem(
      id: map['id'] as int,
      pcs: map['pcs'] as int,
    );
  }
}