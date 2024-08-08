import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/cart_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/checkout_screen.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndLoadCart();
  }

  Future<void> _checkTokenAndLoadCart() async {
    final token = await SharedPref.getToken();
    if (token == null) {
      // Show a dialog to inform the user
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents dismissal by tapping outside
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Not Logged In'),
            content: Text('You need to log in to view your cart.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Log In'),
              ),
            ],
          );
        },
      );
    } else {
      // User is logged in, proceed with cart operations
      Provider.of<CartModel>(context, listen: false).notifyListeners();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Cart',
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: cartProvider.items.isNotEmpty
          ? ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
                return ListTile(
                  leading: Image.network(item.image),
                  title: Text(item.name, style: blackTextStyle),
                  subtitle: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cartProvider.decreaseQuantity(item.id);
                        },
                      ),
                      Text('${item.quantity}', style: greyTextStyle),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartProvider.increaseQuantity(item.id);
                        },
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cartProvider.removeItem(item.id);
                    },
                  ),
                );
              },
            )
          : Center(
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
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "No Items in Cart",
                      style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "You don't have any item in your cart, Let's add some!",
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: cartProvider.items.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                          style: blackTextStyle.copyWith(
                              fontSize: 18, fontWeight: semiBold)),
                      Text(formatCurrency(cartProvider.totalPrice),
                          style: primaryTextStyle.copyWith(
                              fontSize: 18, fontWeight: semiBold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final orderID =
                          await cartProvider.createOrderCart(context);
                      print("Order ID: ${orderID}");
                      if (orderID != null && orderID.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CheckoutScreen(orderID: orderID),
                          ),
                        );
                      } else {
                        scaffoldMessengerFailed(
                          context: context,
                          title: "Failed to create order",
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      textStyle: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
