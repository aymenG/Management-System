// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get errorLoadingCars => 'Erreur lors du chargement des voitures :';

  @override
  String get carDeletedSuccess => 'Voiture supprimée avec succès !';

  @override
  String get errorArchivingCar => 'Erreur lors de l\'archivage de la voiture :';

  @override
  String carStatusUpdated(String status) {
    return 'Statut de la voiture mis à jour à $status !';
  }

  @override
  String get errorUpdatingCarStatus =>
      'Erreur lors de la mise à jour du statut de la voiture :';

  @override
  String get availableCarsTitle => 'Voitures Disponibles';

  @override
  String get addCarButton => 'Ajouter une Voiture';

  @override
  String get noCarsAvailable => 'Aucune voiture disponible';

  @override
  String get addFirstCarHint => 'Ajoutez votre première voiture pour commencer';

  @override
  String plateNumber(String number) {
    return 'Plaque: $number';
  }

  @override
  String carYear(int year) {
    return 'Année: $year';
  }

  @override
  String dailyPrice(String price, String currencySymbol) {
    return '$price $currencySymbol/jour';
  }

  @override
  String get rentButton => 'Louer';

  @override
  String get returnButton => 'Retourner';

  @override
  String get editButton => 'Modifier';

  @override
  String get deleteCarTooltip => 'Supprimer la Voiture';

  @override
  String get archiveCarTitle => 'Archiver la Voiture';

  @override
  String get archiveCarConfirmation =>
      'Êtes-vous sûr de vouloir archiver cette voiture ? Elle sera déplacée vers la page d\'archives.';

  @override
  String get confirmButton => 'Confirmer';

  @override
  String get returnCarTitle => 'Retourner la Voiture';

  @override
  String get returnCarConfirmation =>
      'Êtes-vous sûr de vouloir retourner cette voiture ?';

  @override
  String get carStatusAvailable => 'Disponible';

  @override
  String get carStatusRented => 'Louée';

  @override
  String get carStatusMaintenance => 'En Maintenance';

  @override
  String get carStatusArchived => 'Archivée';

  @override
  String get appTitle => 'Système de Gestion de Voitures';

  @override
  String get closeButton => 'Fermer';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get home => 'Accueil';

  @override
  String get availableCars => 'Voitures Disponibles';

  @override
  String get rentals => 'Locations';

  @override
  String get archive => 'Archives';

  @override
  String get settings => 'Paramètres';

  @override
  String get signOut => 'Déconnexion';

  @override
  String get confirmExit => 'Confirmer la Sortie';

  @override
  String get areYouSureToClose =>
      'Êtes-vous sûr de vouloir fermer l\'application ?';

  @override
  String get pageNotFound => 'Page non trouvée';

  @override
  String get dashboardTitle => 'Aperçu du Tableau de Bord';

  @override
  String get dailyIncome => 'Revenu Quotidien';

  @override
  String get monthlyIncome => 'Revenu Mensuel';

  @override
  String get dailyRentals => 'Locations Quotidiennes';

  @override
  String get monthlyRentals => 'Locations Mensuelles';

  @override
  String get currencySymbol => 'DZD';

  @override
  String get topRentedCars => 'Top 5 des Voitures Louées';

  @override
  String get noRentalsYet => 'Aucune location enregistrée pour l\'instant.';

  @override
  String get unknownCar => 'Voiture inconnue';

  @override
  String numberOfRentals(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString locations',
      one: '1 location',
      zero: 'Aucune location',
    );
    return '$_temp0';
  }

  @override
  String get addFirstCarPrompt =>
      'Ajoutez votre première voiture pour commencer';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get carArchivedSuccess => 'Voiture archivée avec succès !';

  @override
  String get columnId => 'ID';

  @override
  String get columnBrand => 'Marque';

  @override
  String get columnModel => 'Modèle';

  @override
  String get columnYear => 'Année';

  @override
  String get columnPlateNumber => 'Numéro de Plaque';

  @override
  String get columnDailyPrice => 'Prix Journalier (DZD)';

  @override
  String get columnStatus => 'Statut';

  @override
  String get columnActions => 'Actions';

  @override
  String get rentalsPageTitle => 'Locations Actives et Passées';

  @override
  String get noRentalsFound => 'Aucune location trouvée pour l\'instant !';

  @override
  String get startAddingRentalPrompt =>
      'Commencez par ajouter une nouvelle location de voiture.';

  @override
  String get editRentalButton => 'Modifier la Location';

  @override
  String get archiveRentalButton => 'Archiver la Location';

  @override
  String get confirmArchivingRentalTitle => 'Confirmer l\'Archivage';

  @override
  String get archiveRentalConfirmation =>
      'Êtes-vous sûr de vouloir archiver cette location ? Les locations archivées pourront être restaurées plus tard.';

  @override
  String get rentalArchivedSuccess => 'Location archivée avec succès !';

  @override
  String get errorArchivingRental =>
      'Erreur lors de l\'archivage de la location :';

  @override
  String get errorLoadingRentals => 'Erreur lors du chargement des locations :';

  @override
  String get confirmDeletionTitle => 'Confirmer la Suppression';

  @override
  String get deleteRentalConfirmation =>
      'Êtes-vous sûr de vouloir supprimer cette location ?';

  @override
  String get actionCannotBeUndone => 'Cette action ne peut pas être annulée.';

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get rentalDeletedSuccess => 'Location supprimée avec succès !';

  @override
  String get errorDeletingRental =>
      'Erreur lors de la suppression de la location :';

  @override
  String get columnCustomer => 'Client';

  @override
  String get columnCarBrand => 'Marque de Voiture';

  @override
  String get columnCarModel => 'Modèle de Voiture';

  @override
  String get columnRentDate => 'Date de Location';

  @override
  String get columnReturnDate => 'Date de Retour';

  @override
  String get columnTotalPrice => 'Prix Total (DZD)';

  @override
  String get archivePageTitle => 'Éléments Archivés';

  @override
  String get archivedCarsTab => 'Voitures Archivées';

  @override
  String get archivedRentalsTab => 'Locations Archivées';

  @override
  String get noArchivedCarsFound => 'Aucune voiture archivée trouvée !';

  @override
  String get noArchivedRentalsFound => 'Aucune location archivée trouvée !';

  @override
  String get restoreCarButton => 'Restaurer la Voiture';

  @override
  String get deletePermanentlyButton => 'Supprimer Définitivement';

  @override
  String get confirmPermanentDeletionTitle =>
      'Confirmer la Suppression Définitive';

  @override
  String get permanentDeleteCarConfirmation =>
      'Êtes-vous sûr de vouloir SUPPRIMER DÉFINITIVEMENT cette voiture ? Cette action ne peut pas être annulée.';

  @override
  String get carRestoredSuccess => 'Voiture restaurée avec succès !';

  @override
  String get errorRestoringCar =>
      'Erreur lors de la restauration de la voiture :';

  @override
  String get carPermanentlyDeleted => 'Voiture supprimée définitivement !';

  @override
  String get errorDeletingCarPermanently =>
      'Erreur lors de la suppression définitive de la voiture :';

  @override
  String get restoreRentalButton => 'Restaurer la Location';

  @override
  String get permanentDeleteRentalConfirmation =>
      'Êtes-vous sûr de vouloir SUPPRIMER DÉFINITIVEMENT cette location ? Cette action ne peut pas être annulée.';

  @override
  String get rentalRestoredSuccess => 'Location restaurée avec succès !';

  @override
  String get errorRestoringRental =>
      'Erreur lors de la restauration de la location :';

  @override
  String get rentalPermanentlyDeleted => 'Location supprimée définitivement !';

  @override
  String get errorDeletingRentalPermanently =>
      'Erreur lors de la suppression définitive de la location :';

  @override
  String get archivedRentalsAppearHere =>
      'Les locations que vous archivez apparaîtront ici.';
}
