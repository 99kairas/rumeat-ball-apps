import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class FoodCard extends StatelessWidget {
  final String image;
  final String title;
  final double rating;
  final int comment;
  final int price;
  final Function() onTap;

  FoodCard({
    required this.image,
    required this.title,
    required this.rating,
    required this.comment,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  image != ""
                      ? Image.network(image,
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover)
                      : Image.asset("assets/images/burger1.png",
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.cover),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: primaryColor, size: 16),
                      const SizedBox(width: 4),
                      Text('$rating'),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(Icons.comment_rounded, color: greenColor, size: 16),
                      const SizedBox(width: 4),
                      Text(comment.toString()),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                formatCurrency(price),
                style:
                    primaryTextStyle.copyWith(fontSize: 16, fontWeight: bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
