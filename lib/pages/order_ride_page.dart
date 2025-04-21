import 'package:flutter/material.dart';
import 'package:goceng/pages/rating_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';

class OrderRidePage extends StatefulWidget {
  final String destination;
  final int price;

  const OrderRidePage({super.key, required this.destination, required this.price});

  @override
  State<OrderRidePage> createState() => _OrderRidePageState();
}

class _OrderRidePageState extends State<OrderRidePage> with TickerProviderStateMixin {
  Position? _currentPosition;
  late GoogleMapController _mapController;
  late TabController _tabController;
  int _selectedTabIndex = 0;
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  void _createPolylines(double destLat, double destLng) async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDUqllpoPvISz4JLl32741ZQuUvf__Pn4k',
      PointLatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      PointLatLng(destLat, destLng),
      travelMode: TravelMode.driving,
    );
    debugPrint("Polyline status: ${result.status}");

    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      setState(() {
        _polylines.add(
          Polyline(
            polylineId: PolylineId("route"),
            color: Colors.green,
            width: 5,
            points: polylineCoordinates,
          ),
        );
      });
    }
  }

  Future<LatLng> _getDestinationLatLng(String destination) async {
    List<Location> locations = await locationFromAddress(destination);
    final first = locations.first;
    return LatLng(first.latitude, first.longitude);
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
    });

    LatLng destinationLatLng = await _getDestinationLatLng(widget.destination);
    debugPrint("Destination lat: ${destinationLatLng.latitude} Destination long: ${destinationLatLng.longitude}");
    _createPolylines(destinationLatLng.latitude, destinationLatLng.longitude);

    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId("destination"),
          position: destinationLatLng,
          infoWindow: InfoWindow(title: widget.destination),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _currentPosition == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 13,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: (controller) => _mapController = controller,
              polylines: _polylines,
              markers: _markers,
            ),

            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.my_location, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(child: Text("Lokasi saat ini")),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.orange),
                        const SizedBox(width: 8),
                        Expanded(child: Text(widget.destination)),
                        const Icon(Icons.add_circle_outline, color: Colors.orange),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.green,
                      tabs: const [
                        Tab(text: "Buat kamu"),
                        Tab(text: "Hemat"),
                        Tab(text: "Ekstra"),
                      ],
                    ),
                    SizedBox(
                      height: 110,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildRideOption("GoRide Comfort", "Motor baru, jok lebih lebar", widget.price + 1500, "assets/gojek_comfort.jpg"),
                          _buildRideOption("GoRide", "Teman jalan sehari-hari", widget.price, "assets/gojek.jpg"),
                          _buildRideOption("GoCar", "Untuk 4 orang", widget.price + 18000, "assets/gocar.jpg"),
                        ],
                      ),
                    ),
                    //const SizedBox(height: 12),

                    Row(
                      children: const [
                        Icon(Icons.money, size: 18),
                        SizedBox(width: 8),
                        Text("Metode Pembayaran: "),
                        Spacer(),
                        Text("Tunai", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(Icons.local_offer, size: 18),
                        const SizedBox(width: 8),
                        const Text("Diskon: "),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text("Rp3.000", style: TextStyle(color: Colors.green)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RatingPage(
                            destination: widget.destination,
                            price: _getSelectedPrice(),
                            service: _getSelectedService(),
                          ))
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50), // pill shape
                        ),
                        elevation: 5
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cari ${_getSelectedService()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Rp ${_getSelectedPrice()}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_circle_right, color: Colors.white),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideOption(String title, String subtitle, int price, String iconPath) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      leading: Container(
        width: 48,
        height: 48,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            iconPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Text("Rp $price", style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  int _getSelectedPrice() {
    switch (_selectedTabIndex) {
      case 0:
        return widget.price + 1500;
      case 1:
        return widget.price;
      case 2:
        return widget.price + 18000;
      default:
        return widget.price;
    }
  }

  String _getSelectedService() {
    switch (_selectedTabIndex) {
      case 0:
        return "GoRide Comfort";
      case 1:
        return "GoRide";
      case 2:
        return "GoCar";
      default:
        return "GoRide";
    }
  }
}