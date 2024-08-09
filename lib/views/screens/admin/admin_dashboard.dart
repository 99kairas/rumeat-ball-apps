import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/admin/admin_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        _navigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => DashboardPage()));
        break;
      case 1:
        _navigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => UserManagementPage()));
        break;
      case 2:
        _navigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => MenuManagementPage()));
        break;
      case 3:
        _navigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => OrderManagementPage()));
        break;
      case 4:
        // handle logout
        break;
    }
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rumeat Ball Admin",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => DashboardPage(),
          );
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset(
              "assets/images/rumeat-ball.png",
              color: primaryColor,
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Dashboard', () {
            _onDrawerItemTapped(0);
          }),
          _buildDrawerItem(Icons.person, 'User Management', () {
            _onDrawerItemTapped(1);
          }),
          _buildDrawerItem(Icons.food_bank_sharp, 'Menu Management', () {
            _onDrawerItemTapped(2);
          }),
          _buildDrawerItem(Icons.shopping_bag, 'Order Management', () {
            _onDrawerItemTapped(3);
          }),
          const Divider(),
          _buildDrawerItem(Icons.logout, 'Logout', () {
            SharedPref.removeToken();
            Navigator.pushReplacementNamed(context, '/login');
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: greyColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: primaryColor),
      ),
      title: Text(title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _selectedIndex == title ? Colors.blue : Colors.black,
          )),
      selected: _selectedIndex == title,
      selectedTileColor: Colors.blue.withOpacity(0.1),
      onTap: onTap,
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(value,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminViewModel()
        ..fetchOrders()
        ..getAllMenu(), // Fetch data saat widget dibangun
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<AdminViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (viewModel.errorMessage.isNotEmpty) {
                return Center(child: Text(viewModel.errorMessage));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SummaryCard(
                            title: 'Total Menus',
                            color: Colors.pink,
                            icon: Icons.menu_book,
                            value: '${viewModel.menu?.length ?? 0}',
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: SummaryCard(
                            title: 'Total Orders',
                            color: Colors.blue,
                            icon: Icons.shopping_cart,
                            value: '${viewModel.orders.length}',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Tambahkan row atau card lain sesuai kebutuhan
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class UserManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('User Management Page', style: TextStyle(fontSize: 24)),
    );
  }
}

class MenuManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Menu Management Page', style: TextStyle(fontSize: 24)),
    );
  }
}

class OrderManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Order Management Page', style: TextStyle(fontSize: 24)),
    );
  }
}
