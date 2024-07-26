// order_model.dart
class TransactionModel {
  final String orderId;
  final double totalAmount;
  final String paymentUrl;

  TransactionModel({required this.orderId, required this.totalAmount, required this.paymentUrl});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      orderId: json['order_id'],
      totalAmount: json['total_amount'].toDouble(),
      paymentUrl: json['payment_url'],
    );
  }
}
