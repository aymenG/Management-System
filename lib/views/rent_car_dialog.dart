import 'package:flutter/material.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/models/car_brand.dart';

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

  @override
  void dispose() {
    _customerNameController.dispose();
    _rentDateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }

  void _confirmRental() {
    if (_customerNameController.text.isEmpty ||
        _rentDateController.text.isEmpty ||
        _returnDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // In the future, save to DB here!
    print("Renting ${widget.car.brand.displayName} ${widget.car.model} "
        "(${widget.car.plateNumber}) "
        "to ${_customerNameController.text}, "
        "from ${_rentDateController.text} to ${_returnDateController.text}");

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Rent ${widget.car.brand.displayName} ${widget.car.model}",
      ),
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
              decoration: const InputDecoration(
                labelText: 'Rent Date',
                hintText: 'YYYY-MM-DD',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _returnDateController,
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
