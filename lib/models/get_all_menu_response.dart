// To parse this JSON data, do
//
//     final getAllMenuResponse = getAllMenuResponseFromJson(jsonString);

import 'dart:convert';

GetAllMenuResponse getAllMenuResponseFromJson(String str) => GetAllMenuResponse.fromJson(json.decode(str));

String getAllMenuResponseToJson(GetAllMenuResponse data) => json.encode(data.toJson());

class GetAllMenuResponse {
    String message;
    List<AllMenu> response;

    GetAllMenuResponse({
        required this.message,
        required this.response,
    });

    factory GetAllMenuResponse.fromJson(Map<String, dynamic> json) => GetAllMenuResponse(
        message: json["message"],
        response: List<AllMenu>.from(json["response"].map((x) => AllMenu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
    };
}

class AllMenu {
    String id;
    String name;
    String description;
    String image;
    int price;
    String status;
    String categoryId;

    AllMenu({
        required this.id,
        required this.name,
        required this.description,
        required this.image,
        required this.price,
        required this.status,
        required this.categoryId,
    });

    factory AllMenu.fromJson(Map<String, dynamic> json) => AllMenu(
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