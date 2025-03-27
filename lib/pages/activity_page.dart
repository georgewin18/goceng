import 'package:flutter/material.dart';
import 'package:goceng/components/activity_card.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aktivitas", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ActivityCard(
            dateTime: "21 Feb, 11:09",
            title: "Adi Jasa",
            price: "Rp27.000",
            imagePath: "assets/gojek.jpeg"
          ),
          ActivityCard(
            dateTime: "16 Feb, 14:01",
            title: "Rumah Sakit Universitas Airlan...",
            price: "Rp36.000",
            imagePath: "assets/gocar.jpeg",
          ),
          ActivityCard(
            dateTime: "15 Feb, 18:44",
            title: "Rumah Sakit Universitas Airlan...",
            price: "Rp36.000",
            imagePath: "assets/gocar.jpeg",
          ),
        ]
      ),
    );
  }
}