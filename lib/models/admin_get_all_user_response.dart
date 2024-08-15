// To parse this JSON data, do
//
//     final adminGetAllUserResponse = adminGetAllUserResponseFromJson(jsonString);

import 'dart:convert';

AdminGetAllUserResponse adminGetAllUserResponseFromJson(String str) =>
    AdminGetAllUserResponse.fromJson(json.decode(str));

String adminGetAllUserResponseToJson(AdminGetAllUserResponse data) =>
    json.encode(data.toJson());

class AdminGetAllUserResponse {
  String message;
  List<AllUser> response;

  AdminGetAllUserResponse({
    required this.message,
    required this.response,
  });

  factory AdminGetAllUserResponse.fromJson(Map<String, dynamic> json) =>
      AdminGetAllUserResponse(
        message: json["message"],
        response: List<AllUser>.from(
            json["response"].map((x) => AllUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class AllUser {
  String userId;
  String email;
  String name;
  String phone;
  String address;
  String status;
  String profileImage;
  String role;

  AllUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.status,
    required this.profileImage,
    required this.role,
  });

  factory AllUser.fromJson(Map<String, dynamic> json) => AllUser(
        userId: json["user_id"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        status: json["status"],
        profileImage: json["profile_image"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "name": name,
        "phone": phone,
        "address": address,
        "status": status,
        "profile_image": profileImage,
        "role": role,
      };
}
