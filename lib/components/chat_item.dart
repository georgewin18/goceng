import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String date;
  final bool hasNotification;

  const ChatItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.date,
    this.hasNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade200,
        child: const Icon(Icons.account_circle, color: Colors.white, size: 28),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: hasNotification
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(date, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 8,
                  child: Text(
                    "1",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ],
            )
          : Text(date, style: const TextStyle(fontSize: 12)),
    );
  }
}
