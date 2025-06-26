// rent_car_page.dart
import 'package:flutter/material.dart';

class RentCar extends StatelessWidget {
  const RentCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rent a Car',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _buildForm(),
      ],
    );
  }

  Widget _buildForm() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField(label: 'Customer Name'),
            const SizedBox(height: 16),
            _buildTextField(label: 'Car ID or Name'),
            const SizedBox(height: 16),
            _buildTextField(label: 'Rent Date', hintText: 'YYYY-MM-DD'),
            const SizedBox(height: 16),
            _buildTextField(label: 'Return Date', hintText: 'YYYY-MM-DD'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.assignment_returned),
                label: const Text('Confirm Rental'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Logic for renting the car
                  print('Rental confirmed!');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, String? hintText}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
