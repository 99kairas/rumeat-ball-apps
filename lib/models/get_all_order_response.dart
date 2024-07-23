// To parse this JSON data, do
//
//     final getAllOrderResponse = getAllOrderResponseFromJson(jsonString);

import 'dart:convert';

GetAllOrderResponse getAllOrderResponseFromJson(String str) => GetAllOrderResponse.fromJson(json.decode(str));

String getAllOrderResponseToJson(GetAllOrderResponse data) => json.encode(data.toJson());

class GetAllOrderResponse {
    String? message;
    Response? response;

    GetAllOrderResponse({
        this.message,
        this.response,
    });

    factory GetAllOrderResponse.fromJson(Map<String, dynamic> json) => GetAllOrderResponse(
        message: json["message"],
        response: json["response"] == null ? null : Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "response": response?.toJson(),
    };
}

class Response {
    List<Order>? orders;

    Response({
        this.orders,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
    };
}

class Order {
    String? id;
    String? userId;
    String? status;
    String? date;
    int? total;
    List<Item>? items;

    Order({
        this.id,
        this.userId,
        this.status,
        this.date,
        this.total,
        this.items,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        status: json["status"],
        date: json["date"],
        total: json["total"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "status": status,
        "date": date,
        "total": total,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    String? menuId;
    String? userId;
    int? quantity;
    int? pricePerItem;
    int? totalPrice;

    Item({
        this.menuId,
        this.userId,
        this.quantity,
        this.pricePerItem,
        this.totalPrice,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        menuId: json["menu_id"],
        userId: json["user_id"],
        quantity: json["quantity"],
        pricePerItem: json["price_per_item"],
        totalPrice: json["total_price"],
    );

    Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "user_id": userId,
        "quantity": quantity,
        "price_per_item": pricePerItem,
        "total_price": totalPrice,
    };
}
