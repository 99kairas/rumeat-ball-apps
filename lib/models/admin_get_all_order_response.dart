// To parse this JSON data, do
//
//     final adminGetAllOrderResponse = adminGetAllOrderResponseFromJson(jsonString);

import 'dart:convert';

AdminGetAllOrderResponse adminGetAllOrderResponseFromJson(String str) =>
    AdminGetAllOrderResponse.fromJson(json.decode(str));

String adminGetAllOrderResponseToJson(AdminGetAllOrderResponse data) =>
    json.encode(data.toJson());

class AdminGetAllOrderResponse {
  String message;
  List<AdminAllOrderResponse> response;

  AdminGetAllOrderResponse({
    required this.message,
    required this.response,
  });

  factory AdminGetAllOrderResponse.fromJson(Map<String, dynamic> json) =>
      AdminGetAllOrderResponse(
        message: json["message"],
        response: List<AdminAllOrderResponse>.from(
            json["response"].map((x) => AdminAllOrderResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class AdminAllOrderResponse {
  String id;
  String userId;
  UserName userName;
  Status status;
  String date;
  int total;
  List<OrderItem> items;

  AdminAllOrderResponse({
    required this.id,
    required this.userId,
    required this.userName,
    required this.status,
    required this.date,
    required this.total,
    required this.items,
  });

  factory AdminAllOrderResponse.fromJson(Map<String, dynamic> json) =>
      AdminAllOrderResponse(
        id: json["id"],
        userId: json["user_id"],
        userName: userNameValues.map[json["user_name"]] ?? UserName.USERNAME,
        status: statusValues.map[json["status"]] ?? Status.SUCCESSED,
        date: json["date"],
        total: json["total"],
        items: List<OrderItem>.from(
            json["items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userNameValues.reverse[userName],
        "status": statusValues.reverse[status],
        "date": date,
        "total": total,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class OrderItem {
  String menuId;
  int quantity;
  int pricePerItem;
  int totalPrice;

  OrderItem({
    required this.menuId,
    required this.quantity,
    required this.pricePerItem,
    required this.totalPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        menuId: json["menu_id"],
        quantity: json["quantity"],
        pricePerItem: json["price_per_item"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "quantity": quantity,
        "price_per_item": pricePerItem,
        "total_price": totalPrice,
      };
}

enum Status { CART, PROCESSED, SUCCESSED }

final statusValues = EnumValues({
  "cart": Status.CART,
  "processed": Status.PROCESSED,
  "success": Status.SUCCESSED,
});

enum UserName { USERNAME }

final userNameValues = EnumValues({"Username": UserName.USERNAME});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
