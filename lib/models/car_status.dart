// lib/models/car_status.dart

enum CarStatus { available, rented, maintenance }

extension CarStatusExtension on CarStatus {
  String get displayName {
    return name[0].toUpperCase() + name.substring(1);
  }
}
