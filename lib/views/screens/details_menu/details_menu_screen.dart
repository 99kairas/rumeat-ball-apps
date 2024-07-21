import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';
import 'package:rumeat_ball_apps/shared/shared_methods.dart';
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
  @override
  void initState() {
    super.initState();
    Provider.of<DetailsMenuViewModel>(context, listen: false)
        .getDetailMenu(menuID: widget.menuID);
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<DetailsMenuViewModel>(context);
    final menu = menuProvider.menu;
    return Scaffold(
      body: CustomScrollView(
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
                            avatar:
                                Icon(Icons.shopping_bag, color: primaryColor),
                            label: Text(
                              'Take Away',
                              style: greyTextStyle.copyWith(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Chip(
                            avatar: Icon(Icons.comment, color: primaryColor),
                            label: Text(
                              '5',
                              style: greyTextStyle.copyWith(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Chip(
                            avatar: Icon(Icons.star, color: primaryColor),
                            label: Text(
                              '4.5',
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
                      const Column(
                        children: [
                          CommentCard(
                            name:
                                "RizkiRizkiRizkiRizkiRizkiRizkiRizkiRizkiRizkiRizkiRizkiRizkiRizki",
                            rating: 5,
                            description:
                                'Desain antarmuka pengguna (UI design) adalah bagian penting dari pengembangan produk digital yang efektif. UI design melibatkan merancang antarmuka pengguna yang mudah digunakan dan menarik, serta memperhatikan aspek-aspek seperti navigasi, tata letak, interaksi, dan estetika visual. Kursus ini akan memberikan pengantar tentang UI design dan membahas prinsip-prinsip desain antarmuka pengguna yang baik.',
                            profileImage: 'assets/images/burger1.png',
                          ),
                          CommentCard(
                            name: "Rizki",
                            rating: 2,
                            description: 'Pizza',
                            profileImage: 'assets/images/burger1.png',
                          ),
                          // Add more CommentCard widgets as needed
                        ],
                      ),
                      const SizedBox(height: 80), // To ensure button is visible
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
                    onTap: () {},
                    child: Icon(
                      Icons.remove,
                      color: blackColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  '1000',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: greyColor,
                      ),
                      borderRadius: BorderRadius.circular(100)),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.add,
                      color: blackColor,
                    ),
                  ),
                ),
              ],
            ),
            CustomFilledButton(
              onPressed: () {},
              title: "Add to Cart",
              width: 183,
              height: 52,
              icon: Icons.shopping_cart,
            ),
          ],
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final String profileImage;

  const CommentCard({
    required this.name,
    required this.description,
    required this.rating,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16, bottom: 16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        profileImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingStars(
                          starCount: 5,
                          value: rating,
                          valueLabelVisibility: false,
                          starSize: 16,
                          maxValueVisibility: false,
                          starColor: primaryColor,
                          starOffColor: greyColor,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          name,
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: blackTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
