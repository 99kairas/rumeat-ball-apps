// To parse this JSON data, do
//
//     final getDetailMenuResponse = getDetailMenuResponseFromJson(jsonString);

import 'dart:convert';

GetDetailMenuResponse getDetailMenuResponseFromJson(String str) => GetDetailMenuResponse.fromJson(json.decode(str));

String getDetailMenuResponseToJson(GetDetailMenuResponse data) => json.encode(data.toJson());

class GetDetailMenuResponse {
    String message;
    DetailMenu response;

    GetDetailMenuResponse({
        required this.message,
        required this.response,
    });

    factory GetDetailMenuResponse.fromJson(Map<String, dynamic> json) => GetDetailMenuResponse(
        message: json["message"],
        response: DetailMenu.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "response": response.toJson(),
    };
}

class DetailMenu {
    String? id;
    String? name;
    String? description;
    String? image;
    int? price;
    String? status;
    String? categoryId;

    DetailMenu({
        required this.id,
        required this.name,
        required this.description,
        required this.image,
        required this.price,
        required this.status,
        required this.categoryId,
    });

    factory DetailMenu.fromJson(Map<String, dynamic> json) => DetailMenu(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        status: json["status"],
        categoryId: json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "status": status,
        "category_id": categoryId,
    };
}
