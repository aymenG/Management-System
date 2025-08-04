// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Système de Gestion de Location de Voitures';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get home => 'Accueil';

  @override
  String get carManagement => 'Gestion des Voitures';

  @override
  String get rentals => 'Locations';

  @override
  String get archive => 'Archive';

  @override
  String get settings => 'Paramètres';

  @override
  String get signOut => 'Déconnexion';

  @override
  String get closeButton => 'Fermer';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get confirmButton => 'Confirmer';

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get confirmExit => 'Confirmer la Sortie';

  @override
  String get areYouSureToClose =>
      'Êtes-vous sûr de vouloir fermer l\'application ?';

  @override
  String get pageNotFound => 'Page Non Trouvée';

  @override
  String get actionCannotBeUndone =>
      'Cette action est irréversible et déplacera la location vers les archives.';

  @override
  String get currencySymbol => 'DZD';

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
  String get topRentedCars => 'Top 5 des Voitures Louées';

  @override
  String get noRentalsYet => 'Aucune location enregistrée pour l\'instant.';

  @override
  String get unknownCar => 'Voiture Inconnue';

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
  String get availableCarsTitle => 'Voitures Disponibles';

  @override
  String get addCarButton => 'Ajouter une Voiture';

  @override
  String get addCarTooltip => 'Ajouter une Nouvelle Voiture';

  @override
  String get noCarsAvailable => 'Aucune voiture disponible';

  @override
  String get addFirstCarPrompt =>
      'Ajoutez votre première voiture pour commencer';

  @override
  String get totalCars => 'Total Voitures';

  @override
  String get rentedCars => 'Voitures Louées';

  @override
  String get archivedCars => 'Voitures Archivées';

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
  String plateNumber(String number) {
    return 'Plaque : $number';
  }

  @override
  String carYear(int year) {
    return 'Année : $year';
  }

  @override
  String dailyPrice(String price, String currencySymbol) {
    return '$price $currencySymbol/jour';
  }

  @override
  String get rentButton => 'Louer la voiture';

  @override
  String get returnButton => 'Retourner';

  @override
  String get editButton => 'Modifier';

  @override
  String get editCarTooltip => 'Modifier la Voiture';

  @override
  String get archiveCarTooltip => 'Archiver la Voiture';

  @override
  String get restoreCarTooltip => 'Restaurer la Voiture';

  @override
  String get deleteCarTooltip => 'Supprimer la Voiture Définitivement';

  @override
  String get carStatusAvailable => 'Disponible';

  @override
  String get carStatusRented => 'Louée';

  @override
  String get carStatusUnderMaintenance => 'En Maintenance';

  @override
  String get carStatusArchived => 'Archivée';

  @override
  String get confirmArchiveTitle => 'Confirmer l\'Archivage';

  @override
  String get archiveCarConfirmation =>
      'Êtes-vous sûr de vouloir archiver cette voiture ? Elle sera déplacée vers la page d\'archive.';

  @override
  String get carArchivedSuccess => 'Voiture archivée avec succès !';

  @override
  String get errorArchivingCar => 'Erreur lors de l\'archivage de la voiture';

  @override
  String get returnCarTitle => 'Retourner la Voiture';

  @override
  String get returnCarConfirmation =>
      'Êtes-vous sûr de vouloir retourner cette voiture ?';

  @override
  String carStatusUpdated(String status) {
    return 'Statut de la voiture mis à jour vers $status !';
  }

  @override
  String get errorUpdatingCarStatus =>
      'Erreur lors de la mise à jour du statut de la voiture';

  @override
  String get confirmDeleteTitle => 'Confirmer la Suppression Permanente';

  @override
  String get deleteCarConfirmation =>
      'Êtes-vous sûr de vouloir supprimer définitivement cette voiture ?';

  @override
  String get carDeletedSuccess => 'Voiture supprimée définitivement !';

  @override
  String get errorDeletingCar => 'Erreur lors de la suppression de la voiture';

  @override
  String get errorLoadingCars => 'Erreur lors du chargement des voitures';

  @override
  String get addCarPageTitle => 'Ajouter une Nouvelle Voiture';

  @override
  String get carBrandLabel => 'Marque de la Voiture';

  @override
  String get carModelLabel => 'Modèle de la Voiture';

  @override
  String get manufacturingYearLabel => 'Année de Fabrication';

  @override
  String get plateNumberLabel => 'Numéro de Plaque';

  @override
  String get dailyRentalRateLabel => 'Tarif de Location Journalier';

  @override
  String get carStatusLabel => 'Statut de la Voiture';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get errorAddCar => 'Erreur lors de l\'ajout de la voiture';

  @override
  String get carAddedSuccess => 'Voiture ajoutée avec succès !';

  @override
  String get carStatusPrompt => 'Sélectionnez le statut de la voiture';

  @override
  String get carUpdateSuccess => 'Voiture mise à jour avec succès !';

  @override
  String get errorUpdateCar => 'Erreur lors de la mise à jour de la voiture';

  @override
  String get editCarPageTitle => 'Modifier les Détails de la Voiture';

  @override
  String get rentalsPageTitle => 'Locations Actives & Passées';

  @override
  String get exportRentalsButton => 'Exporter les Locations vers Excel';

  @override
  String get pickDateRangeTitle => 'Sélectionner la Plage de Dates';

  @override
  String get noRentalsInDateRange =>
      'Aucune location trouvée dans la plage de dates sélectionnée.';

  @override
  String get exportSuccess => 'Locations exportées avec succès !';

  @override
  String get noRentalsFound => 'Aucune location trouvée pour l\'instant !';

  @override
  String get addRentalHint =>
      'Commencez par ajouter une nouvelle location de voiture.';

  @override
  String get rentalIdHeader => 'ID';

  @override
  String get customerHeader => 'Client';

  @override
  String get carBrandHeader => 'Marque';

  @override
  String get carModelHeader => 'Modèle';

  @override
  String get plateNumberHeader => 'Numéro de Plaque';

  @override
  String get rentDateHeader => 'Date de Location';

  @override
  String get returnDateHeader => 'Date de Retour';

  @override
  String totalPriceHeader(Object currencySymbol) {
    return 'Prix Total ($currencySymbol)';
  }

  @override
  String get actionsHeader => 'Actions';

  @override
  String get editRentalTooltip => 'Modifier la Location';

  @override
  String get deleteRentalTooltip => 'Supprimer la Location';

  @override
  String get errorLoadingRentals => 'Erreur lors du chargement des locations';

  @override
  String get rentalUpdatedSuccess => 'Location mise à jour avec succès !';

  @override
  String errorRentalNotFound(int id) {
    return 'Erreur : Location avec l\'ID $id introuvable pour la modification.';
  }

  @override
  String get errorEditNullRentalId =>
      'Erreur : Tentative de modification d\'une location avec un ID nul.';

  @override
  String get errorDeleteNullRentalId =>
      'Erreur : Tentative de suppression d\'une location avec un ID nul.';

  @override
  String get confirmDeletionTitle => 'Confirmer la Suppression';

  @override
  String get deleteRentalConfirmation =>
      'Êtes-vous sûr de vouloir supprimer cette location ?';

  @override
  String get rentalDeletedSuccess => 'Location supprimée avec succès !';

  @override
  String get errorDeletingRental =>
      'Erreur lors de la suppression de la location';

  @override
  String get addRentalButton => 'Ajouter une Nouvelle Location';

  @override
  String get confirmBookingTitle => 'Confirmer la Réservation de Location';

  @override
  String get confirmBookingMessage =>
      'Êtes-vous sûr de vouloir réserver cette location ?';

  @override
  String get customerNameLabel => 'Nom du Client';

  @override
  String get customerPhoneLabel => 'Téléphone du Client';

  @override
  String get rentDateLabel => 'Date de Location';

  @override
  String get returnDateLabel => 'Date de Retour';

  @override
  String get totalPriceLabel => 'Prix Total';

  @override
  String get errorBookingRental =>
      'Erreur lors de la réservation de la location';

  @override
  String get rentalBookedSuccess => 'Location réservée avec succès !';

  @override
  String get selectCustomerMessage => 'Sélectionner un Client';

  @override
  String get noCustomerSelected => 'Aucun client sélectionné';

  @override
  String get pickCustomerTitle => 'Sélectionner un Client';

  @override
  String get customerSearchHint => 'Rechercher des clients...';

  @override
  String get addNewCustomerButton => 'Ajouter un Nouveau Client';

  @override
  String get addCustomerDialogTitle => 'Ajouter un Nouveau Client';

  @override
  String get customerNameHint => 'Entrez le nom du client';

  @override
  String get customerPhoneHint => 'Entrez le téléphone du client';

  @override
  String get customerAddressHint => 'Entrez l\'adresse du client (facultatif)';

  @override
  String get errorAddCustomer => 'Erreur lors de l\'ajout du client';

  @override
  String get customerAddedSuccess => 'Client ajouté avec succès !';

  @override
  String get selectCarMessage => 'Sélectionner une Voiture';

  @override
  String get carSearchHint => 'Rechercher des voitures...';

  @override
  String get selectCarTitle => 'Sélectionner une Voiture';

  @override
  String get noCarSelected => 'Aucune voiture sélectionnée';

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
  String get archivedRentalsAppearHere =>
      'Les locations que vous archivez apparaîtront ici.';

  @override
  String get restoreCarButton => 'Restaurer la Voiture';

  @override
  String get deletePermanentlyButton => 'Supprimer Définitivement';

  @override
  String get permanentDeleteCarConfirmation =>
      'Êtes-vous sûr de vouloir supprimer DÉFINITIVEMENT cette voiture ? Cette action est irréversible.';

  @override
  String get carRestoredSuccess => 'Voiture restaurée avec succès !';

  @override
  String get errorRestoringCar =>
      'Erreur lors de la restauration de la voiture';

  @override
  String get carPermanentlyDeleted => 'Voiture supprimée définitivement !';

  @override
  String get errorDeletingCarPermanently =>
      'Erreur lors de la suppression définitive de la voiture';

  @override
  String get restoreRentalButton => 'Restaurer la Location';

  @override
  String get permanentDeleteRentalConfirmation =>
      'Êtes-vous sûr de vouloir supprimer DÉFINITIVEMENT cette location ? Cette action est irréversible.';

  @override
  String get rentalRestoredSuccess => 'Location restaurée avec succès !';

  @override
  String get errorRestoringRental =>
      'Erreur lors de la restauration de la location';

  @override
  String get rentalPermanentlyDeleted => 'Location supprimée définitivement !';

  @override
  String get errorDeletingRentalPermanently =>
      'Erreur lors de la suppression définitive de la location';

  @override
  String get loginEnterCredentials =>
      'Veuillez entrer le nom d\'utilisateur et le mot de passe.';

  @override
  String get loginUserNotFound => 'Utilisateur introuvable.';

  @override
  String loginWelcome(String username) {
    return 'Bienvenue, $username !';
  }

  @override
  String get loginIncorrectPassword => 'Mot de passe incorrect.';

  @override
  String get loginTitle => 'Connectez-vous à votre compte';

  @override
  String get loginUsernameLabel => 'Entrez votre nom d\'utilisateur';

  @override
  String get loginPasswordLabel => 'Entrez votre mot de passe';

  @override
  String get loginButton => 'Connexion';

  @override
  String get archiveRestoreTitle => 'Restaurer';

  @override
  String get archiveConfirmRestore =>
      'Êtes-vous sûr de vouloir restaurer cet élément ?';

  @override
  String get archiveCarsTab => 'Voitures';

  @override
  String get archiveRentalsTab => 'Locations';

  @override
  String get archiveNoArchivedCars => 'Aucune voiture archivée.';

  @override
  String get archiveRestoreCarTooltip => 'Restaurer la Voiture';

  @override
  String get archiveNoArchivedRentals => 'Aucune location archivée.';

  @override
  String get archiveUnknownCustomer => 'Client Inconnu';

  @override
  String archiveRentalDetails(
    String brand,
    String model,
    String plateNumber,
    String rentDate,
    String returnDate,
  ) {
    return 'Voiture : $brand $model - Plaque : $plateNumber\nLocation : $rentDate → Retour : $returnDate';
  }

  @override
  String get archiveRestoreRentalTooltip => 'Restaurer la Location';

  @override
  String get settingsPageTitle => 'Paramètres';

  @override
  String get settingsAdminDefaultUsername => 'Admin';

  @override
  String get settingsAdminRole => 'Rôle : Administrateur Système';

  @override
  String get settingsUpdateCredentialsTitle =>
      'Mettre à Jour les Informations d\'Identification';

  @override
  String get settingsUsernameLabel => 'Nom d\'utilisateur';

  @override
  String get settingsCurrentPasswordLabel => 'Mot de passe actuel';

  @override
  String get settingsNewPasswordLabel => 'Nouveau mot de passe (facultatif)';

  @override
  String get settingsSaveChangesButton => 'Enregistrer les modifications';

  @override
  String get settingsFillRequiredFields =>
      'Veuillez remplir les champs obligatoires.';

  @override
  String get settingsAdminNotFound => 'Administrateur introuvable.';

  @override
  String get settingsCurrentPasswordIncorrect =>
      'Le mot de passe actuel est incorrect.';

  @override
  String get settingsCredentialsUpdatedSuccess =>
      'Informations d\'identification mises à jour avec succès !';

  @override
  String get carFormEditDialogTitle => 'Modifier la Voiture';

  @override
  String get carFormAddDialogTitle => 'Ajouter une Voiture';

  @override
  String get carFormBrandDropdownLabel => 'Marque';

  @override
  String get carFormSelectBrandValidationError =>
      'Veuillez sélectionner une marque';

  @override
  String get carFormModelTextFieldLabel => 'Modèle';

  @override
  String get carFormEnterModelValidationError => 'Entrez un modèle';

  @override
  String get carFormYearTextFieldLabel => 'Année';

  @override
  String get carFormEnterYearValidationError => 'Entrez l\'année';

  @override
  String get carFormEnterValidYearValidationError =>
      'Entrez une année valide (ex: 2023)';

  @override
  String get carFormPlateNumberTextFieldLabel => 'Numéro de Plaque';

  @override
  String get carFormEnterPlateNumberValidationError =>
      'Entrez le numéro de plaque';

  @override
  String get carFormEnterDailyPriceValidationError => 'Entrez le prix';

  @override
  String get carFormEnterValidDailyPriceValidationError =>
      'Entrez un prix valide (supérieur à 0)';

  @override
  String get carFormStatusDropdownLabel => 'Statut';

  @override
  String get carFormPickImageButtonLabel => 'Choisir une Image';

  @override
  String get carFormChangeImageButtonLabel => 'Changer l\'Image';

  @override
  String editRentalDialogTitle(int id) {
    return 'Modifier la location ID : $id';
  }

  @override
  String editRentalDialogErrorFetchingCars(String error) {
    return 'Échec du chargement des voitures pour la modification : $error';
  }

  @override
  String get editRentalDialogCustomerNameLabel => 'Nom du client *';

  @override
  String get editRentalDialogCustomerNameValidation =>
      'Veuillez entrer le nom du client';

  @override
  String get editRentalDialogCarLabel => 'Voiture *';

  @override
  String get editRentalDialogNoCarsAvailable =>
      'Aucune voiture disponible. Ajoutez des voitures d\'abord.';

  @override
  String get editRentalDialogPleaseSelectCarValidation =>
      'Veuillez sélectionner une voiture';

  @override
  String get editRentalDialogRentDateLabel => 'Date de location *';

  @override
  String get editRentalDialogReturnDateLabel => 'Date de retour *';

  @override
  String get editRentalDialogRentDateValidation =>
      'Veuillez sélectionner une date de location';

  @override
  String get editRentalDialogReturnDateValidation =>
      'Veuillez sélectionner une date de retour';

  @override
  String get editRentalDialogTotalPriceLabel => 'Prix Total (DZD) *';

  @override
  String get editRentalDialogTotalPriceValidation =>
      'Veuillez entrer le prix total';

  @override
  String get editRentalDialogInvalidNumberValidation =>
      'Veuillez entrer un nombre valide';

  @override
  String get editRentalDialogSelectCarSnackBar =>
      'Veuillez sélectionner une voiture.';

  @override
  String get editRentalDialogRentDateRequiredSnackBar =>
      'La date de location est requise.';

  @override
  String get editRentalDialogReturnDateRequiredSnackBar =>
      'La date de retour est requise.';

  @override
  String get editRentalDialogReturnDateBeforeRentDateSnackBar =>
      'La date de retour doit être après la date de location.';

  @override
  String get editRentalDialogUpdateSuccessSnackBar =>
      'Location mise à jour avec succès !';

  @override
  String editRentalDialogUpdateErrorSnackBar(String error) {
    return 'Erreur lors de la mise à jour de la location : $error';
  }

  @override
  String rentCarDialogTitle(String carName) {
    return 'Louer $carName';
  }

  @override
  String get rentCarDialogCustomerNameLabel => 'Nom du client *';

  @override
  String get rentCarDialogCustomerNameValidation =>
      'Veuillez entrer le nom du client';

  @override
  String get rentCarDialogRentDateLabel => 'Date de location *';

  @override
  String get rentCarDialogRentDateValidation =>
      'Veuillez sélectionner une date de location';

  @override
  String get rentCarDialogReturnDateLabel => 'Date de retour *';

  @override
  String get rentCarDialogReturnDateValidation =>
      'Veuillez sélectionner une date de retour';

  @override
  String rentCarDialogDailyPriceLabel(String currencyCode, double price) {
    final intl.NumberFormat priceNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String priceString = priceNumberFormat.format(price);

    return 'Prix journalier : $currencyCode $priceString';
  }

  @override
  String get rentCarDialogSelectDatesSnackBar =>
      'Veuillez sélectionner les dates de location et de retour.';

  @override
  String get rentCarDialogReturnDateBeforeRentDateSnackBar =>
      'La date de retour ne peut pas être antérieure à la date de location.';

  @override
  String get rentCarDialogRentSuccessSnackBar => 'Voiture louée avec succès !';

  @override
  String rentCarDialogRentErrorSnackBar(String error) {
    return 'Erreur lors de la location de la voiture : $error';
  }
}
