// lib/models/car.dart
import 'package:management_system/models/car_brand.dart';
import 'package:management_system/models/car_status.dart';

class Car {
  final int? id;
  final CarBrand brand;
  final String model;
  final int year;
  final String plateNumber;
  final double dailyPrice;
  final String? imagePath;
  CarStatus status;

  Car({
    this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.plateNumber,
    required this.dailyPrice,
    required this.imagePath,
    this.status = CarStatus.available,
  });

  String get fullName => "${brand.displayName} $model";

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand.name,
      'model': model,
      'year': year,
      'plate_number': plateNumber,
      'daily_price': dailyPrice,
      'image_path': (imagePath?.isEmpty ?? true) ? null : imagePath,
      'status': status.name,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'],
      brand: CarBrand.values.firstWhere(
        (b) => b.name == map['brand'],
        orElse: () => CarBrand.toyota,
      ),
      model: map['model'],
      year: map['year'],
      plateNumber: map['plate_number'],
      dailyPrice: map['daily_price'],
      imagePath: (map['image_path'] != null && map['image_path'] != '')
          ? map['image_path'] as String
          : null,
      status: CarStatus.values.firstWhere(
        (s) => s.name == map['status'],
        orElse: () => CarStatus.available,
      ),
    );
  }
}
