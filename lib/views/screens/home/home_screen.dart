import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/views/screens/home/category_card.dart';
import 'package:rumeat_ball_apps/views/screens/home/food_card.dart';
import 'package:rumeat_ball_apps/views/screens/home/home_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false).getAllMenu();
    Provider.of<HomeViewModel>(context, listen: false).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<HomeViewModel>(context);
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
                    'Halo,',
                    style: TextStyle(color: greyColor, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        '${menuProvider.menu?.first.name}',
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
      body: menuProvider.isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: primaryColor,
                size: 50,
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16.0),
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
                ),
                const SizedBox(height: 16),
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
                if (menuProvider.category != null)
                  Wrap(
                    spacing: 5,
                    // runSpacing: 8.0,
                    children: menuProvider.category!.map((item) {
                      return CategoryCard(
                        title: item.name,
                        icon: Icons.fastfood,
                        onPressed: () {},
                      );
                    }).toList(),
                  )
                else
                  const Center(child: Text('No categories available')),
                const SizedBox(height: 16),
                if (menuProvider.menu != null)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuProvider.menu!.length,
                    itemBuilder: (context, index) {
                      final item = menuProvider.menu![index];
                      return FoodCard(
                        image: item.image,
                        title: item.name,
                        rating: 4.9,
                        comment: 5,
                        price: item.price,
                      );
                    },
                  )
                else
                  const Center(child: Text('No menu available')),
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
