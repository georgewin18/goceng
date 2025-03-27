import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, -3),
          )
        ],
      ),
      child:BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green[900],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: "Promo"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Aktivitas"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        ],
      ),
    );
  }
}