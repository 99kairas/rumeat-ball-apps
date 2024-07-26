import 'dart:convert';

GetDetailsOrderHistoryResponse getDetailsOrderHistoryResponseFromJson(String str) => GetDetailsOrderHistoryResponse.fromJson(json.decode(str));

String getDetailsOrderHistoryResponseToJson(GetDetailsOrderHistoryResponse data) => json.encode(data.toJson());

class GetDetailsOrderHistoryResponse {
    String? message;
    DetailsOrderHistory? response;

    GetDetailsOrderHistoryResponse({
        this.message,
        this.response,
    });

    factory GetDetailsOrderHistoryResponse.fromJson(Map<String, dynamic> json) => GetDetailsOrderHistoryResponse(
        message: json["message"],
        response: json["response"] == null ? null : DetailsOrderHistory.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "response": response?.toJson(),
    };
}

class DetailsOrderHistory {
    String? id;
    String? userId;
    String? status;
    String? date;
    int? total;
    List<DetailsOrderHistoryItems>? items;

    DetailsOrderHistory({
        this.id,
        this.userId,
        this.status,
        this.date,
        this.total,
        this.items,
    });

    factory DetailsOrderHistory.fromJson(Map<String, dynamic> json) => DetailsOrderHistory(
        id: json["id"],
        userId: json["user_id"],
        status: json["status"],
        date: json["date"],
        total: json["total"],
        items: json["items"] == null ? [] : List<DetailsOrderHistoryItems>.from(json["items"].map((x) => DetailsOrderHistoryItems.fromJson(x))),
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

class DetailsOrderHistoryItems {
    String? menuId;
    String? userId;
    int quantity;
    int? pricePerItem;
    int? totalPrice;

    DetailsOrderHistoryItems({
        this.menuId,
        this.userId,
        required this.quantity,
        this.pricePerItem,
        this.totalPrice,
    });

    factory DetailsOrderHistoryItems.fromJson(Map<String, dynamic> json) => DetailsOrderHistoryItems(
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
