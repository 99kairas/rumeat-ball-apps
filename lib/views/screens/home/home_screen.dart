import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/views/screens/home/category_card.dart';
import 'package:rumeat_ball_apps/views/screens/home/food_card.dart';
import 'package:rumeat_ball_apps/views/screens/home/home_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/profile/profile_screen.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    Provider.of<HomeViewModel>(context, listen: false).getAllMenu();
    Provider.of<HomeViewModel>(context, listen: false).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomePage(),
          OrdersPage(),
          HistoryPage(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0 ? primaryColor : greyColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag,
                color: _selectedIndex == 1 ? primaryColor : greyColor),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,
                color: _selectedIndex == 2 ? primaryColor : greyColor),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 3 ? primaryColor : greyColor),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
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
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: menuProvider.category!.length,
                    itemBuilder: (context, index) {
                      final item = menuProvider.category![index];
                      return CategoryCard(
                        title: item.name,
                        icon: Icons.fastfood,
                        onPressed: () {},
                      );
                    },
                  )
                else
                  const Center(child: Text('No categories available')),
                const SizedBox(height: 16),
                if (menuProvider.menu != null)
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: menuProvider.menu!.length,
                    itemBuilder: (context, index) {
                      final item = menuProvider.menu![index];
                      return FoodCard(
                        image: item.image,
                        title: item.name,
                        rating: 4.9,
                        comment: 5,
                        price: item.price,
                        onTap: () {},
                      );
                    },
                  )
                else
                  const Center(child: Text('No menu available')),
              ],
            ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: const Center(child: Text("Orders Page")),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: const Center(child: Text("History Page")),
    );
  }
}
