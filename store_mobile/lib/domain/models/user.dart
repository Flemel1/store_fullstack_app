class User {
  final String name;
  final String email;
  final String address;
  final String phone;
  final String? photoUrl;
  final String? password;

  const User({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    this.photoUrl,
    this.password
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'password': this.password,
      'address': this.address,
      'phone': this.phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      photoUrl: map['photo_url'] as String,
    );
  }
}