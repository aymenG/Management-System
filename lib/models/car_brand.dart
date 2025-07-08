// lib/models/car_brand.dart

enum CarBrand {
  toyota,
  honda,
  hyundai,
  kia,
  ford,
  bmw,
  mercedes,
  volkswagen,
  nissan,
  peugeot,
  renault,
  audi,
  chevrolet,
  fiat,
  jeep,
  mazda,
  mitsubishi,
  skoda,
  suzuki,
  tesla,
}

extension CarBrandExtension on CarBrand {
  String get displayName {
    // Capitalize nicely, e.g. "Volkswagen"
    return name[0].toUpperCase() + name.substring(1);
  }
}
