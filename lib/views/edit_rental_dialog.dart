// lib/widgets/edit_rental_dialog.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/models/car_brand.dart';
import 'package:management_system/models/rental.dart';
import 'package:management_system/l10n/app_localizations.dart'; // Import AppLocalizations

Future<bool?> showEditRentalDialog({
  required BuildContext
  context, // Use this context for initializations outside builder
  required DatabaseHelper dbHelper,
  required Map<String, dynamic> rentalData,
}) async {
  final _formKey = GlobalKey<FormState>();

  TextEditingController customerNameController = TextEditingController(
    text: rentalData['customer_name']?.toString() ?? '',
  );
  TextEditingController rentDateController = TextEditingController(
    text: _formatDateToYYYYMMDD(rentalData['rent_date']),
  );
  TextEditingController returnDateController = TextEditingController(
    text: _formatDateToYYYYMMDD(rentalData['return_date']),
  );
  TextEditingController totalPriceController = TextEditingController(
    text: rentalData['total_price']?.toString() ?? '',
  );

  int? selectedCarId = rentalData['car_id'] as int?;
  List<Car> availableCars = [];
  bool carsLoading = true;

  try {
    availableCars = await dbHelper.getAllCars();
    carsLoading = false;
    if (selectedCarId == null ||
        !availableCars.any((car) => car.id == selectedCarId)) {
      selectedCarId = availableCars.isNotEmpty ? availableCars.first.id : null;
    }
  } catch (e) {
    print("Error fetching cars for dialog: $e");
    carsLoading = false;
    if (context.mounted) {
      final localizations = AppLocalizations.of(
        context,
      )!; // Get localizations for the snakbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.editRentalDialogErrorFetchingCars(e.toString()),
          ), // Localized Error
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      final AppLocalizations localizations = AppLocalizations.of(
        dialogContext,
      )!; // Get localizations inside builder

      return StatefulBuilder(
        builder: (context, setStateInDialog) {
          return AlertDialog(
            title: Text(
              localizations.editRentalDialogTitle(rentalData['id']),
            ), // Localized Title with ID
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: customerNameController,
                      decoration: InputDecoration(
                        labelText: localizations
                            .editRentalDialogCustomerNameLabel, // Localized Label
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations
                              .editRentalDialogCustomerNameValidation; // Localized Validation
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    carsLoading
                        ? const CircularProgressIndicator()
                        : availableCars.isEmpty
                        ? Text(
                            localizations.editRentalDialogNoCarsAvailable,
                          ) // Localized Text
                        : DropdownButtonFormField<int>(
                            value: selectedCarId,
                            decoration: InputDecoration(
                              labelText: localizations
                                  .editRentalDialogCarLabel, // Localized Label
                            ),
                            items: availableCars.map((car) {
                              return DropdownMenuItem<int>(
                                value: car.id,
                                child: Text(
                                  // Corrected line: 'car.brand' is likely a String,
                                  // so no '.displayName' is needed.
                                  '${car.brand.displayName} ${car.model} (${car.plateNumber})',
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setStateInDialog(() {
                                selectedCarId = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return localizations
                                    .editRentalDialogPleaseSelectCarValidation; // Localized Validation
                              }
                              return null;
                            },
                          ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: rentDateController,
                      decoration: InputDecoration(
                        labelText: localizations
                            .editRentalDialogRentDateLabel, // Localized Label
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? initialDate =
                            DateTime.tryParse(rentDateController.text) ??
                            DateTime.now();
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: initialDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setStateInDialog(() {
                            rentDateController.text = DateFormat(
                              'yyyy-MM-dd',
                            ).format(pickedDate);
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations
                              .editRentalDialogRentDateValidation; // Localized Validation
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: returnDateController,
                      decoration: InputDecoration(
                        labelText: localizations
                            .editRentalDialogReturnDateLabel, // Localized Label
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? initialDate =
                            DateTime.tryParse(returnDateController.text) ??
                            DateTime.now();
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: initialDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setStateInDialog(() {
                            returnDateController.text = DateFormat(
                              'yyyy-MM-dd',
                            ).format(pickedDate);
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations
                              .editRentalDialogReturnDateValidation; // Localized Validation
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: totalPriceController,
                      decoration: InputDecoration(
                        labelText: localizations
                            .editRentalDialogTotalPriceLabel, // Localized Label
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations
                              .editRentalDialogTotalPriceValidation; // Localized Validation
                        }
                        if (double.tryParse(value) == null) {
                          return localizations
                              .editRentalDialogInvalidNumberValidation; // Localized Validation
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(
                  localizations.cancelButton,
                ), // Re-used existing label
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (selectedCarId == null) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              localizations.editRentalDialogSelectCarSnackBar,
                            ), // Localized SnackBar
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                      return;
                    }

                    final DateTime? rentDate = DateTime.tryParse(
                      rentDateController.text,
                    );
                    final DateTime? returnDate = DateTime.tryParse(
                      returnDateController.text,
                    );

                    if (rentDate == null) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              localizations
                                  .editRentalDialogRentDateRequiredSnackBar,
                            ), // Localized SnackBar
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      return;
                    }

                    if (returnDate == null) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              localizations
                                  .editRentalDialogReturnDateRequiredSnackBar,
                            ), // Localized SnackBar
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      return;
                    }

                    if (returnDate.isBefore(rentDate)) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              localizations
                                  .editRentalDialogReturnDateBeforeRentDateSnackBar, // Localized SnackBar
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      return;
                    }

                    final updatedRental = Rental(
                      id: rentalData['id'] as int?,
                      customerName: customerNameController.text.trim(),
                      carId: selectedCarId!,
                      rentDate: rentDateController.text,
                      returnDate: returnDateController.text,
                      totalPrice: double.parse(totalPriceController.text),
                    );

                    try {
                      await dbHelper.updateRental(updatedRental);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              localizations
                                  .editRentalDialogUpdateSuccessSnackBar,
                            ), // Localized SnackBar
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      Navigator.of(dialogContext).pop(true);
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              localizations.editRentalDialogUpdateErrorSnackBar(
                                e.toString(),
                              ),
                            ), // Localized Error
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      Navigator.of(dialogContext).pop(false);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: Text(localizations.saveButton), // Re-used existing label
              ),
            ],
          );
        },
      );
    },
  );
}

// Helper to format a string to yyyy-MM-dd or return empty string
String _formatDateToYYYYMMDD(String? dateString) {
  if (dateString == null || dateString.isEmpty) return '';
  try {
    final dateTime = DateTime.parse(dateString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  } catch (e) {
    return '';
  }
}
