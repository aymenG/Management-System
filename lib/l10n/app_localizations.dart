import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @errorLoadingCars.
  ///
  /// In en, this message translates to:
  /// **'Error loading cars:'**
  String get errorLoadingCars;

  /// No description provided for @carDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Car deleted successfully!'**
  String get carDeletedSuccess;

  /// No description provided for @errorArchivingCar.
  ///
  /// In en, this message translates to:
  /// **'Error archiving car:'**
  String get errorArchivingCar;

  /// No description provided for @carStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Car status updated to {status}!'**
  String carStatusUpdated(String status);

  /// No description provided for @errorUpdatingCarStatus.
  ///
  /// In en, this message translates to:
  /// **'Error updating car status:'**
  String get errorUpdatingCarStatus;

  /// No description provided for @availableCarsTitle.
  ///
  /// In en, this message translates to:
  /// **'Available Cars'**
  String get availableCarsTitle;

  /// No description provided for @addCarButton.
  ///
  /// In en, this message translates to:
  /// **'Add Car'**
  String get addCarButton;

  /// No description provided for @noCarsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No cars available'**
  String get noCarsAvailable;

  /// No description provided for @addFirstCarHint.
  ///
  /// In en, this message translates to:
  /// **'Add your first car to get started'**
  String get addFirstCarHint;

  /// No description provided for @plateNumber.
  ///
  /// In en, this message translates to:
  /// **'Plate: {number}'**
  String plateNumber(String number);

  /// No description provided for @carYear.
  ///
  /// In en, this message translates to:
  /// **'Year: {year}'**
  String carYear(int year);

  /// No description provided for @dailyPrice.
  ///
  /// In en, this message translates to:
  /// **'{price} {currencySymbol}/day'**
  String dailyPrice(String price, String currencySymbol);

  /// No description provided for @rentButton.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rentButton;

  /// No description provided for @returnButton.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get returnButton;

  /// No description provided for @editButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editButton;

  /// No description provided for @deleteCarTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete Car'**
  String get deleteCarTooltip;

  /// No description provided for @archiveCarTitle.
  ///
  /// In en, this message translates to:
  /// **'Archive Car'**
  String get archiveCarTitle;

  /// No description provided for @archiveCarConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to archive this car? It will be moved to the archive page.'**
  String get archiveCarConfirmation;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @returnCarTitle.
  ///
  /// In en, this message translates to:
  /// **'Return Car'**
  String get returnCarTitle;

  /// No description provided for @returnCarConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to return this car?'**
  String get returnCarConfirmation;

  /// No description provided for @carStatusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get carStatusAvailable;

  /// No description provided for @carStatusRented.
  ///
  /// In en, this message translates to:
  /// **'Rented'**
  String get carStatusRented;

  /// No description provided for @carStatusMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get carStatusMaintenance;

  /// No description provided for @carStatusArchived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get carStatusArchived;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Car Management System'**
  String get appTitle;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @availableCars.
  ///
  /// In en, this message translates to:
  /// **'Available Cars'**
  String get availableCars;

  /// No description provided for @rentals.
  ///
  /// In en, this message translates to:
  /// **'Rentals'**
  String get rentals;

  /// No description provided for @archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archive;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @confirmExit.
  ///
  /// In en, this message translates to:
  /// **'Confirm Exit'**
  String get confirmExit;

  /// No description provided for @areYouSureToClose.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to close the application?'**
  String get areYouSureToClose;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get pageNotFound;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard Overview'**
  String get dashboardTitle;

  /// No description provided for @dailyIncome.
  ///
  /// In en, this message translates to:
  /// **'Daily Income'**
  String get dailyIncome;

  /// No description provided for @monthlyIncome.
  ///
  /// In en, this message translates to:
  /// **'Monthly Income'**
  String get monthlyIncome;

  /// No description provided for @dailyRentals.
  ///
  /// In en, this message translates to:
  /// **'Daily Rentals'**
  String get dailyRentals;

  /// No description provided for @monthlyRentals.
  ///
  /// In en, this message translates to:
  /// **'Monthly Rentals'**
  String get monthlyRentals;

  /// No description provided for @currencySymbol.
  ///
  /// In en, this message translates to:
  /// **'DZD'**
  String get currencySymbol;

  /// No description provided for @topRentedCars.
  ///
  /// In en, this message translates to:
  /// **'Top 5 Rented Cars'**
  String get topRentedCars;

  /// No description provided for @noRentalsYet.
  ///
  /// In en, this message translates to:
  /// **'No rentals recorded yet.'**
  String get noRentalsYet;

  /// No description provided for @unknownCar.
  ///
  /// In en, this message translates to:
  /// **'Unknown Car'**
  String get unknownCar;

  /// No description provided for @numberOfRentals.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No rentals} one{1 rental} other{{count} rentals}}'**
  String numberOfRentals(int count);

  /// No description provided for @addFirstCarPrompt.
  ///
  /// In en, this message translates to:
  /// **'Add your first car to get started'**
  String get addFirstCarPrompt;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @carArchivedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Car archived successfully!'**
  String get carArchivedSuccess;

  /// No description provided for @columnId.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get columnId;

  /// No description provided for @columnBrand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get columnBrand;

  /// No description provided for @columnModel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get columnModel;

  /// No description provided for @columnYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get columnYear;

  /// No description provided for @columnPlateNumber.
  ///
  /// In en, this message translates to:
  /// **'Plate Number'**
  String get columnPlateNumber;

  /// No description provided for @columnDailyPrice.
  ///
  /// In en, this message translates to:
  /// **'Daily Price (DZD)'**
  String get columnDailyPrice;

  /// No description provided for @columnStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get columnStatus;

  /// No description provided for @columnActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get columnActions;

  /// No description provided for @rentalsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Active & Past Rentals'**
  String get rentalsPageTitle;

  /// No description provided for @noRentalsFound.
  ///
  /// In en, this message translates to:
  /// **'No rentals found yet!'**
  String get noRentalsFound;

  /// No description provided for @startAddingRentalPrompt.
  ///
  /// In en, this message translates to:
  /// **'Start by adding a new car rental.'**
  String get startAddingRentalPrompt;

  /// No description provided for @editRentalButton.
  ///
  /// In en, this message translates to:
  /// **'Edit Rental'**
  String get editRentalButton;

  /// No description provided for @archiveRentalButton.
  ///
  /// In en, this message translates to:
  /// **'Archive Rental'**
  String get archiveRentalButton;

  /// No description provided for @confirmArchivingRentalTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Archiving'**
  String get confirmArchivingRentalTitle;

  /// No description provided for @archiveRentalConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to archive this rental? Archived rentals can be restored later.'**
  String get archiveRentalConfirmation;

  /// No description provided for @rentalArchivedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rental archived successfully!'**
  String get rentalArchivedSuccess;

  /// No description provided for @errorArchivingRental.
  ///
  /// In en, this message translates to:
  /// **'Error archiving rental:'**
  String get errorArchivingRental;

  /// No description provided for @errorLoadingRentals.
  ///
  /// In en, this message translates to:
  /// **'Error loading rentals:'**
  String get errorLoadingRentals;

  /// No description provided for @confirmDeletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get confirmDeletionTitle;

  /// No description provided for @deleteRentalConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this rental?'**
  String get deleteRentalConfirmation;

  /// No description provided for @actionCannotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get actionCannotBeUndone;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @rentalDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rental deleted successfully!'**
  String get rentalDeletedSuccess;

  /// No description provided for @errorDeletingRental.
  ///
  /// In en, this message translates to:
  /// **'Error deleting rental:'**
  String get errorDeletingRental;

  /// No description provided for @columnCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get columnCustomer;

  /// No description provided for @columnCarBrand.
  ///
  /// In en, this message translates to:
  /// **'Car Brand'**
  String get columnCarBrand;

  /// No description provided for @columnCarModel.
  ///
  /// In en, this message translates to:
  /// **'Car Model'**
  String get columnCarModel;

  /// No description provided for @columnRentDate.
  ///
  /// In en, this message translates to:
  /// **'Rent Date'**
  String get columnRentDate;

  /// No description provided for @columnReturnDate.
  ///
  /// In en, this message translates to:
  /// **'Return Date'**
  String get columnReturnDate;

  /// No description provided for @columnTotalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price (DZD)'**
  String get columnTotalPrice;

  /// No description provided for @archivePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Archived Items'**
  String get archivePageTitle;

  /// No description provided for @archivedCarsTab.
  ///
  /// In en, this message translates to:
  /// **'Archived Cars'**
  String get archivedCarsTab;

  /// No description provided for @archivedRentalsTab.
  ///
  /// In en, this message translates to:
  /// **'Archived Rentals'**
  String get archivedRentalsTab;

  /// No description provided for @noArchivedCarsFound.
  ///
  /// In en, this message translates to:
  /// **'No archived cars found!'**
  String get noArchivedCarsFound;

  /// No description provided for @noArchivedRentalsFound.
  ///
  /// In en, this message translates to:
  /// **'No archived rentals found!'**
  String get noArchivedRentalsFound;

  /// No description provided for @restoreCarButton.
  ///
  /// In en, this message translates to:
  /// **'Restore Car'**
  String get restoreCarButton;

  /// No description provided for @deletePermanentlyButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Permanently'**
  String get deletePermanentlyButton;

  /// No description provided for @confirmPermanentDeletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Permanent Deletion'**
  String get confirmPermanentDeletionTitle;

  /// No description provided for @permanentDeleteCarConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to PERMANENTLY delete this car? This action cannot be undone.'**
  String get permanentDeleteCarConfirmation;

  /// No description provided for @carRestoredSuccess.
  ///
  /// In en, this message translates to:
  /// **'Car restored successfully!'**
  String get carRestoredSuccess;

  /// No description provided for @errorRestoringCar.
  ///
  /// In en, this message translates to:
  /// **'Error restoring car:'**
  String get errorRestoringCar;

  /// No description provided for @carPermanentlyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Car permanently deleted!'**
  String get carPermanentlyDeleted;

  /// No description provided for @errorDeletingCarPermanently.
  ///
  /// In en, this message translates to:
  /// **'Error deleting car permanently:'**
  String get errorDeletingCarPermanently;

  /// No description provided for @restoreRentalButton.
  ///
  /// In en, this message translates to:
  /// **'Restore Rental'**
  String get restoreRentalButton;

  /// No description provided for @permanentDeleteRentalConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to PERMANENTLY delete this rental? This action cannot be undone.'**
  String get permanentDeleteRentalConfirmation;

  /// No description provided for @rentalRestoredSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rental restored successfully!'**
  String get rentalRestoredSuccess;

  /// No description provided for @errorRestoringRental.
  ///
  /// In en, this message translates to:
  /// **'Error restoring rental:'**
  String get errorRestoringRental;

  /// No description provided for @rentalPermanentlyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Rental permanently deleted!'**
  String get rentalPermanentlyDeleted;

  /// No description provided for @errorDeletingRentalPermanently.
  ///
  /// In en, this message translates to:
  /// **'Error deleting rental permanently:'**
  String get errorDeletingRentalPermanently;

  /// No description provided for @archivedRentalsAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Rentals you archive will appear here.'**
  String get archivedRentalsAppearHere;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
