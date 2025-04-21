import 'package:flutter/material.dart';
import 'package:goceng/components/activity_card.dart';
import 'package:goceng/db/db_helper.dart';
import 'package:goceng/models/order.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => ActivityPageState();
}

class ActivityPageState extends State<ActivityPage> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    final data = await DBHelper.getOrders();
    setState(() {
      orders = data.reversed.toList();
    });
  }

  String getImageByService(String serviceType) {
    if (serviceType.toLowerCase().contains("gocar")) {
      return "assets/gocar.jpg";
    } else if (serviceType.toLowerCase().contains("comfort")) {
      return "assets/gojek_comfort.jpg";
    }
    return "assets/gojek.jpg"; // default GoRide
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aktivitas", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: orders.isEmpty
          ? const Center(child: Text("Belum ada histori pesanan."))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ActivityCard(
            dateTime: order.dateTime,
            title: order.destination,
            price: "Rp ${order.price}",
            imagePath: getImageByService(order.serviceType),
          );
        },
      ),
    );
  }
}