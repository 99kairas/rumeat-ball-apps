import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/cart_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class CheckoutScreen extends StatelessWidget {
  final String orderID;
  CheckoutScreen({required this.orderID});
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartModel>(context);
    final cartItems = cartProvider.items;
    final tax = cartProvider.totalPrice * 0.01;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Image.network(item.image),
                    title: Text(item.name, style: blackTextStyle),
                    subtitle: Text(
                      'Quantity: ${item.quantity}',
                      style: greyTextStyle,
                    ),
                    trailing: Text(
                      formatCurrency(item.price * item.quantity),
                      style: primaryTextStyle,
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  formatCurrency(cartProvider.totalPrice),
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tax 1%',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  formatCurrency(cartProvider.totalPrice * 0.01),
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  formatCurrency(cartProvider.totalPrice + tax),
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement checkout functionality here
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Order Placed'),
                      content: Text('Your order has been placed successfully!'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            cartProvider.clearCart();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                // primary: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              child: const Center(child: Text('Place Order')),
            ),
          ],
        ),
      ),
    );
  }
}
