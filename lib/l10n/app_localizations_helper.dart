import 'package:flutter/material.dart';
import 'package:management_system/l10n/app_localizations.dart';

class AppLocalizationsHelper {
  final BuildContext context;

  AppLocalizationsHelper(this.context);

  String get dashboardTitle => AppLocalizations.of(context)!.dashboardTitle;
  String get dailyIncome => AppLocalizations.of(context)!.dailyIncome;
  String get monthlyIncome => AppLocalizations.of(context)!.monthlyIncome;
  String get dailyRentals => AppLocalizations.of(context)!.dailyRentals;
  String get monthlyRentals => AppLocalizations.of(context)!.monthlyRentals;
  String get topRentedCars => AppLocalizations.of(context)!.topRentedCars;
  String get noRentalsYet => AppLocalizations.of(context)!.noRentalsYet;
  String get welcome => AppLocalizations.of(context)!.welcome;
  String get home => AppLocalizations.of(context)!.home;
  String get availableCars => AppLocalizations.of(context)!.availableCars;
  String get rentals => AppLocalizations.of(context)!.rentals;
  String get archive => AppLocalizations.of(context)!.archive;
  String get settings => AppLocalizations.of(context)!.settings;
  String get signOut => AppLocalizations.of(context)!.signOut;
}
