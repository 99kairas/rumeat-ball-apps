import 'package:flutter/material.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/checkout_screen.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Contoh data order, ganti dengan data sebenarnya
    List<Map<String, dynamic>> orders = [
      {
        "id": "RB-4EACCA81",
        "date": "23 July 2024 05:17",
        "status": "cart",
        "total": 142410
      },
      {
        "id": "RB-4EACCA82",
        "date": "22 July 2024 04:12",
        "status": "success",
        "total": 50000
      },
      // Tambahkan order lain jika perlu
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Orders'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ...orders.where((order) => order["status"] == "cart").map((order) {
              return OrderCard(order: order);
            }).toList(),
            SizedBox(height: 16),
            SizedBox(height: 8),
            ...orders.where((order) => order["status"] != "cart").map((order) {
              return OrderCard(order: order);
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke layar checkout, ganti dengan navigasi yang sesuai
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CheckoutScreen(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order["id"]}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('Date: ${order["date"]}'),
            SizedBox(height: 4),
            Text('Status: ${order["status"]}'),
            SizedBox(height: 4),
            Text('Total: ${order["total"]}'),
          ],
        ),
      ),
    );
  }
}
