import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/models/admin_get_all_order_response.dart';
import 'package:rumeat_ball_apps/models/admin_get_all_transaction_response.dart';
import 'package:rumeat_ball_apps/models/admin_get_all_user_response.dart';
import 'package:rumeat_ball_apps/models/get_all_categories_response.dart';
import 'package:rumeat_ball_apps/models/get_all_menu_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/admin/admin_service.dart';
import 'package:rumeat_ball_apps/views/screens/admin/admin_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';
import 'package:rumeat_ball_apps/views/widgets/forms.dart';

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
            MaterialPageRoute(builder: (context) => AdminUserTableScreen()));
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
        _navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
            builder: (context) => TransactionManagementPage()));
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
          _buildDrawerItem(Icons.money, 'Transaction Management', () {
            _onDrawerItemTapped(4);
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
        ..getAllMenu()
        ..getAllUsers(),
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
                return ListView(
                  children: [
                    Column(
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
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SummaryCard(
                                title: 'Total Users',
                                color: Colors.blue,
                                icon: Icons.person,
                                value: '${viewModel.users?.length ?? 0}',
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: SummaryCard(
                                title: 'Total Users',
                                color: Colors.blue,
                                icon: Icons.person,
                                value: '${viewModel.users?.length ?? 0}',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

class AdminUserTableScreen extends StatefulWidget {
  @override
  _AdminUserTableScreenState createState() => _AdminUserTableScreenState();
}

class _AdminUserTableScreenState extends State<AdminUserTableScreen> {
  List<AllUser>? _users;
  List<AllUser>? _filteredUsers;
  String _selectedRole = 'all';
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final response = await AdminService().getAllUsers();
      setState(() {
        _users = response.response;
        _filteredUsers = _users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterUsers(String role) {
    setState(() {
      _selectedRole = role;
      if (role == 'all') {
        _filteredUsers = _users;
      } else {
        _filteredUsers = _users?.where((user) => user.role == role).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pengguna'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text('Error: $_errorMessage'))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DropdownButton<String>(
                        value: _selectedRole,
                        items: <String>['all', 'admin', 'user']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.capitalize()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            _filterUsers(newValue);
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Nama')),
                            DataColumn(label: Text('Nomor Telepon')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: _filteredUsers?.map((user) {
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(user.userId)),
                                    DataCell(Text(user.name)),
                                    DataCell(Text(user.phone)),
                                    DataCell(Text(user.status)),
                                  ],
                                );
                              }).toList() ??
                              [],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}

extension StringCapitalize on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

class MenuManagementPage extends StatefulWidget {
  @override
  _MenuManagementPageState createState() => _MenuManagementPageState();
}

class _MenuManagementPageState extends State<MenuManagementPage> {
  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<AdminViewModel>(context, listen: false);
    viewModel.getAllMenu(); // Panggil method getAllMenu di sini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Management'),
      ),
      body: Consumer<AdminViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.menu == null || viewModel.menu!.isEmpty) {
            return const Center(child: Text('No menus available.'));
          }

          return Column(
            children: [
              // Button to Add New Menu
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMenuPage(),
                      ),
                    );
                    print("Add New Menu");
                  },
                  child: const Text('Add New Menu'),
                ),
              ),

              // List of Menus
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.menu!.length,
                  itemBuilder: (context, index) {
                    final menu = viewModel.menu![index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(
                                menu.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16.0),

                            // Menu Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menu.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(menu.description),
                                  const SizedBox(height: 8.0),
                                  Text('Price: ${formatCurrency(menu.price)}'),
                                ],
                              ),
                            ),

                            // Edit Button
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditMenuPage(
                                        menu: menu,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Edit'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () async {
                                  final viewModel = Provider.of<AdminViewModel>(
                                      context,
                                      listen: false);

                                  bool confirmDelete = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirm Deletion'),
                                        content: const Text(
                                            'Are you sure you want to delete this menu item?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text('Yes'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text('No'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  // Ensure context is still valid and use the viewModel method for deletion
                                  if (confirmDelete && context.mounted) {
                                    await viewModel.deleteMenu(
                                        context, menu.id);
                                  }
                                },
                                child: const Text('Delete'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AddMenuPage extends StatefulWidget {
  @override
  _AddMenuPageState createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? selectedCategoryId;
  File? _image;
  List<AllCategories> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() async {
    final viewModel = Provider.of<AdminViewModel>(context, listen: false);
    await viewModel.getAllCategories();
    setState(() {
      _categories = viewModel.categories ?? [];
    });
  }

  Future<void> _chooseImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _image = File(result.files.single.path ?? "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AdminViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Menu'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          CustomFormField(
            controller: nameController,
            title: "Menu Name",
            isValid: true,
            errorMessage: 'Error',
          ),
          const SizedBox(height: 20),
          Text("Description"),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          CustomFormField(
            controller: priceController,
            title: "Price",
            isValid: true,
            errorMessage: 'Error',
          ),
          const SizedBox(height: 20),
          Text("Choose Image"),
          CustomFilledButton(
            title: "Choose Image",
            onPressed: _chooseImage,
          ),
          if (_image != null)
            Image.file(
              _image!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 20),
          Text("Category"),
          DropdownButtonFormField<String>(
            value: selectedCategoryId,
            items: _categories.map((category) {
              return DropdownMenuItem<String>(
                value: category.id,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategoryId = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomFilledButton(
            title: "Add New Menu",
            onPressed: () {
              viewModel.addMenu(
                context,
                nameController.text,
                descriptionController.text,
                double.tryParse(priceController.text) ?? 0,
                selectedCategoryId,
                _image,
              );
              nameController.clear();
              descriptionController.clear();
              priceController.clear();
              selectedCategoryId = null;
              _image = null;
            },
          ),
        ],
      ),
    );
  }
}

class EditMenuPage extends StatefulWidget {
  final AllMenu menu;

  EditMenuPage({Key? key, required this.menu}) : super(key: key);

  @override
  _EditMenuPageState createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? selectedCategoryId;
  File? _image;
  List<AllCategories> _categories = [];

  @override
  void initState() {
    super.initState();
    nameController.text = widget.menu.name;
    descriptionController.text = widget.menu.description;
    priceController.text = widget.menu.price.toString();
    selectedCategoryId = widget.menu.categoryId;
    _fetchCategories();
  }

  void _fetchCategories() async {
    final viewModel = Provider.of<AdminViewModel>(context, listen: false);
    await viewModel.getAllCategories();
    setState(() {
      _categories = viewModel.categories ?? [];
    });
  }

  Future<void> _chooseImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _image = File(result.files.single.path ?? "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AdminViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Menu'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          CustomFormField(
            controller: nameController,
            title: "Menu Name",
            isValid: true,
            errorMessage: 'Error',
          ),
          const SizedBox(height: 20),
          Text("Description"),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          CustomFormField(
            controller: priceController,
            title: "Price",
            isValid: true,
            errorMessage: 'Error',
          ),
          const SizedBox(height: 20),
          Text("Choose Image"),
          CustomFilledButton(
            title: "Choose Image",
            onPressed: _chooseImage,
          ),
          if (_image != null)
            Image.file(
              _image!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          else
            Image.network(
              widget.menu.image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          const SizedBox(height: 20),
          Text("Category"),
          DropdownButtonFormField<String>(
            value: selectedCategoryId,
            items: _categories.map((category) {
              return DropdownMenuItem<String>(
                value: category.id,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategoryId = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomFilledButton(
            title: "Update Menu",
            onPressed: () {
              viewModel.editMenu(
                context,
                widget.menu.id,
                nameController.text,
                descriptionController.text,
                double.tryParse(priceController.text) ?? 0,
                selectedCategoryId ?? "",
                _image,
              );
            },
          ),
        ],
      ),
    );
  }
}

class OrderManagementPage extends StatefulWidget {
  @override
  _OrderManagementPageState createState() => _OrderManagementPageState();
}

class _OrderManagementPageState extends State<OrderManagementPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<AdminViewModel>(context, listen: false);
      viewModel.fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Management'),
      ),
      body: Consumer<AdminViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.orders.isEmpty) {
            return const Center(child: Text('No orders available.'));
          }

          return ListView.builder(
            itemCount: viewModel.orders.length,
            itemBuilder: (context, index) {
              final order = viewModel.orders[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order ID: ${order.id}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text('Date: ${order.date ?? "N/A"}'),
                      const SizedBox(height: 8.0),
                      Text('Status: ${order.status.name}'),
                      const SizedBox(height: 8.0),
                      Text('Total: ${formatCurrency(order.total ?? 0)}'),
                      const SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderDetailPage(order: order)));
                        },
                        child: const Text('View Details'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OrderDetailPage extends StatelessWidget {
  final AdminAllOrderResponse order;

  const OrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AdminViewModel>(context, listen: false);

    void updateStatus(Status newStatus) async {
      // Perbarui status di backend
      await viewModel.updateOrderStatus(context, order.id, newStatus.name);

      // Pastikan data diperbarui
      await viewModel.fetchOrders();

      // Kembali ke halaman sebelumnya
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Order ID: ${order.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text('Date: ${order.date ?? "N/A"}'),
            const SizedBox(height: 8.0),
            Text('Status: ${order.status.name}'),
            const SizedBox(height: 8.0),
            Text('Total: ${formatCurrency(order.total ?? 0)}'),
            const SizedBox(height: 24.0),
            Text(
              'Update Status',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            DropdownButton<Status>(
              value: order.status,
              items: Status.values.map((Status status) {
                return DropdownMenuItem<Status>(
                  value: status,
                  child: Text(status.name),
                );
              }).toList(),
              onChanged: (Status? newStatus) {
                if (newStatus != null) {
                  updateStatus(newStatus);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionManagementPage extends StatefulWidget {
  @override
  _TransactionManagementPageState createState() =>
      _TransactionManagementPageState();
}

class _TransactionManagementPageState extends State<TransactionManagementPage> {
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<AdminViewModel>(context, listen: false);
      viewModel.getAllTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Management'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              hint: const Text('Filter by Status'),
              value: _selectedStatus,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue;
                });
              },
              items: ['successed', 'failed', 'pending']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Consumer<AdminViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<AllTransaction> transactions =
                    viewModel.transactions ?? [];

                if (_selectedStatus != null && _selectedStatus!.isNotEmpty) {
                  transactions = transactions
                      .where((transaction) =>
                          transaction.status == _selectedStatus)
                      .toList();
                }

                if (transactions.isEmpty) {
                  return const Center(
                      child: Text('No transactions available.'));
                }

                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction ID: ${transaction.id}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text('Order ID: ${transaction.orderId}'),
                            const SizedBox(height: 8.0),
                            Text('Date: ${transaction.date ?? "N/A"}'),
                            const SizedBox(height: 8.0),
                            Text('Status: ${transaction.status}'),
                            const SizedBox(height: 8.0),
                            Text(
                                'Total: ${formatCurrency(transaction.totalPrice ?? 0)}'),
                            const SizedBox(height: 8.0),
                            Text('User ID: ${transaction.userId}'),
                            const SizedBox(height: 8.0),
                            Text('Username: ${transaction.userName ?? "N/A"}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
