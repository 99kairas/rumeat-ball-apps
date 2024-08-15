// To parse this JSON data, do
//
//     final adminGetAllTransaction = adminGetAllTransactionFromJson(jsonString);

import 'dart:convert';

AdminGetAllTransaction adminGetAllTransactionFromJson(String str) =>
    AdminGetAllTransaction.fromJson(json.decode(str));

String adminGetAllTransactionToJson(AdminGetAllTransaction data) =>
    json.encode(data.toJson());

class AdminGetAllTransaction {
  String message;
  List<AllTransaction> response;

  AdminGetAllTransaction({
    required this.message,
    required this.response,
  });

  factory AdminGetAllTransaction.fromJson(Map<String, dynamic> json) =>
      AdminGetAllTransaction(
        message: json["message"],
        response: List<AllTransaction>.from(
            json["response"].map((x) => AllTransaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class AllTransaction {
  String id;
  String orderId;
  int totalPrice;
  String paymentUrl;
  String status;
  String userId;
  String userName;
  String date;

  AllTransaction({
    required this.id,
    required this.orderId,
    required this.totalPrice,
    required this.paymentUrl,
    required this.status,
    required this.userId,
    required this.userName,
    required this.date,
  });

  factory AllTransaction.fromJson(Map<String, dynamic> json) => AllTransaction(
        id: json["id"],
        orderId: json["order_id"],
        totalPrice: json["total_price"],
        paymentUrl: json["payment_url"],
        status: json["status"],
        userId: json["user_id"],
        userName: json["user_name"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "total_price": totalPrice,
        "payment_url": paymentUrl,
        "status": status,
        "user_id": userId,
        "user_name": userName,
        "date": date,
      };
}
