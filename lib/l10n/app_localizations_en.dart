// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Car Rental Management System';

  @override
  String get welcome => 'Welcome';

  @override
  String get home => 'Home';

  @override
  String get carManagement => 'Car Management';

  @override
  String get rentals => 'Rentals';

  @override
  String get archive => 'Archive';

  @override
  String get settings => 'Settings';

  @override
  String get signOut => 'Sign Out';

  @override
  String get closeButton => 'Close';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get deleteButton => 'Delete';

  @override
  String get confirmExit => 'Confirm Exit';

  @override
  String get areYouSureToClose =>
      'Are you sure you want to close the application?';

  @override
  String get pageNotFound => 'Page Not Found';

  @override
  String get actionCannotBeUndone =>
      'This action cannot be undone and will move the rental to archives.';

  @override
  String get currencySymbol => 'DZD';

  @override
  String get dashboardTitle => 'Dashboard Overview';

  @override
  String get dailyIncome => 'Daily Income';

  @override
  String get monthlyIncome => 'Monthly Income';

  @override
  String get dailyRentals => 'Daily Rentals';

  @override
  String get monthlyRentals => 'Monthly Rentals';

  @override
  String get topRentedCars => 'Top 5 Rented Cars';

  @override
  String get noRentalsYet => 'No rentals recorded yet.';

  @override
  String get unknownCar => 'Unknown Car';

  @override
  String numberOfRentals(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString rentals',
      one: '1 rental',
      zero: 'No rentals',
    );
    return '$_temp0';
  }

  @override
  String get availableCarsTitle => 'Available Cars';

  @override
  String get addCarButton => 'Add Car';

  @override
  String get addCarTooltip => 'Add New Car';

  @override
  String get noCarsAvailable => 'No cars available';

  @override
  String get addFirstCarPrompt => 'Add your first car to get started';

  @override
  String get totalCars => 'Total Cars';

  @override
  String get rentedCars => 'Rented Cars';

  @override
  String get archivedCars => 'Archived Cars';

  @override
  String get columnId => 'ID';

  @override
  String get columnBrand => 'Brand';

  @override
  String get columnModel => 'Model';

  @override
  String get columnYear => 'Year';

  @override
  String get columnPlateNumber => 'Plate Number';

  @override
  String get columnDailyPrice => 'Daily Price (DZD)';

  @override
  String get columnStatus => 'Status';

  @override
  String get columnActions => 'Actions';

  @override
  String plateNumber(String number) {
    return 'Plate: $number';
  }

  @override
  String carYear(int year) {
    return 'Year: $year';
  }

  @override
  String dailyPrice(String price, String currencySymbol) {
    return '$price $currencySymbol/day';
  }

  @override
  String get rentButton => 'Rent';

  @override
  String get returnButton => 'Return';

  @override
  String get editButton => 'Edit';

  @override
  String get editCarTooltip => 'Edit Car';

  @override
  String get archiveCarTooltip => 'Archive Car';

  @override
  String get restoreCarTooltip => 'Restore Car';

  @override
  String get deleteCarTooltip => 'Delete Car Permanently';

  @override
  String get carStatusAvailable => 'Available';

  @override
  String get carStatusRented => 'Rented';

  @override
  String get carStatusUnderMaintenance => 'Under Maintenance';

  @override
  String get carStatusArchived => 'Archived';

  @override
  String get confirmArchiveTitle => 'Confirm Archiving';

  @override
  String get archiveCarConfirmation =>
      'Are you sure you want to archive this car? It will be moved to the archive page.';

  @override
  String get carArchivedSuccess => 'Car archived successfully!';

  @override
  String get errorArchivingCar => 'Error archiving car';

  @override
  String get returnCarTitle => 'Return Car';

  @override
  String get returnCarConfirmation =>
      'Are you sure you want to return this car?';

  @override
  String carStatusUpdated(String status) {
    return 'Car status updated to $status!';
  }

  @override
  String get errorUpdatingCarStatus => 'Error updating car status';

  @override
  String get confirmDeleteTitle => 'Confirm Permanent Deletion';

  @override
  String get deleteCarConfirmation =>
      'Are you sure you want to permanently delete this car?';

  @override
  String get carDeletedSuccess => 'Car deleted permanently!';

  @override
  String get errorDeletingCar => 'Error deleting car';

  @override
  String get errorLoadingCars => 'Error loading cars';

  @override
  String get addCarPageTitle => 'Add New Car';

  @override
  String get carBrandLabel => 'Car Brand';

  @override
  String get carModelLabel => 'Car Model';

  @override
  String get manufacturingYearLabel => 'Manufacturing Year';

  @override
  String get plateNumberLabel => 'Plate Number';

  @override
  String get dailyRentalRateLabel => 'Daily Rental Rate';

  @override
  String get carStatusLabel => 'Car Status';

  @override
  String get saveButton => 'Save';

  @override
  String get errorAddCar => 'Error adding car';

  @override
  String get carAddedSuccess => 'Car added successfully!';

  @override
  String get carStatusPrompt => 'Select Car Status';

  @override
  String get carUpdateSuccess => 'Car updated successfully!';

  @override
  String get errorUpdateCar => 'Error updating car';

  @override
  String get editCarPageTitle => 'Edit Car Details';

  @override
  String get rentalsPageTitle => 'Active & Past Rentals';

  @override
  String get exportRentalsButton => 'Export Rentals to Excel';

  @override
  String get pickDateRangeTitle => 'Pick Date Range';

  @override
  String get noRentalsInDateRange => 'No rentals found in selected range';

  @override
  String get exportSuccess => 'Rentals exported successfully!';

  @override
  String get noRentalsFound => 'No rentals found yet!';

  @override
  String get addRentalHint => 'Start by adding a new car rental.';

  @override
  String get rentalIdHeader => 'ID';

  @override
  String get customerHeader => 'Customer';

  @override
  String get carBrandHeader => 'Car Brand';

  @override
  String get carModelHeader => 'Car Model';

  @override
  String get plateNumberHeader => 'Plate Number';

  @override
  String get rentDateHeader => 'Rent Date';

  @override
  String get returnDateHeader => 'Return Date';

  @override
  String totalPriceHeader(Object currencySymbol) {
    return 'Total Price ($currencySymbol)';
  }

  @override
  String get actionsHeader => 'Actions';

  @override
  String get editRentalTooltip => 'Edit Rental';

  @override
  String get deleteRentalTooltip => 'Delete Rental';

  @override
  String get errorLoadingRentals => 'Error loading rentals';

  @override
  String get rentalUpdatedSuccess => 'Rental updated successfully!';

  @override
  String errorRentalNotFound(int id) {
    return 'Error: Rental with ID $id not found for editing.';
  }

  @override
  String get errorEditNullRentalId =>
      'Error: Attempted to edit a rental with a null ID.';

  @override
  String get errorDeleteNullRentalId =>
      'Error: Attempted to delete a rental with a null ID.';

  @override
  String get confirmDeletionTitle => 'Confirm Deletion';

  @override
  String get deleteRentalConfirmation =>
      'Are you sure you want to delete this rental?';

  @override
  String get rentalDeletedSuccess => 'Rental deleted successfully!';

  @override
  String get errorDeletingRental => 'Error deleting rental';

  @override
  String get addRentalButton => 'Add New Rental';

  @override
  String get confirmBookingTitle => 'Confirm Rental Booking';

  @override
  String get confirmBookingMessage =>
      'Are you sure you want to book this rental?';

  @override
  String get customerNameLabel => 'Customer Name';

  @override
  String get customerPhoneLabel => 'Customer Phone';

  @override
  String get rentDateLabel => 'Rent Date';

  @override
  String get returnDateLabel => 'Return Date';

  @override
  String get totalPriceLabel => 'Total Price';

  @override
  String get errorBookingRental => 'Error booking rental';

  @override
  String get rentalBookedSuccess => 'Rental booked successfully!';

  @override
  String get selectCustomerMessage => 'Select Customer';

  @override
  String get noCustomerSelected => 'No customer selected';

  @override
  String get pickCustomerTitle => 'Pick a Customer';

  @override
  String get customerSearchHint => 'Search customers...';

  @override
  String get addNewCustomerButton => 'Add New Customer';

  @override
  String get addCustomerDialogTitle => 'Add New Customer';

  @override
  String get customerNameHint => 'Enter customer name';

  @override
  String get customerPhoneHint => 'Enter customer phone';

  @override
  String get customerAddressHint => 'Enter customer address (optional)';

  @override
  String get errorAddCustomer => 'Error adding customer';

  @override
  String get customerAddedSuccess => 'Customer added successfully!';

  @override
  String get selectCarMessage => 'Select Car';

  @override
  String get carSearchHint => 'Search cars...';

  @override
  String get selectCarTitle => 'Select a Car';

  @override
  String get noCarSelected => 'No car selected';

  @override
  String get archivePageTitle => 'Archived Items';

  @override
  String get archivedCarsTab => 'Archived Cars';

  @override
  String get archivedRentalsTab => 'Archived Rentals';

  @override
  String get noArchivedCarsFound => 'No archived cars found!';

  @override
  String get noArchivedRentalsFound => 'No archived rentals found!';

  @override
  String get archivedRentalsAppearHere =>
      'Rentals you archive will appear here.';

  @override
  String get restoreCarButton => 'Restore Car';

  @override
  String get deletePermanentlyButton => 'Delete Permanently';

  @override
  String get permanentDeleteCarConfirmation =>
      'Are you sure you want to PERMANENTLY delete this car? This action cannot be undone.';

  @override
  String get carRestoredSuccess => 'Car restored successfully!';

  @override
  String get errorRestoringCar => 'Error restoring car';

  @override
  String get carPermanentlyDeleted => 'Car permanently deleted!';

  @override
  String get errorDeletingCarPermanently => 'Error deleting car permanently';

  @override
  String get restoreRentalButton => 'Restore Rental';

  @override
  String get permanentDeleteRentalConfirmation =>
      'Are you sure you want to PERMANENTLY delete this rental? This action cannot be undone.';

  @override
  String get rentalRestoredSuccess => 'Rental restored successfully!';

  @override
  String get errorRestoringRental => 'Error restoring rental';

  @override
  String get rentalPermanentlyDeleted => 'Rental permanently deleted!';

  @override
  String get errorDeletingRentalPermanently =>
      'Error deleting rental permanently';

  @override
  String get loginEnterCredentials =>
      'Please enter both username and password.';

  @override
  String get loginUserNotFound => 'User not found.';

  @override
  String loginWelcome(String username) {
    return 'Welcome, $username!';
  }

  @override
  String get loginIncorrectPassword => 'Incorrect password.';

  @override
  String get loginTitle => 'Login to your account';

  @override
  String get loginUsernameLabel => 'Enter your username';

  @override
  String get loginPasswordLabel => 'Enter your password';

  @override
  String get loginButton => 'Login';

  @override
  String get archiveRestoreTitle => 'Restore';

  @override
  String get archiveConfirmRestore =>
      'Are you sure you want to restore this item?';

  @override
  String get archiveCarsTab => 'Cars';

  @override
  String get archiveRentalsTab => 'Rentals';

  @override
  String get archiveNoArchivedCars => 'No archived cars.';

  @override
  String get archiveRestoreCarTooltip => 'Restore Car';

  @override
  String get archiveNoArchivedRentals => 'No archived rentals.';

  @override
  String get archiveUnknownCustomer => 'Unknown Customer';

  @override
  String archiveRentalDetails(
    String brand,
    String model,
    String plateNumber,
    String rentDate,
    String returnDate,
  ) {
    return 'Car: $brand $model - Plate: $plateNumber\nRent: $rentDate → Return: $returnDate';
  }

  @override
  String get archiveRestoreRentalTooltip => 'Restore Rental';
}
