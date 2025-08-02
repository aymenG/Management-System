// lib/utils/enum_localizations.dart

import 'package:flutter/material.dart';
import 'package:management_system/l10n/app_localizations.dart';
import 'package:management_system/models/car_status.dart'; // Make sure this path is correct

// The LocalizedCarBrand extension should be removed from this file.

extension LocalizedCarStatus on CarStatus {
  String displayLocalized(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (this) {
      case CarStatus.available:
        return localizations.carStatusAvailable;
      case CarStatus.rented:
        return localizations.carStatusRented;
      case CarStatus.maintenance:
        return localizations.carStatusUnderMaintenance;
      case CarStatus.archived:
        return localizations.carStatusArchived;
      // Add all other CarStatus values here if you have more, matching your .arb keys
    }
  }
}
