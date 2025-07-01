// models/car.dart
class Car {
  final int? id; // id can be null before inserting into DB
  final String name;
  final String matricule;
  final double dailyPrice;
  final String imagePath;
  String status; // Default status

  Car({
    this.id,
    required this.name,
    required this.matricule,
    required this.dailyPrice,
    required this.imagePath,
    this.status = 'available',
  });
}
