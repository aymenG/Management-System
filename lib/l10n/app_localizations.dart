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

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Car Rental Management System'**
  String get appTitle;

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

  /// No description provided for @carManagement.
  ///
  /// In en, this message translates to:
  /// **'Car Management'**
  String get carManagement;

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

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

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

  /// No description provided for @actionCannotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone and will move the rental to archives.'**
  String get actionCannotBeUndone;

  /// No description provided for @currencySymbol.
  ///
  /// In en, this message translates to:
  /// **'DZD'**
  String get currencySymbol;

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

  /// No description provided for @addCarTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add New Car'**
  String get addCarTooltip;

  /// No description provided for @noCarsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No cars available'**
  String get noCarsAvailable;

  /// No description provided for @addFirstCarPrompt.
  ///
  /// In en, this message translates to:
  /// **'Add your first car to get started'**
  String get addFirstCarPrompt;

  /// No description provided for @totalCars.
  ///
  /// In en, this message translates to:
  /// **'Total Cars'**
  String get totalCars;

  /// No description provided for @rentedCars.
  ///
  /// In en, this message translates to:
  /// **'Rented Cars'**
  String get rentedCars;

  /// No description provided for @archivedCars.
  ///
  /// In en, this message translates to:
  /// **'Archived Cars'**
  String get archivedCars;

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

  /// No description provided for @editCarTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit Car'**
  String get editCarTooltip;

  /// No description provided for @archiveCarTooltip.
  ///
  /// In en, this message translates to:
  /// **'Archive Car'**
  String get archiveCarTooltip;

  /// No description provided for @restoreCarTooltip.
  ///
  /// In en, this message translates to:
  /// **'Restore Car'**
  String get restoreCarTooltip;

  /// No description provided for @deleteCarTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete Car Permanently'**
  String get deleteCarTooltip;

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

  /// No description provided for @carStatusUnderMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Under Maintenance'**
  String get carStatusUnderMaintenance;

  /// No description provided for @carStatusArchived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get carStatusArchived;

  /// No description provided for @confirmArchiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Archiving'**
  String get confirmArchiveTitle;

  /// No description provided for @archiveCarConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to archive this car? It will be moved to the archive page.'**
  String get archiveCarConfirmation;

  /// No description provided for @carArchivedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Car archived successfully!'**
  String get carArchivedSuccess;

  /// No description provided for @errorArchivingCar.
  ///
  /// In en, this message translates to:
  /// **'Error archiving car'**
  String get errorArchivingCar;

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

  /// No description provided for @carStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Car status updated to {status}!'**
  String carStatusUpdated(String status);

  /// No description provided for @errorUpdatingCarStatus.
  ///
  /// In en, this message translates to:
  /// **'Error updating car status'**
  String get errorUpdatingCarStatus;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Permanent Deletion'**
  String get confirmDeleteTitle;

  /// No description provided for @deleteCarConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete this car?'**
  String get deleteCarConfirmation;

  /// No description provided for @carDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Car deleted permanently!'**
  String get carDeletedSuccess;

  /// No description provided for @errorDeletingCar.
  ///
  /// In en, this message translates to:
  /// **'Error deleting car'**
  String get errorDeletingCar;

  /// No description provided for @errorLoadingCars.
  ///
  /// In en, this message translates to:
  /// **'Error loading cars'**
  String get errorLoadingCars;

  /// No description provided for @addCarPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Car'**
  String get addCarPageTitle;

  /// No description provided for @carBrandLabel.
  ///
  /// In en, this message translates to:
  /// **'Car Brand'**
  String get carBrandLabel;

  /// No description provided for @carModelLabel.
  ///
  /// In en, this message translates to:
  /// **'Car Model'**
  String get carModelLabel;

  /// No description provided for @manufacturingYearLabel.
  ///
  /// In en, this message translates to:
  /// **'Manufacturing Year'**
  String get manufacturingYearLabel;

  /// No description provided for @plateNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Plate Number'**
  String get plateNumberLabel;

  /// No description provided for @dailyRentalRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily Rental Rate'**
  String get dailyRentalRateLabel;

  /// No description provided for @carStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Car Status'**
  String get carStatusLabel;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @errorAddCar.
  ///
  /// In en, this message translates to:
  /// **'Error adding car'**
  String get errorAddCar;

  /// No description provided for @carAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Car added successfully!'**
  String get carAddedSuccess;

  /// No description provided for @carStatusPrompt.
  ///
  /// In en, this message translates to:
  /// **'Select Car Status'**
  String get carStatusPrompt;

  /// No description provided for @carUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Car updated successfully!'**
  String get carUpdateSuccess;

  /// No description provided for @errorUpdateCar.
  ///
  /// In en, this message translates to:
  /// **'Error updating car'**
  String get errorUpdateCar;

  /// No description provided for @editCarPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Car Details'**
  String get editCarPageTitle;

  /// No description provided for @rentalsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Active & Past Rentals'**
  String get rentalsPageTitle;

  /// No description provided for @exportRentalsButton.
  ///
  /// In en, this message translates to:
  /// **'Export Rentals to Excel'**
  String get exportRentalsButton;

  /// No description provided for @pickDateRangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick Date Range'**
  String get pickDateRangeTitle;

  /// No description provided for @noRentalsInDateRange.
  ///
  /// In en, this message translates to:
  /// **'No rentals found in selected range'**
  String get noRentalsInDateRange;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rentals exported successfully!'**
  String get exportSuccess;

  /// No description provided for @noRentalsFound.
  ///
  /// In en, this message translates to:
  /// **'No rentals found yet!'**
  String get noRentalsFound;

  /// No description provided for @addRentalHint.
  ///
  /// In en, this message translates to:
  /// **'Start by adding a new car rental.'**
  String get addRentalHint;

  /// No description provided for @rentalIdHeader.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get rentalIdHeader;

  /// No description provided for @customerHeader.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customerHeader;

  /// No description provided for @carBrandHeader.
  ///
  /// In en, this message translates to:
  /// **'Car Brand'**
  String get carBrandHeader;

  /// No description provided for @carModelHeader.
  ///
  /// In en, this message translates to:
  /// **'Car Model'**
  String get carModelHeader;

  /// No description provided for @plateNumberHeader.
  ///
  /// In en, this message translates to:
  /// **'Plate Number'**
  String get plateNumberHeader;

  /// No description provided for @rentDateHeader.
  ///
  /// In en, this message translates to:
  /// **'Rent Date'**
  String get rentDateHeader;

  /// No description provided for @returnDateHeader.
  ///
  /// In en, this message translates to:
  /// **'Return Date'**
  String get returnDateHeader;

  /// No description provided for @totalPriceHeader.
  ///
  /// In en, this message translates to:
  /// **'Total Price ({currencySymbol})'**
  String totalPriceHeader(Object currencySymbol);

  /// No description provided for @actionsHeader.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actionsHeader;

  /// No description provided for @editRentalTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit Rental'**
  String get editRentalTooltip;

  /// No description provided for @deleteRentalTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete Rental'**
  String get deleteRentalTooltip;

  /// No description provided for @errorLoadingRentals.
  ///
  /// In en, this message translates to:
  /// **'Error loading rentals'**
  String get errorLoadingRentals;

  /// No description provided for @rentalUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rental updated successfully!'**
  String get rentalUpdatedSuccess;

  /// No description provided for @errorRentalNotFound.
  ///
  /// In en, this message translates to:
  /// **'Error: Rental with ID {id} not found for editing.'**
  String errorRentalNotFound(int id);

  /// No description provided for @errorEditNullRentalId.
  ///
  /// In en, this message translates to:
  /// **'Error: Attempted to edit a rental with a null ID.'**
  String get errorEditNullRentalId;

  /// No description provided for @errorDeleteNullRentalId.
  ///
  /// In en, this message translates to:
  /// **'Error: Attempted to delete a rental with a null ID.'**
  String get errorDeleteNullRentalId;

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

  /// No description provided for @rentalDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rental deleted successfully!'**
  String get rentalDeletedSuccess;

  /// No description provided for @errorDeletingRental.
  ///
  /// In en, this message translates to:
  /// **'Error deleting rental'**
  String get errorDeletingRental;

  /// No description provided for @addRentalButton.
  ///
  /// In en, this message translates to:
  /// **'Add New Rental'**
  String get addRentalButton;

  /// No description provided for @confirmBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Rental Booking'**
  String get confirmBookingTitle;

  /// No description provided for @confirmBookingMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to book this rental?'**
  String get confirmBookingMessage;

  /// No description provided for @customerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerNameLabel;

  /// No description provided for @customerPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer Phone'**
  String get customerPhoneLabel;

  /// No description provided for @rentDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Rent Date'**
  String get rentDateLabel;

  /// No description provided for @returnDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Return Date'**
  String get returnDateLabel;

  /// No description provided for @totalPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPriceLabel;

  /// No description provided for @errorBookingRental.
  ///
  /// In en, this message translates to:
  /// **'Error booking rental'**
  String get errorBookingRental;

  /// No description provided for @rentalBookedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rental booked successfully!'**
  String get rentalBookedSuccess;

  /// No description provided for @selectCustomerMessage.
  ///
  /// In en, this message translates to:
  /// **'Select Customer'**
  String get selectCustomerMessage;

  /// No description provided for @noCustomerSelected.
  ///
  /// In en, this message translates to:
  /// **'No customer selected'**
  String get noCustomerSelected;

  /// No description provided for @pickCustomerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a Customer'**
  String get pickCustomerTitle;

  /// No description provided for @customerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search customers...'**
  String get customerSearchHint;

  /// No description provided for @addNewCustomerButton.
  ///
  /// In en, this message translates to:
  /// **'Add New Customer'**
  String get addNewCustomerButton;

  /// No description provided for @addCustomerDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Customer'**
  String get addCustomerDialogTitle;

  /// No description provided for @customerNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter customer name'**
  String get customerNameHint;

  /// No description provided for @customerPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter customer phone'**
  String get customerPhoneHint;

  /// No description provided for @customerAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Enter customer address (optional)'**
  String get customerAddressHint;

  /// No description provided for @errorAddCustomer.
  ///
  /// In en, this message translates to:
  /// **'Error adding customer'**
  String get errorAddCustomer;

  /// No description provided for @customerAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Customer added successfully!'**
  String get customerAddedSuccess;

  /// No description provided for @selectCarMessage.
  ///
  /// In en, this message translates to:
  /// **'Select Car'**
  String get selectCarMessage;

  /// No description provided for @carSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search cars...'**
  String get carSearchHint;

  /// No description provided for @selectCarTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a Car'**
  String get selectCarTitle;

  /// No description provided for @noCarSelected.
  ///
  /// In en, this message translates to:
  /// **'No car selected'**
  String get noCarSelected;

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

  /// No description provided for @archivedRentalsAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Rentals you archive will appear here.'**
  String get archivedRentalsAppearHere;

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
  /// **'Error restoring car'**
  String get errorRestoringCar;

  /// No description provided for @carPermanentlyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Car permanently deleted!'**
  String get carPermanentlyDeleted;

  /// No description provided for @errorDeletingCarPermanently.
  ///
  /// In en, this message translates to:
  /// **'Error deleting car permanently'**
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
  /// **'Error restoring rental'**
  String get errorRestoringRental;

  /// No description provided for @rentalPermanentlyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Rental permanently deleted!'**
  String get rentalPermanentlyDeleted;

  /// No description provided for @errorDeletingRentalPermanently.
  ///
  /// In en, this message translates to:
  /// **'Error deleting rental permanently'**
  String get errorDeletingRentalPermanently;

  /// No description provided for @loginEnterCredentials.
  ///
  /// In en, this message translates to:
  /// **'Please enter both username and password.'**
  String get loginEnterCredentials;

  /// No description provided for @loginUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get loginUserNotFound;

  /// No description provided for @loginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {username}!'**
  String loginWelcome(String username);

  /// No description provided for @loginIncorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get loginIncorrectPassword;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get loginTitle;

  /// No description provided for @loginUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get loginUsernameLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get loginPasswordLabel;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @archiveRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get archiveRestoreTitle;

  /// No description provided for @archiveConfirmRestore.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to restore this item?'**
  String get archiveConfirmRestore;

  /// No description provided for @archiveCarsTab.
  ///
  /// In en, this message translates to:
  /// **'Cars'**
  String get archiveCarsTab;

  /// No description provided for @archiveRentalsTab.
  ///
  /// In en, this message translates to:
  /// **'Rentals'**
  String get archiveRentalsTab;

  /// No description provided for @archiveNoArchivedCars.
  ///
  /// In en, this message translates to:
  /// **'No archived cars.'**
  String get archiveNoArchivedCars;

  /// No description provided for @archiveRestoreCarTooltip.
  ///
  /// In en, this message translates to:
  /// **'Restore Car'**
  String get archiveRestoreCarTooltip;

  /// No description provided for @archiveNoArchivedRentals.
  ///
  /// In en, this message translates to:
  /// **'No archived rentals.'**
  String get archiveNoArchivedRentals;

  /// No description provided for @archiveUnknownCustomer.
  ///
  /// In en, this message translates to:
  /// **'Unknown Customer'**
  String get archiveUnknownCustomer;

  /// No description provided for @archiveRentalDetails.
  ///
  /// In en, this message translates to:
  /// **'Car: {brand} {model} - Plate: {plateNumber}\nRent: {rentDate} → Return: {returnDate}'**
  String archiveRentalDetails(
    String brand,
    String model,
    String plateNumber,
    String rentDate,
    String returnDate,
  );

  /// No description provided for @archiveRestoreRentalTooltip.
  ///
  /// In en, this message translates to:
  /// **'Restore Rental'**
  String get archiveRestoreRentalTooltip;
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
