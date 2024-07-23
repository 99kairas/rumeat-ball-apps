import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/models/get_all_order_response.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/checkout_screen.dart';
import 'package:rumeat_ball_apps/views/screens/orders/order_viewmodel.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderViewModel()..fetchOrders(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Orders'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<OrderViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (viewModel.errorMessage.isNotEmpty) {
                return Center(child: Text(viewModel.errorMessage));
              }

              if (viewModel.orders.isEmpty) {
                return const Center(child: Text('No orders available.'));
              }

              return ListView(
                children: [
                  const SizedBox(height: 8),
                  ...viewModel.orders
                      .where((order) => order.status == "cart")
                      .map((order) {
                    return OrderCard(order: order);
                  }).toList(),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CheckoutScreen(orderID: order.id ?? ""),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Date: ${order.date}'),
            const SizedBox(height: 4),
            Text('Status: ${order.status}'),
            const SizedBox(height: 4),
            Text('Total: ${order.total}'),
          ],
        ),
      ),
    );
  }
}
