// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get errorLoadingCars => 'Error loading cars:';

  @override
  String get carDeletedSuccess => 'Car deleted successfully!';

  @override
  String get errorArchivingCar => 'Error archiving car:';

  @override
  String carStatusUpdated(String status) {
    return 'Car status updated to $status!';
  }

  @override
  String get errorUpdatingCarStatus => 'Error updating car status:';

  @override
  String get availableCarsTitle => 'Available Cars';

  @override
  String get addCarButton => 'Add Car';

  @override
  String get noCarsAvailable => 'No cars available';

  @override
  String get addFirstCarHint => 'Add your first car to get started';

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
  String get deleteCarTooltip => 'Delete Car';

  @override
  String get archiveCarTitle => 'Archive Car';

  @override
  String get archiveCarConfirmation =>
      'Are you sure you want to archive this car? It will be moved to the archive page.';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get returnCarTitle => 'Return Car';

  @override
  String get returnCarConfirmation =>
      'Are you sure you want to return this car?';

  @override
  String get carStatusAvailable => 'Available';

  @override
  String get carStatusRented => 'Rented';

  @override
  String get carStatusMaintenance => 'Maintenance';

  @override
  String get carStatusArchived => 'Archived';

  @override
  String get appTitle => 'Car Management System';

  @override
  String get closeButton => 'Close';

  @override
  String get welcome => 'Welcome';

  @override
  String get home => 'Home';

  @override
  String get availableCars => 'Available Cars';

  @override
  String get rentals => 'Rentals';

  @override
  String get archive => 'Archive';

  @override
  String get settings => 'Settings';

  @override
  String get signOut => 'Sign Out';

  @override
  String get confirmExit => 'Confirm Exit';

  @override
  String get areYouSureToClose =>
      'Are you sure you want to close the application?';

  @override
  String get pageNotFound => 'Page Not Found';

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
  String get currencySymbol => 'DZD';

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
  String get addFirstCarPrompt => 'Add your first car to get started';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get carArchivedSuccess => 'Car archived successfully!';

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
  String get rentalsPageTitle => 'Active & Past Rentals';

  @override
  String get noRentalsFound => 'No rentals found yet!';

  @override
  String get startAddingRentalPrompt => 'Start by adding a new car rental.';

  @override
  String get editRentalButton => 'Edit Rental';

  @override
  String get archiveRentalButton => 'Archive Rental';

  @override
  String get confirmArchivingRentalTitle => 'Confirm Archiving';

  @override
  String get archiveRentalConfirmation =>
      'Are you sure you want to archive this rental? Archived rentals can be restored later.';

  @override
  String get rentalArchivedSuccess => 'Rental archived successfully!';

  @override
  String get errorArchivingRental => 'Error archiving rental:';

  @override
  String get errorLoadingRentals => 'Error loading rentals:';

  @override
  String get confirmDeletionTitle => 'Confirm Deletion';

  @override
  String get deleteRentalConfirmation =>
      'Are you sure you want to delete this rental?';

  @override
  String get actionCannotBeUndone => 'This action cannot be undone.';

  @override
  String get deleteButton => 'Delete';

  @override
  String get rentalDeletedSuccess => 'Rental deleted successfully!';

  @override
  String get errorDeletingRental => 'Error deleting rental:';

  @override
  String get columnCustomer => 'Customer';

  @override
  String get columnCarBrand => 'Car Brand';

  @override
  String get columnCarModel => 'Car Model';

  @override
  String get columnRentDate => 'Rent Date';

  @override
  String get columnReturnDate => 'Return Date';

  @override
  String get columnTotalPrice => 'Total Price (DZD)';

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
  String get restoreCarButton => 'Restore Car';

  @override
  String get deletePermanentlyButton => 'Delete Permanently';

  @override
  String get confirmPermanentDeletionTitle => 'Confirm Permanent Deletion';

  @override
  String get permanentDeleteCarConfirmation =>
      'Are you sure you want to PERMANENTLY delete this car? This action cannot be undone.';

  @override
  String get carRestoredSuccess => 'Car restored successfully!';

  @override
  String get errorRestoringCar => 'Error restoring car:';

  @override
  String get carPermanentlyDeleted => 'Car permanently deleted!';

  @override
  String get errorDeletingCarPermanently => 'Error deleting car permanently:';

  @override
  String get restoreRentalButton => 'Restore Rental';

  @override
  String get permanentDeleteRentalConfirmation =>
      'Are you sure you want to PERMANENTLY delete this rental? This action cannot be undone.';

  @override
  String get rentalRestoredSuccess => 'Rental restored successfully!';

  @override
  String get errorRestoringRental => 'Error restoring rental:';

  @override
  String get rentalPermanentlyDeleted => 'Rental permanently deleted!';

  @override
  String get errorDeletingRentalPermanently =>
      'Error deleting rental permanently:';

  @override
  String get archivedRentalsAppearHere =>
      'Rentals you archive will appear here.';
}
