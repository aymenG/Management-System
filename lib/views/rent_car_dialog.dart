import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:management_system/models/car_brand.dart';
import 'package:management_system/models/rental.dart';
import 'package:management_system/models/car.dart';

class RentCarDialog extends StatefulWidget {
  final Car car;

  const RentCarDialog({super.key, required this.car});

  @override
  State<RentCarDialog> createState() => _RentCarDialogState();
}

class _RentCarDialogState extends State<RentCarDialog> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _rentDateController = TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();

  DateTime? _selectedRentDate;
  DateTime? _selectedReturnDate;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void dispose() {
    _customerNameController.dispose();
    _rentDateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required TextEditingController controller,
    required Function(DateTime) onDatePicked,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      onDatePicked(picked);
      controller.text = picked.toIso8601String().split('T').first;
    }
  }

  Future<void> _confirmRental() async {
    if (_customerNameController.text.isEmpty ||
        _rentDateController.text.isEmpty ||
        _returnDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Assuming this code is in an "Add Rental" context
    final rental = Rental(
      customerName: _customerNameController.text.trim(),
      carId: widget.car.id!,
      rentDate: DateFormat(
        'yyyy-MM-dd',
      ).format(_selectedRentDate!), // <--- FIX HERE
      returnDate:
          _selectedReturnDate !=
              null // <--- FIX HERE for nullability
          ? DateFormat('yyyy-MM-dd').format(_selectedReturnDate!)
          : null,
      totalPrice: 0.0, // Assuming you want 0.0 as initial non-nullable price
    );
    try {
      await _dbHelper.insertRental(rental);
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Car rented successfully to ${_customerNameController.text}',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving rental: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Rent ${widget.car.brand.displayName} ${widget.car.model}"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Car Plate Number',
                hintText: widget.car.plateNumber,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _customerNameController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _rentDateController,
              readOnly: true,
              onTap: () => _pickDate(
                controller: _rentDateController,
                onDatePicked: (date) => _selectedRentDate = date,
              ),
              decoration: const InputDecoration(
                labelText: 'Rent Date',
                hintText: 'YYYY-MM-DD',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _returnDateController,
              readOnly: true,
              onTap: () => _pickDate(
                controller: _returnDateController,
                onDatePicked: (date) => _selectedReturnDate = date,
              ),
              decoration: const InputDecoration(
                labelText: 'Return Date',
                hintText: 'YYYY-MM-DD',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _confirmRental,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirm Rental'),
        ),
      ],
    );
  }
}
