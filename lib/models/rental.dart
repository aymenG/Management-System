class Rental {
  final int? id;
  final String customerName;
  final int carId;
  final DateTime rentDate;
  final DateTime? returnDate;
  final double? totalPrice;

  Rental({
    this.id,
    required this.customerName,
    required this.carId,
    required this.rentDate,
    this.returnDate,
    this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_name': customerName,
      'car_id': carId,
      'rent_date': rentDate.toIso8601String(),
      'return_date': returnDate?.toIso8601String(),
      'total_price': totalPrice,
    };
  }

  factory Rental.fromMap(Map<String, dynamic> map) {
    return Rental(
      id: map['id'] as int?,
      customerName: map['customer_name'] as String,
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
