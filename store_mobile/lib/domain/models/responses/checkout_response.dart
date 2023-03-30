class CheckoutResponse {
  final int statusCode;
  final String message;

  const CheckoutResponse({
    required this.statusCode,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'status_code': this.statusCode,
      'data': this.message,
    };
  }

  factory CheckoutResponse.fromMap(Map<String, dynamic> map) {
    return CheckoutResponse(
      statusCode: map['status_code'] as int,
      message: map['data'] as String,
    );
  }
}