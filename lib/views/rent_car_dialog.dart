import 'package:flutter/material.dart';
import 'package:management_system/models/car.dart';

class RentCarDialog extends StatefulWidget {
  final Car car;

  const RentCarDialog({super.key, required this.car});

  @override
  State<RentCarDialog> createState() => _RentCarDialogState();
}

class _RentCarDialogState extends State<RentCarDialog> {
  final _customerController = TextEditingController();
  final _rentDateController = TextEditingController();
  final _returnDateController = TextEditingController();

  @override
  void dispose() {
    _customerController.dispose();
    _rentDateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rent ${widget.car.fullName}'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Car',
                hintText: widget.car.fullName,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Plate Number',
                hintText: widget.car.plateNumber,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _customerController,
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
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Save rental to DB
            print(
              'Renting ${widget.car.fullName} (${widget.car.plateNumber}) to ${_customerController.text}',
            );
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
          child: const Text(
            'Confirm Rental',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
