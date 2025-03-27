import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onProfileTap;
  
  const CustomSearchBar({Key? key, this.controller, this.onProfileTap}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child:  Stack(
        children: [
          Container(
            height: 40,
            margin: const EdgeInsets.only(right: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.1 * 255).toInt()),
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ]
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Joder Ka Dhani",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(5),
              ),
            ),
          ),

          Positioned(
            right: 0,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: IconButton(
                icon: Icon(Icons.person, color: Colors.green[900]),
                onPressed: () {

                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}