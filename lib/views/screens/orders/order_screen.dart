import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/models/get_all_order_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/orders/details_order_history_screen.dart';
import 'package:rumeat_ball_apps/views/screens/orders/order_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<void> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _checkTokenAndLoadOrders();
  }

  Future<void> _checkTokenAndLoadOrders() async {
    final token = await SharedPref.getToken();
    if (token == null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Not Logged In'),
            content: Text('You need to log in to view your order history.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Log In'),
              ),
            ],
          );
        },
      );
    } else {
      final viewModel = Provider.of<OrderViewModel>(context, listen: false);
      await viewModel.fetchOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order History',
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: primaryColor,
                size: 50,
              ),
            );
          }

          final viewModel = Provider.of<OrderViewModel>(context);

          if (viewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage));
          }

          if (viewModel.orders.isEmpty) {
            return Center(
              child: SizedBox(
                width: 327,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/img_smiling.png",
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "No Orders",
                      style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      textAlign: TextAlign.center,
                      "Looks like you haven't ordered anything yet",
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            children: [
              const SizedBox(height: 8),
              ...viewModel.orders
                  .where((order) => order.status != "cart")
                  .map((order) {
                return OrderCard(order: order);
              }).toList(),
              const SizedBox(height: 8),
            ],
          );
        },
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
            builder: (context) =>
                DetailsOrderHistoryScreen(orderId: order.id ?? ""),
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
            Text(formatCurrency(order.total ?? 0)),
          ],
        ),
      ),
    );
  }
}
