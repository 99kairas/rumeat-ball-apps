import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/views/screens/admin/admin_service.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text('Admin Menu', style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('User Management'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserManagementScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Order Management'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderManagementScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoCard('Total Sales', '\$125,000'),
              _buildInfoCard('Total Users', '12,000'),
              _buildInfoCard('KPI Progress Rate', '52.3%'),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Brand')),
                  DataColumn(label: Text('Supplier')),
                  DataColumn(label: Text('Minimum Stock')),
                  DataColumn(label: Text('Update Date')),
                  DataColumn(label: Text('Tax Rate')),
                  DataColumn(label: Text('Notes')),
                ],
                rows: List<DataRow>.generate(
                  12,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text('INV00${index + 1}')),
                      DataCell(Text('Category $index')),
                      DataCell(Text('Brand $index')),
                      DataCell(Text('Supplier $index')),
                      DataCell(Text('${index * 5}')),
                      DataCell(Text('2023-08-${10 + index}')),
                      DataCell(Text('${(index % 3) * 0.05 + 0.08}')),
                      DataCell(Text('Notes $index')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      color: const Color(0xFF1F1F1F),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  late Future<List<User>> _usersFuture;
  final AdminService _userService = AdminService();

  @override
  void initState() {
    super.initState();
    _usersFuture = _userService.fetchUsers();
  }

  void _navigateToUserDetails(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailsScreen(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching users'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          }

          final users = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Status')),
              ],
              rows: users.map((user) {
                return DataRow(
                  cells: [
                    DataCell(Text(user.id)),
                    DataCell(Text(user.name)),
                    DataCell(Text(user.email)),
                    DataCell(Text(user.status)),
                  ],
                  onSelectChanged: (selected) {
                    if (selected != null && selected) {
                      _navigateToUserDetails(user);
                    }
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  final User user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${user.id}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Status: ${user.status}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Address: ${user.address}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Phone Number: ${user.phoneNumber}',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class OrderManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Management'),
      ),
      body: const Center(
        child: Text('Order Management', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
