// To parse this JSON data, do
//
//     final getUserProfileResponse = getUserProfileResponseFromJson(jsonString);

import 'dart:convert';

GetUserProfileResponse getUserProfileResponseFromJson(String str) => GetUserProfileResponse.fromJson(json.decode(str));

String getUserProfileResponseToJson(GetUserProfileResponse data) => json.encode(data.toJson());

class GetUserProfileResponse {
    String? message;
    UserProfile? response;

    GetUserProfileResponse({
        this.message,
        this.response,
    });

    factory GetUserProfileResponse.fromJson(Map<String, dynamic> json) => GetUserProfileResponse(
        message: json["message"],
        response: json["response"] == null ? null : UserProfile.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "response": response?.toJson(),
    };
}

class UserProfile {
    String? userId;
    String? email;
    String? name;
    String? phone;
    String? address;
    String? status;
    String? profileImage;

    UserProfile({
        this.userId,
        this.email,
        this.name,
        this.phone,
        this.address,
        this.status,
        this.profileImage,
    });

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userId: json["user_id"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        status: json["status"],
        profileImage: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "name": name,
        "phone": phone,
        "address": address,
        "status": status,
        "profile_image": profileImage,
    };
}
