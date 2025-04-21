import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../pages/onboarding_ride_page.dart';

class RideLoadingPage extends StatefulWidget {
  const RideLoadingPage({super.key});

  @override
  State<RideLoadingPage> createState() => _OnboardingRideLoadingPageState();
}

class _OnboardingRideLoadingPageState extends State<RideLoadingPage> {
  @override
  void initState() {
    super.initState();
    _initLocationAndNavigate();
  }

  Future<void> _initLocationAndNavigate() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OnboardingRidePage(currentPosition: position),
        ),
      );
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
