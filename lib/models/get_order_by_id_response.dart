// To parse this JSON data, do
//
//     final getOrderByIdResponse = getOrderByIdResponseFromJson(jsonString);

import 'dart:convert';

GetOrderByIdResponse getOrderByIdResponseFromJson(String str) => GetOrderByIdResponse.fromJson(json.decode(str));

String getOrderByIdResponseToJson(GetOrderByIdResponse data) => json.encode(data.toJson());

class GetOrderByIdResponse {
    String? message;
    OrderItems? response;

    GetOrderByIdResponse({
        this.message,
        this.response,
    });

    factory GetOrderByIdResponse.fromJson(Map<String, dynamic> json) => GetOrderByIdResponse(
        message: json["message"],
        response: json["response"] == null ? null : OrderItems.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "response": response?.toJson(),
    };
}

class OrderItems {
    String? id;
    String? userId;
    String? status;
    String? date;
    int? total;
    List<Item>? items;

    OrderItems({
        this.id,
        this.userId,
        this.status,
        this.date,
        this.total,
        this.items,
    });

    factory OrderItems.fromJson(Map<String, dynamic> json) => OrderItems(
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
