class Order {
  final int? id;
  final String destination;
  final String dateTime;
  final int price;
  final double rating;
  final String serviceType;

  Order({
    this.id,
    required this.destination,
    required this.dateTime,
    required this.price,
    required this.rating,
    required this.serviceType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'destination': destination,
      'dateTime': dateTime,
      'price': price,
      'rating': rating,
      'serviceType': serviceType,
    };
  }

  static Order fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      destination: map['destination'],
      dateTime: map['dateTime'],
      price: map['price'],
      rating: map['rating'],
      serviceType: map['serviceType'],
    );
  }
}
