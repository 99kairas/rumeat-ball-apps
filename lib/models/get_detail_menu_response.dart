class Comment {
  String? id;
  String? userId;
  String? userName;
  String? comment;
  double? rating;
  String? email;
  String? phone;
  String? address;
  String? status;
  String? profileImage;

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.email,
    required this.phone,
    required this.address,
    required this.status,
    required this.profileImage,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userId: json["user_id"],
        userName: json["User"]["name"],  // Mengambil nama dari objek User
        comment: json["comment"],
        rating: json["rating"].toDouble(),
        email: json["User"]["email"],  // Mengambil email dari objek User
        phone: json["User"]["phone"],  // Mengambil phone dari objek User
        address: json["User"]["address"],  // Mengambil address dari objek User
        status: json["User"]["status"],  // Mengambil status dari objek User
        profileImage: json["User"]["profile_image"],  // Mengambil profile image dari objek User
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "comment": comment,
        "rating": rating,
        "email": email,
        "phone": phone,
        "address": address,
        "status": status,
        "profile_image": profileImage,
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
  int? commentCount;
  double? averageRating;
  List<Comment>? comments;

  DetailMenu({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.status,
    required this.categoryId,
    required this.commentCount,
    required this.averageRating,
    required this.comments,
  });

  factory DetailMenu.fromJson(Map<String, dynamic> json) => DetailMenu(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        status: json["status"],
        categoryId: json["category_id"],
        commentCount: json["comment_count"],
        averageRating: json["average_rating"] != null
            ? json["average_rating"].toDouble()
            : 0.0, // Nilai default jika null
        comments: json["comments"] == null
            ? []
            : (json["comments"] as List)
                .map((commentJson) => Comment.fromJson(commentJson))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "status": status,
        "category_id": categoryId,
        "comment_count": commentCount,
        "average_rating": averageRating,
        "comments": comments?.map((comment) => comment.toJson()).toList(),
      };
}

