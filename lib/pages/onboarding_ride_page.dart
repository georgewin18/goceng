import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goceng/pages/order_ride_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OnboardingRidePage extends StatefulWidget {
  final Position currentPosition;

  const OnboardingRidePage({super.key, required this.currentPosition});

  @override
  State<OnboardingRidePage> createState() => _OnboardingRidePageState();
}

class _OnboardingRidePageState extends State<OnboardingRidePage> {
  final List<Map<String, dynamic>> destinations = const [
    {
      "title": "Politeknik Elektronika Negeri Surabaya",
      "price": 26000,
      "originalPrice": 29000,
      "address": "Lokasi saat ini",
    },
    {
      "title": "Gereja Graha Gloria",
      "price": 15000,
      "originalPrice": 18000,
      "address": "Lokasi saat ini",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100),
                _buildGreeting(),
                const SizedBox(height: 40),
                _buildPromoBanner(),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      children: const [
        Text(
          "Cari udara segar?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Oke, sini Goceng anterin.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Pergi nonton pake 'GOINDONESIA'",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Tukar kodenya buat dapet diskon GoRide ke tempat nonton bola bersama.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSearchCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 150,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.currentPosition.latitude, widget.currentPosition.longitude),
                  zoom: 14,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: const [
                Icon(Icons.circle, color: Colors.orange, size: 12),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari lokasi tujuan",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.search, color: Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildDestinationList(),
        ],
      ),
    );
  }

  Widget _buildDestinationList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: destinations.map((destination) {
        return _buildDestinationItem(destination);
      }).toList(),
    );
  }

  Widget _buildDestinationItem(Map<String, dynamic> destination) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.access_time_filled, size: 20),
              const SizedBox(width: 8),
              Text(
                destination['title'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: _buildGoRideCard(
              destination['title'],
              destination['price'],
              destination['originalPrice'],
              destination['address'],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoRideCard(String title, int price, int originalPrice, String address) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderRidePage(
              destination: title,
              price: price,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "OneTap",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "GoRide",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_circle_right, size: 16, color: Colors.green),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text(
                  "GoPay",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Rp${price.toString()}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Rp${originalPrice.toString()}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.arrow_upward, color: Colors.green, size: 14),
                const SizedBox(width: 6),
                Text(
                  address,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
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