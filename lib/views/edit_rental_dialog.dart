// lib/widgets/edit_rental_dialog.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/models/rental.dart';

Future<bool?> showEditRentalDialog({
  required BuildContext context,
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load cars for editing: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return StatefulBuilder(
        builder: (context, setStateInDialog) {
          return AlertDialog(
            title: Text('Edit Rental ID: ${rentalData['id']}'),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: customerNameController,
                      decoration: const InputDecoration(
                        labelText: 'Customer Name *',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter customer name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    carsLoading
                        ? const CircularProgressIndicator()
                        : availableCars.isEmpty
                        ? const Text("No cars available. Add cars first.")
                        : DropdownButtonFormField<int>(
                            value: selectedCarId,
                            decoration: const InputDecoration(
                              labelText: 'Car *',
                            ),
                            items: availableCars.map((car) {
                              return DropdownMenuItem<int>(
                                value: car.id,
                                child: Text(
                                  '${car.brand} ${car.model} (${car.plateNumber})',
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
                                return 'Please select a car';
                              }
                              return null;
                            },
                          ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: rentDateController,
                      decoration: const InputDecoration(
                        labelText: 'Rent Date *',
                        suffixIcon: Icon(Icons.calendar_today),
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
                          return 'Please select a rent date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: returnDateController,
                      decoration: const InputDecoration(
                        labelText: 'Return Date *',
                        suffixIcon: Icon(Icons.calendar_today),
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
                          return 'Please select a return date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: totalPriceController,
                      decoration: const InputDecoration(
                        labelText: 'Total Price (DZD) *',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter total price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
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
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (selectedCarId == null) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a car.'),
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
                          const SnackBar(
                            content: Text('Rent Date is required.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      return;
                    }

                    if (returnDate == null) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Return Date is required.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      return;
                    }

                    if (returnDate.isBefore(rentDate)) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Return Date must be after Rent Date.',
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
                          const SnackBar(
                            content: Text('Rental updated successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      Navigator.of(dialogContext).pop(true);
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error updating rental: $e'),
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
                child: const Text('Save'),
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
