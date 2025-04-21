import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:goceng/db/db_helper.dart';
import 'package:goceng/models/order.dart';

class RatingPage extends StatefulWidget {
  final int price;
  final String service;
  final String destination;

  const RatingPage({
    super.key,
    required this.destination,
    required this.price,
    required this.service,
  });

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double _rating = 5.0;
  int? _selectedTip;
  final TextEditingController _commentController = TextEditingController();

  final List<int> tipOptions = [2500, 5000, 10000, 15000, 25000];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Perjalanan Anda', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.account_circle, size: 60, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Slamet Rahardjo", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(widget.service, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text("Rp ${widget.price}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("Tunai", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 24),

            Text(
              getRatingText(_rating),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 36,
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 24),

            const Text("Ingin memberi driver tip? (optional)"),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: tipOptions.map((amount) {
                final isSelected = _selectedTip == amount;
                return ChoiceChip(
                  label: Text("Rp ${amount ~/ 1000}.${(amount % 1000).toString().padLeft(3, '0')}"),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedTip = amount;
                    });
                  },
                  selectedColor: Colors.orange,
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: "Add Comment",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final now = DateTime.now();
                  final formattedDate = "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}";

                  final totalPrice = widget.price + (_selectedTip ?? 0);

                  final order = Order(
                    destination: widget.destination,
                    dateTime: formattedDate,
                    price: totalPrice,
                    rating: _rating,
                    serviceType: widget.service,
                  );

                  await DBHelper.createOrder(order);

                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("SUBMIT", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getRatingText(double rating) {
    if (rating >= 4.5) return "Mantap deh";
    if (rating >= 4.0) return "Puas";
    if (rating >= 3.0) return "Cukup";
    if (rating >= 2.0) return "Kurang Memuaskan";
    return "Mengecewakan";
  }
}