import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/orders/details_order_history_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';

class DetailsOrderHistoryScreen extends StatefulWidget {
  final String orderId;

  DetailsOrderHistoryScreen({required this.orderId});

  @override
  State<DetailsOrderHistoryScreen> createState() =>
      _DetailsOrderHistoryScreenState();
}

class _DetailsOrderHistoryScreenState extends State<DetailsOrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<DetailsOrderHistoryViewModel>(context, listen: false)
          .fetchOrderDetails(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderDetailsViewModel =
        Provider.of<DetailsOrderHistoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: orderDetailsViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Order ID: ${orderDetailsViewModel.orderDetails?.id ?? ''}',
                      style: blackTextStyle),
                  Text(
                      'Date: ${orderDetailsViewModel.orderDetails?.date ?? ''}',
                      style: blackTextStyle),
                  Text(
                      'Status: ${orderDetailsViewModel.orderDetails?.status ?? ''}',
                      style: blackTextStyle),
                  Text(
                      'Total: ${orderDetailsViewModel.orderDetails?.total ?? ''}',
                      style: blackTextStyle),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          orderDetailsViewModel.orderDetails?.items?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item =
                            orderDetailsViewModel.orderDetails!.items![index];
                            return Container();
                        // return ListTile(
                        //   // leading: Image.network(item.image),
                        //   title: Text(item.name, style: blackTextStyle),
                        //   subtitle: Text('Quantity: ${item.quantity}',
                        //       style: greyTextStyle),
                        //   trailing: Text(
                        //       formatCurrency(item.price * item.quantity),
                        //       style: primaryTextStyle),
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
