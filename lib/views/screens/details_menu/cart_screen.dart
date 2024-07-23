import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/cart_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/checkout_screen.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: ListView.builder(
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
      ),
      bottomNavigationBar: Container(
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
              onPressed: () {
                cartProvider.createOrderCart(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen(orderID: cartProvider.order?.id ?? "")),
                );
              },
              style: ElevatedButton.styleFrom(
                // primary: primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
