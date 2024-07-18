import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class FoodCard extends StatelessWidget {
  final String image;
  final String title;
  final double rating;
  final int comment;
  final int price;

  FoodCard({
    required this.image,
    required this.title,
    required this.rating,
    required this.comment,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            image != ""
                ? Image.network(image, width: 80, height: 80, fit: BoxFit.cover)
                : Image.asset("assets/images/burger1.png",
                    width: 80, height: 80, fit: BoxFit.cover),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: primaryColor, size: 16),
                      const SizedBox(width: 4),
                      Text('$rating'),
                      const SizedBox(width: 8),
                      Icon(Icons.comment_rounded, color: greyColor, size: 16),
                      const SizedBox(width: 4),
                      Text(comment.toString()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatCurrency(price),
                  )
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
