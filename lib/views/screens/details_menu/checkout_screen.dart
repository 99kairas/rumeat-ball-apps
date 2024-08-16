import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/cart_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/checkout_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutScreen extends StatefulWidget {
  final String orderID;
  CheckoutScreen({required this.orderID});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<CartModel>(context, listen: false)
          .getOrderByID(orderID: widget.orderID);
      _fetchOrderDetails();
    });
  }

  void _fetchOrderDetails() {
    // Cetak orderID untuk memastikan nilainya
    print("Fetching order details for order ID: ${widget.orderID}");
    // Misalnya, panggil method di ViewModel untuk mengambil data order
    CheckoutViewModel().getOrderByID(orderID: widget.orderID);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartModel>(context);
    final checkoutViewModel = Provider.of<CheckoutViewModel>(context);
    final cartItems = cartProvider.items;
    final tax = cartProvider.totalPrice * 0.01;
    final totalWithTax = cartProvider.totalPrice + tax;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: cartProvider.isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: primaryColor,
                size: 50,
              ),
            )
          : Padding(
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
                        formatCurrency(totalWithTax),
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
                      ElevatedButton(
                        onPressed: () async {
                          await checkoutViewModel.placeOrder(
                              widget.orderID, totalWithTax);
                          if (checkoutViewModel.orderModel != null) {
                            _launchInBrowser(Uri.parse(
                                checkoutViewModel.orderModel!.paymentUrl));
                            Navigator.of(context).pushReplacementNamed('/home');
                            cartProvider.clearCart();
                          } else {
                            print(
                                "Error placing order: ${checkoutViewModel.error}");
                            scaffoldMessengerFailed(
                              context: context,
                              title: "Error placing order",
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        child: const Center(child: Text('Place Order')),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Order Cancelled'),
                                content: Text('Your order has been cancelled!'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      checkoutViewModel
                                          .cancelOrder(widget.orderID);
                                      cartProvider.clearCart();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        child: const Center(child: Text('Cancel')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
