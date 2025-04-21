import 'package:flutter/material.dart';
import 'package:goceng/pages/activity_page.dart';
import 'package:goceng/pages/chat_page.dart';
import 'package:goceng/pages/promo_page.dart';
import 'package:goceng/pages/home_page.dart';
import 'components/bottom_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final GlobalKey<ActivityPageState> activityPageKey = GlobalKey<ActivityPageState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const PromoPage(),
      ActivityPage(key: activityPageKey),
      const ChatPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;

            if (index == 2) {
              activityPageKey.currentState?.loadOrders();
            }
          });
        },
      ),
    );
  }
}