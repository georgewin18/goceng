import 'package:flutter/material.dart';
import 'package:goceng/components/food_list.dart';
import 'package:goceng/components/promo_banner.dart';
import 'package:goceng/components/promo_card.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Promo", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  promoCard("103", "Voucher & Paket", Colors.orange),
                  promoCard("0", "Langganan", Colors.pink)
                ],
              ),
              const SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    promoCategory("Apa aja", Colors.green),
                    promoCategory("Promo Ramadan", Colors.grey),
                    promoCategory("GoFood", Colors.grey),
                    promoCategory("Kirim Parsel", Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Resto jempolan lagi promo nih~",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  FoodList(),
                ],
              ),
              const SizedBox(height: 20),

              PromoCard(
                imagePath: "assets/gomart.jpg",
                title: "Persiapan berbagi di Lebaran ✨",
                description: "Cepetan GoMart! Hampers sampai kue kering diskon s.d. 50% + Flash Sale~"
              ),
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Menu sahur & buka di sekitarmu",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  FoodList(),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Bikin Ramadan-mu maksimal 🌙",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  PromoBanner(),
                ],
              ),
              const SizedBox(height: 20),

              PromoCard(
                  imagePath: "assets/gomart.jpg",
                  title: "Persiapan berbagi di Lebaran ✨",
                  description: "Cepetan GoMart! Hampers sampai kue kering diskon s.d. 50% + Flash Sale~"
              ),
              const SizedBox(height: 20),
            ]
          ),
        ),
      ),
    );
  }

  Widget promoCard(String value, String title, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: 1.0,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ],
        ),
      ),
    );
  }

  Widget promoCategory(String title, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}