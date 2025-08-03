// lib/views/rent_car_dialog.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/models/rental.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:management_system/l10n/app_localizations.dart'; // Import AppLocalizations

class RentCarDialog extends StatefulWidget {
  final Car car;
  final VoidCallback onRentalConfirmed; // Add this callback

  const RentCarDialog({
    super.key,
    required this.car,
    required this.onRentalConfirmed,
  }); // Update constructor

  @override
  State<RentCarDialog> createState() => _RentCarDialogState();
}

class _RentCarDialogState extends State<RentCarDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _rentDateController = TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();

  DateTime? _selectedRentDate;
  DateTime? _selectedReturnDate;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _selectedRentDate = DateTime.now();
    _rentDateController.text = DateFormat(
      'yyyy-MM-dd',
    ).format(_selectedRentDate!);
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _rentDateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController controller,
    Function(DateTime) onDateSelected,
  ) async {
    DateTime initialDate = DateTime.tryParse(controller.text) ?? DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
        onDateSelected(picked);
      });
    }
  }

  bool isReturnDateValid(DateTime rentDate, DateTime returnDate) {
    final rent = DateTime(rentDate.year, rentDate.month, rentDate.day);
    final ret = DateTime(returnDate.year, returnDate.month, returnDate.day);
    return !ret.isBefore(rent);
  }

  Future<void> _rentCar() async {
    final localizations = AppLocalizations.of(context)!;

    if (_formKey.currentState!.validate()) {
      if (_selectedRentDate == null || _selectedReturnDate == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localizations.rentCarDialogSelectDatesSnackBar),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
      if (!isReturnDateValid(_selectedRentDate!, _selectedReturnDate!)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                localizations.rentCarDialogReturnDateBeforeRentDateSnackBar,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      final duration = _selectedReturnDate!.difference(_selectedRentDate!);
      final totalPrice = widget.car.dailyPrice * (duration.inDays + 1);

      final rental = Rental(
        customerName: _customerNameController.text.trim(),
        carId: widget.car.id!,
        rentDate: DateFormat('yyyy-MM-dd').format(_selectedRentDate!),
        returnDate: DateFormat('yyyy-MM-dd').format(_selectedReturnDate!),
        totalPrice: totalPrice,
      );

      try {
        await _dbHelper.insertRental(rental);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localizations.rentCarDialogRentSuccessSnackBar),
              backgroundColor: Colors.green,
            ),
          );
          widget.onRentalConfirmed();
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                localizations.rentCarDialogRentErrorSnackBar(e.toString()),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(localizations.rentCarDialogTitle(widget.car.fullName)),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _customerNameController,
                decoration: InputDecoration(
                  labelText: localizations.rentCarDialogCustomerNameLabel,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.rentCarDialogCustomerNameValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _rentDateController,
                decoration: InputDecoration(
                  labelText: localizations.rentCarDialogRentDateLabel,
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _pickDate(context, _rentDateController, (date) {
                  _selectedRentDate = date;
                  if (_selectedReturnDate != null &&
                      _selectedReturnDate!.isBefore(_selectedRentDate!)) {
                    setState(() {
                      _selectedReturnDate = null;
                      _returnDateController.text = '';
                    });
                  }
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.rentCarDialogRentDateValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _returnDateController,
                decoration: InputDecoration(
                  labelText: localizations.rentCarDialogReturnDateLabel,
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _pickDate(context, _returnDateController, (date) {
                  _selectedReturnDate = date;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.rentCarDialogReturnDateValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                localizations.rentCarDialogDailyPriceLabel(
                  'DZD',
                  widget.car.dailyPrice,
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(localizations.cancelButton),
        ),
        ElevatedButton(
          onPressed: _rentCar,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          child: Text(localizations.rentButton),
        ),
      ],
    );
  }
}
