import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/models/get_all_menu_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/home/home_viewmodel.dart';
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
          .getDetailsOrderHistory(context, orderID: widget.orderId);
      Provider.of<HomeViewModel>(context, listen: false).getAllMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderDetailsViewModel =
        Provider.of<DetailsOrderHistoryViewModel>(context);
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order Details',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: orderDetailsViewModel.isLoading || homeViewModel.isLoading
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
                  Text(
                      'Order ID: ${orderDetailsViewModel.orderHistoryItems?.id ?? ''}',
                      style: blackTextStyle),
                  Text(
                      'Date: ${orderDetailsViewModel.orderHistoryItems?.date ?? ''}',
                      style: blackTextStyle),
                  Text(
                      'Status: ${orderDetailsViewModel.orderHistoryItems?.status ?? ''}',
                      style: blackTextStyle),
                  Text(
                      'Total: ${formatCurrency(orderDetailsViewModel.orderHistoryItems?.total ?? 0)}',
                      style: blackTextStyle),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orderDetailsViewModel
                              .orderHistoryItems?.items?.length ??
                          0,
                      itemBuilder: (context, index) {
                        final item = orderDetailsViewModel
                            .orderHistoryItems!.items![index];
                        // Find the corresponding menu item from the homeViewModel
                        final menu = homeViewModel.menu?.firstWhere(
                            (menu) => menu.id == item.menuId,
                            orElse: () => AllMenu(
                                  id: 'unknown',
                                  name: 'Unknown Menu',
                                  description: '',
                                  image: '', // Provide a placeholder image URL
                                  price: 0,
                                  status: '',
                                  categoryId: '',
                                ));

                        return ListTile(
                          leading: menu!.image.isNotEmpty
                              ? Image.network(menu.image)
                              : Icon(Icons.image_not_supported),
                          title: Text(menu.name, style: blackTextStyle),
                          subtitle: Text('Quantity: ${item.quantity}',
                              style: greyTextStyle),
                          trailing: Text(
                              formatCurrency(
                                  (item.pricePerItem ?? 0) * item.quantity),
                              style: primaryTextStyle),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
