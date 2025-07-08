import 'dart:io';

import 'package:management_system/models/car_brand.dart';

class Car {
  final int? id;
  final CarBrand brand;
  final String model;
  final int year;
  final String plateNumber;
  final double dailyPrice;
  final String imagePath; // local file path chosen by user
  String status;

  Car({
    this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.plateNumber,
    required this.dailyPrice,
    required this.imagePath,
    this.status = 'available',
  });

  String get brandName => brand.name[0].toUpperCase() + brand.name.substring(1);

  String get fullName => "$brandName $model";

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand.name,
      'model': model,
      'year': year,
      'plate_number': plateNumber,
      'daily_price': dailyPrice,
      'image_path': imagePath,
      'status': status,
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
      imagePath: map['image_path'],
      status: map['status'],
    );
  }
}
