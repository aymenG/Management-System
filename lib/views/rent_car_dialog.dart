// lib/views/rent_car_dialog.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/models/rental.dart';
import 'package:management_system/controllers/database_helper.dart';

class RentCarDialog extends StatefulWidget {
  final Car car;

  const RentCarDialog({super.key, required this.car});

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

  Future<void> _rentCar() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedRentDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a rent date.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      if (_selectedReturnDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a return date.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      if (_selectedReturnDate!.isBefore(_selectedRentDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Return Date must be after Rent Date.'),
            backgroundColor: Colors.red,
          ),
        );
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
            const SnackBar(
              content: Text('Car rented successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error renting car: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rent ${widget.car.fullName}'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(labelText: 'Customer Name *'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter customer name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _rentDateController,
                decoration: const InputDecoration(
                  labelText: 'Rent Date *',
                  suffixIcon: Icon(Icons.calendar_today),
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
                    return 'Please select a rent date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _returnDateController,
                decoration: const InputDecoration(
                  labelText: 'Return Date *',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _pickDate(context, _returnDateController, (date) {
                  _selectedReturnDate = date;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a return date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Daily Price: DZD ${widget.car.dailyPrice.toStringAsFixed(2)}',
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
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _rentCar,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          child: const Text('Rent Car'),
        ),
      ],
    );
  }
}
