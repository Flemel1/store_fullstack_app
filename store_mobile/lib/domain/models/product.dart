class Product {
  final int id;
  final String name;
  final String description;
  final String photoUrl;
  final int stocks;
  int pcs;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.stocks,
    this.pcs = 0
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'photo_url': this.photoUrl,
      'stocks': this.stocks,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      photoUrl: map['photo_url'] as String,
      stocks: map['stocks'] as int,
    );
  }

  Product copyWith({
    Product? product,
  }) {
    return Product(
      id: product?.id ?? this.id,
      name: product?.name ?? this.name,
      description: product?.description ?? this.description,
      photoUrl: product?.photoUrl ?? this.photoUrl,
      stocks: product?.stocks ?? this.stocks,
      pcs: product?.pcs ?? this.pcs,
    );
  }
}