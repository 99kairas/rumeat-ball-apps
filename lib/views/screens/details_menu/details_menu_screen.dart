import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/models/get_detail_menu_response.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/cart_viewmodel.dart';
import 'package:rumeat_ball_apps/views/screens/details_menu/details_menu_viewmodel.dart';
import 'package:rumeat_ball_apps/views/themes/style.dart';
import 'package:rumeat_ball_apps/views/widgets/buttons.dart';

class DetailsMenuScreen extends StatefulWidget {
  final String menuID;
  const DetailsMenuScreen({
    super.key,
    required this.menuID,
  });

  @override
  State<DetailsMenuScreen> createState() => _DetailsMenuScreenState();
}

class _DetailsMenuScreenState extends State<DetailsMenuScreen> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DetailsMenuViewModel>(context, listen: false)
          .getDetailMenu(menuID: widget.menuID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<DetailsMenuViewModel>(context);
    final cartProvider = Provider.of<CartModel>(context);
    final menu = menuProvider.menu;
    return Scaffold(
      body: menuProvider.isLoading == true
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: primaryColor,
                size: 50,
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background: menu?.image != null || menu?.image != ""
                        ? Image.network(menu?.image ?? "")
                        : Image.asset(
                            'assets/images/burger1.png',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: whiteColor),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Text(
                    "About This Menu",
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.favorite_border, color: whiteColor),
                      onPressed: () {},
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${menu?.name}',
                              style: blackTextStyle.copyWith(
                                  fontSize: 24, fontWeight: semiBold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              formatCurrency(menu?.price ?? 0),
                              style: primaryTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: semiBold,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Chip(
                                  avatar: Icon(Icons.shopping_bag,
                                      color: primaryColor),
                                  label: Text(
                                    'Take Away',
                                    style: greyTextStyle.copyWith(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Chip(
                                  avatar:
                                      Icon(Icons.comment, color: primaryColor),
                                  label: Text(
                                    '${menu?.commentCount ?? 0}',
                                    style: greyTextStyle.copyWith(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Chip(
                                  avatar: Icon(Icons.star, color: primaryColor),
                                  label: Text(
                                    '${menu?.averageRating ?? 0}',
                                    style: greyTextStyle.copyWith(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Description',
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: semiBold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${menu?.description}',
                              style: greyTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: small,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Comments',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => {},
                                  child: Text(
                                    'See All',
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            menu?.comments != null && menu!.comments!.isNotEmpty
                                ? Column(
                                    children: menu.comments!.map((comment) {
                                      return CommentCard(comment: comment);
                                    }).toList(),
                                  )
                                : Center(
                                    child: Text(
                                      'No comments available.',
                                      style: greyTextStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: regular,
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                                height: 80), // To ensure button is visible
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: greyColor,
                      ),
                      borderRadius: BorderRadius.circular(100)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity--;
                        }
                      });
                    },
                    child: Icon(
                      Icons.remove,
                      color: primaryColor,
                    ),
                  ),
                ),
                Text(
                  quantity.toString(),
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: greyColor,
                      ),
                      borderRadius: BorderRadius.circular(100)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    child: Icon(
                      Icons.add,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            CustomFilledButton(
              width: 250,
              title: "Add to Cart",
              style: whiteTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
              onPressed: () {
                if (menu != null) {
                  cartProvider.addToCart(menu, quantity, context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;
  const CommentCard({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: greyColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                censorName(comment.userName),
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            comment.comment ?? '',
            style: greyTextStyle.copyWith(
              fontSize: 14,
              fontWeight: regular,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < comment.rating! ? Icons.star : Icons.star_border,
                color: primaryColor,
              );
            }),
          ),
        ],
      ),
    );
  }

  String censorName(String? fullName) {
    if (fullName == null || fullName.isEmpty) return 'Anonymous';

    // Split nama berdasarkan spasi
    List<String> nameParts = fullName.split(' ');

    // Ambil nama depan
    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';

    // Ganti karakter kedua dan seterusnya dengan asterisk
    String censoredFirstName =
        firstName.isNotEmpty ? firstName[0] + '*' * (firstName.length - 1) : '';

    // Jika ada nama belakang, sensor juga
    String censoredLastName = '';
    if (nameParts.length > 1) {
      String lastName = nameParts.last;
      censoredLastName = lastName.isNotEmpty
          ? ' ' + lastName[0] + '*' * (lastName.length - 1)
          : '';
    }

    return censoredFirstName + censoredLastName;
  }
}
