import 'package:flutter/material.dart';
import 'package:management_system/l10n/app_localizations.dart';

// It's generally better to directly use AppLocalizations.of(context)!
// where needed, or pass the localizer instance around, rather than
// creating a wrapper class like this. However, if you prefer this pattern
// for brevity, here's a corrected version.

class AppLocalizationsHelper {
  final BuildContext context;
  // Store the localizer instance to avoid repeated AppLocalizations.of(context)! calls
  final AppLocalizations localizer;

  AppLocalizationsHelper(this.context)
    : localizer = AppLocalizations.of(context)!; // Initialize here

  String get dashboardTitle => localizer.dashboardTitle;
  String get dailyIncome => localizer.dailyIncome;
  String get monthlyIncome => localizer.monthlyIncome;
  String get dailyRentals => localizer.dailyRentals;
  String get monthlyRentals => localizer.monthlyRentals;
  String get topRentedCars => localizer.topRentedCars;
  String get noRentalsYet => localizer.noRentalsYet;
  String get welcome => localizer.welcome;
  String get home => localizer.home;
  String get availableCarsTitle =>
      localizer.availableCarsTitle; // Corrected key
  String get rentals => localizer.rentals;
  String get archive => localizer.archive;
  String get settings => localizer.settings;
  String get signOut => localizer.signOut;

  // Add methods for localized strings that take parameters
  String numberOfRentals(int count) => localizer.numberOfRentals(count);
  String plateNumber(String number) => localizer.plateNumber(number);
  String carYear(int year) => localizer.carYear(year);
  String dailyPrice(String price, String currencySymbol) =>
      localizer.dailyPrice(price, currencySymbol);
  String carStatusUpdated(String status) => localizer.carStatusUpdated(status);
  String totalPriceHeader(Object currencySymbol) =>
      localizer.totalPriceHeader(currencySymbol);
  String errorRentalNotFound(int id) => localizer.errorRentalNotFound(id);
}
