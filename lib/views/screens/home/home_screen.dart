import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/cart_screen.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/details_menu_screen.dart';
import 'package:rumeat_ball_apps/views/screens/home/food_card.dart';
import 'package:rumeat_ball_apps/views/screens/home/home_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/orders/order_screen.dart';
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
          CartScreen(),
          OrderScreen(),
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
            icon: Icon(Icons.shopping_cart,
                color: _selectedIndex == 1 ? primaryColor : greyColor),
            label: 'Cart',
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
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  "assets/images/rumeat-ball.png",
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: blackColor),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
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
                Text(
                  "Menu:",
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
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
                        rating: item.averageRating ?? 0.0,
                        comment: item.commentCount ?? 0,
                        price: item.price,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsMenuScreen(
                                menuID: item.id,
                              ),
                            ),
                          );
                        },
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
