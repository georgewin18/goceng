import 'package:flutter/material.dart';
import 'package:goceng/components/promo_card.dart';
import 'package:goceng/components/search_bar.dart';
import 'package:goceng/components/promo_banner.dart';
import 'package:goceng/components/food_list.dart';
import 'package:goceng/pages/ride_loading_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      "assets/banner.png",
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
              ),

              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 20),
                    walletSection(),
                    serviceGrid(),
                    subscriptionBanner(),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            "Cek yang menarik di GoFood",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            "Resto dengan rating jempolan",
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
                    const SizedBox(height: 10),
                    PromoCard(
                        imagePath: "assets/gomart.jpg",
                        title: "Persiapan berbagi di Lebaran ✨",
                        description: "Cepetan GoMart! Hampers sampai kue kering diskon s.d. 50% + Flash Sale~"
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomSearchBar()
                  ],
                ),
              )
            )
          ),
        ]
      )
    );
  }

  Widget walletSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4)
          )
        ]
      ),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                child: Icon(Icons.account_balance_wallet, color: Colors.blue.shade300),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rp100.000", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("0 Coins", style: TextStyle(fontSize: 14, color: Colors.grey))
                ],
              ),
            ],
          ),
          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              walletButton("Bayar", Icons.upload),
              const SizedBox(width: 16),
              walletButton("Top Up", Icons.add),
              const SizedBox(width: 16),
              walletButton("Lainnya", Icons.more_horiz)
            ],
          )
        ],
      ),
    );
  }

  Widget walletButton(String text, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade300,
          child: Icon(icon, color: Colors.grey.shade100),
        ),
        const SizedBox(height: 5),
        Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget serviceGrid() {
    List<Map<String, dynamic>> services = [
      {
        "icon": Icons.motorcycle,
        "label": "GoRide"
      },
      {
        "icon": Icons.directions_car,
        "label": "GoCar"
      },
      {
        "icon": Icons.fastfood,
        "label": "GoFood"
      },
      {
        "icon": Icons.local_shipping,
        "label": "GoSend"
      },
      {
        "icon": Icons.shopping_basket,
        "label": "GoMart"
      },
      {
        "icon": Icons.monetization_on,
        "label": "GoPay Pinjam"
      },
      {
        "icon": Icons.thumb_up,
        "label": "GoFood Hemat"
      },
      {
        "icon": Icons.more_horiz,
        "label": "Lainnya"
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (services[index]["label"] == "GoRide" || services[index]["label"] == "GoCar") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RideLoadingPage()),
              );
            }
          },
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(services[index]["icon"], color: Colors.grey.shade100),
              ),
              const SizedBox(height: 5),
              Text(services[index]["label"], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)
            ],
          )
        );
      }
    );
  }

  Widget subscriptionBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(10)
      ),
      child: const Text(
        "Diskon s.d. 10rb/transaksi. Yuk, langganan",
        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}