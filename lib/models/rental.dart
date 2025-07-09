class Rental {
  final int? id;
  final int customerId;
  final int carId;
  final DateTime rentDate;
  final DateTime? returnDate;
  final double? totalPrice;

  Rental({
    this.id,
    required this.customerId,
    required this.carId,
    required this.rentDate,
    this.returnDate,
    this.totalPrice,
  });

  // Convert Rental to Map for DB operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customerId,
      'car_id': carId,
      'rent_date': rentDate.toIso8601String(),
      'return_date': returnDate?.toIso8601String(),
      'total_price': totalPrice,
    };
  }

  // Create a Rental from DB map
  factory Rental.fromMap(Map<String, dynamic> map) {
    return Rental(
      id: map['id'] as int?,
      customerId: map['customer_id'] as int,
      carId: map['car_id'] as int,
      rentDate: DateTime.parse(map['rent_date'] as String),
      returnDate: map['return_date'] != null
          ? DateTime.parse(map['return_date'] as String)
          : null,
      totalPrice: map['total_price'] != null
          ? (map['total_price'] as num).toDouble()
          : null,
    );
  }
}
