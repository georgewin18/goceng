import 'package:flutter/material.dart';

class FoodList extends StatelessWidget {
  const FoodList({super.key});

  final List<Map<String, dynamic>> _foodItems = const [
    {
      "image": "assets/bebek_goreng.jpg",
      "name": "Bebek Gorang Mak Dura",
      "rating": 4.9,
      "distance": "2.23 km",
      "discount": "40% off"
    },
    {
      "image": "assets/burger_bangor.jpg",
      "name": "Burger Bangor Eridu",
      "rating": 4.7,
      "distance": "2.83 km",
      "discount": "40% off"
    },
    {
      "image": "assets/nasi_cumi_hitam.jpg",
      "name": "Nasi Cumi Hitam Pak Kris",
      "rating": 4.6,
      "distance": "5.69 km",
      "discount": "50% off"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _foodItems.length,
        itemBuilder: (context, index) {
          final food = _foodItems[index];
          return Container(
            width: 180,
            margin: const EdgeInsets.only(left: 16, right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.1 * 255).toInt()),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 3)
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    food["image"],
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text(
                          food["discount"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        food["name"],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow, size: 16),
                          Text("${food["rating"]}"),
                          const SizedBox(width: 5),
                          const Icon(Icons.location_on, color: Colors.grey, size: 16),
                          Text(food["distance"]),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}