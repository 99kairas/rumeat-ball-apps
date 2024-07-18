// To parse this JSON data, do
//
//     final getAllCategoriesResponse = getAllCategoriesResponseFromJson(jsonString);

import 'dart:convert';

GetAllCategoriesResponse getAllCategoriesResponseFromJson(String str) => GetAllCategoriesResponse.fromJson(json.decode(str));

String getAllCategoriesResponseToJson(GetAllCategoriesResponse data) => json.encode(data.toJson());

class GetAllCategoriesResponse {
    String message;
    List<AllCategories> response;

    GetAllCategoriesResponse({
        required this.message,
        required this.response,
    });

    factory GetAllCategoriesResponse.fromJson(Map<String, dynamic> json) => GetAllCategoriesResponse(
        message: json["message"],
        response: List<AllCategories>.from(json["response"].map((x) => AllCategories.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
    };
}

class AllCategories {
    String id;
    String name;

    AllCategories({
        required this.id,
        required this.name,
    });

    factory AllCategories.fromJson(Map<String, dynamic> json) => AllCategories(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
