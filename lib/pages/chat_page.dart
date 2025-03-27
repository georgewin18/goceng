import 'package:flutter/material.dart';
import 'package:goceng/components/chat_item.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pilihan Fitur",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _featureButton(Icons.mail, "Inbox", Colors.orange),
                    const SizedBox(width: 16),
                    _featureButton(Icons.help, "Bantuan", Colors.green),
                  ],
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Chat kamu",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
            )
          ),
          Expanded(
            child: ListView(
              children: const [
                ChatItem(title: "GoPay Pinjam", date: "30/08/23"),
                ChatItem(title: "GoPay Later", date: "02/04/23"),
                ChatItem(
                  title: "Jeklin",
                  subtitle: "Kamu punya pesan",
                  date: "20/12/21",
                  hasNotification: true
                )
              ]
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _featureButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 24,
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}