// lib/models/rental.dart

class Rental {
  final int? id; // 'id' is nullable as it's auto-incremented by the DB
  final String customerName;
  final int carId;
  final String rentDate; // Stored as 'YYYY-MM-DD' string
  final String? returnDate; // Stored as 'YYYY-MM-DD' string, can be null
  final double totalPrice; // <--- This is now NON-NULLABLE

  Rental({
    this.id, // 'id' is optional for new rentals
    required this.customerName,
    required this.carId,
    required this.rentDate,
    this.returnDate, // 'returnDate' is optional
    required this.totalPrice, // <--- This is now REQUIRED in constructor
  });

  // Convert a Rental object into a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include id if it's not null (for updates)
      'customer_name': customerName,
      'car_id': carId,
      'rent_date': rentDate,
      'return_date': returnDate,
      'total_price': totalPrice, // Will always be a double
    };
  }

  // Create a Rental object from a Map (e.g., from database query results)
  factory Rental.fromMap(Map<String, dynamic> map) {
    return Rental(
      id: map['id'] as int?, // Safely cast to nullable int
      customerName: map['customer_name'] as String,
      carId: map['car_id'] as int,
      rentDate: map['rent_date'] as String,
      returnDate:
          map['return_date'] as String?, // Safely cast to nullable String
      totalPrice:
          map['total_price']
              as double, // <--- Safely cast to NON-NULLABLE double
    );
  }
}
