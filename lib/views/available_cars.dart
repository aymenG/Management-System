import 'package:flutter/material.dart';
import 'package:management_system/models/car.dart';

class AvailableCars extends StatelessWidget {
  const AvailableCars({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample cars (replace with DB data later)
    final List<Car> cars = [
      Car(
        name: 'Toyota Corolla',
        model: '2021',
        plateNumber: 'ABC-123',
        dailyPrice: 45.0,
        imagePath: 'assets/images/corolla.jpg',
      ),
      Car(
        name: 'Hyundai Elantra',
        model: '2020',
        plateNumber: 'XYZ-789',
        dailyPrice: 50.0,
        imagePath: 'assets/images/elantra.png',
      ),
      Car(
        name: 'Honda Civic',
        model: '2022',
        plateNumber: 'DEF-456',
        dailyPrice: 55.0,
        imagePath: 'assets/images/civic.png',
      ),
      Car(
        name: 'Kia Rio',
        model: '2019',
        plateNumber: 'JKL-321',
        dailyPrice: 40.0,
        imagePath: 'assets/images/rio.jpg',
      ),
    ];

    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: cars.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _calculateCrossAxisCount(context),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.3,
        ),
        itemBuilder: (context, index) {
          final car = cars[index];
          return _buildCarCard(context, car);
        },
      ),
    );
  }

  /// Calculate columns based on screen width
  int _calculateCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1400) return 4;
    if (width > 1000) return 3;
    return 2;
  }

  Widget _buildCarCard(BuildContext context, Car car) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Image.asset(car.imagePath, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Model: ${car.model}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  "Plate: ${car.plateNumber}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  "Price/day: \$${car.dailyPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to rent screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Rent ${car.name}")),
                      );
                    },
                    icon: const Icon(Icons.car_rental),
                    label: const Text("Rent Car"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
