import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Location',
                    style: TextStyle(color: greyColor, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primaryColor),
                      Text(
                        'New York City',
                        style: TextStyle(color: blackColor, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.search, color: blackColor),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: blackColor),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(
                  'Provide the best\nfood for you',
                  style: whiteTextStyle.copyWith(
                      fontSize: 32, fontWeight: semiBold),
                ),
                // const SizedBox(height: 16),
              ),
              Container(),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Find by Category',
                    style: TextStyle(fontSize: 18, fontWeight: bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(color: primaryColor, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryCard(title: 'Burger', icon: Icons.fastfood),
                  CategoryCard(title: 'Taco', icon: Icons.local_pizza),
                  CategoryCard(title: 'Drink', icon: Icons.local_drink),
                  CategoryCard(title: 'Pizza', icon: Icons.local_pizza),
                ],
              ),
              const SizedBox(height: 16),
              FoodCard(
                image: 'assets/images/burger1.png',
                title: 'Ordinary Burgers',
                rating: 4.9,
                comment: 5,
                price: 17230,
              ),
              FoodCard(
                image: 'assets/images/burger2.png',
                title: 'Burger With Meat',
                rating: 4.9,
                comment: 10,
                price: 17230,
              ),
              // Add more FoodCard widgets as needed
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: primaryColor),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  CategoryCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: primaryColor),
        ),
        const SizedBox(height: 4),
        Text(title, style: TextStyle(color: blackColor)),
      ],
    );
  }
}

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
            Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
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
                  Text('\$${price.toString()}'),
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
