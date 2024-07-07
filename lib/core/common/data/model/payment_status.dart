class PaymentStatus {
  final String id;
  final String status;
  final int amount;
  final String currency;

  PaymentStatus({
    required this.id,
    required this.status,
    required this.amount,
    required this.currency,
  });

  factory PaymentStatus.fromJson(Map<String, dynamic> json) {
    return PaymentStatus(
      id: json['id'],
      status: json['status'],
      amount: json['amount'],
      currency: json['currency'],
    );
  }
}