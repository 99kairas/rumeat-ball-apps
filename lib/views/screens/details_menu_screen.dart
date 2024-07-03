import 'package:flutter/material.dart';

class DetailsMenuScreen extends StatelessWidget {
  const DetailsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/burger1.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Burger With Meat 🍔',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Rp. 25.000',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Chip(
                            avatar:
                                Icon(Icons.shopping_bag, color: Colors.orange),
                            label: Text('Take Away'),
                          ),
                          SizedBox(width: 8),
                          Chip(
                            avatar: Icon(Icons.comment, color: Colors.orange),
                            label: Text('Comment'),
                          ),
                          SizedBox(width: 8),
                          Chip(
                            avatar: Icon(Icons.star, color: Colors.orange),
                            label: Text('4.5'),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Burger With Meat is a typical food from our restaurant that is much in demand by many people, this is very recommended for you.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended For You',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            RecommendedCard(
                              image: 'assets/images/burger1.png',
                              title: 'Burger',
                            ),
                            RecommendedCard(
                              image: 'assets/images/burger2.png',
                              title: 'Pizza',
                            ),
                            // Add more RecommendedCard widgets as needed
                          ],
                        ),
                      ),
                      SizedBox(height: 80), // To ensure button is visible
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
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.black),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                const Text(
                  '4',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedCard extends StatelessWidget {
  final String image;
  final String title;

  const RecommendedCard({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
