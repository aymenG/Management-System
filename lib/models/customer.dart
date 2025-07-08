class Customer {
  final int? id;
  final String fullName;
  final String? phone;
  final String? email;

  Customer({this.id, required this.fullName, this.phone, this.email});

  // Convert a Customer into a Map for DB operations
  Map<String, dynamic> toMap() {
    return {'id': id, 'full_name': fullName, 'phone': phone, 'email': email};
  }

  // Create a Customer from a DB Map
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as int?,
      fullName: map['full_name'] as String,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
    );
  }
}
