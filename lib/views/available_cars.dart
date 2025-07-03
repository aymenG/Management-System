import 'package:flutter/material.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/views/rent_car_dialog.dart';

class AvailableCars extends StatelessWidget {
  const AvailableCars({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample cars (replace with DB data later)
    final List<Car> cars = [
      Car(
        name: 'Toyota Corolla',
        matricule: 'COR-2023',
        dailyPrice: 45.0,
        imagePath: 'assets/images/corolla.jpg',
      ),
      Car(
        name: 'Hyundai Elantra',
        matricule: 'ELN-2023',
        dailyPrice: 50.0,
        imagePath: 'assets/images/elantra.png',
      ),
      Car(
        name: 'Honda Civic',
        matricule: 'CIV-2022',
        dailyPrice: 55.0,
        imagePath: 'assets/images/civic.png',
      ),
      Car(
        name: 'Kia Rio',
        matricule: 'RIO-2023',
        dailyPrice: 40.0,
        imagePath: 'assets/images/rio.jpg',
      ),
      Car(
        name: 'Toyota Corolla',
        matricule: 'COR-2023',
        dailyPrice: 45.0,
        imagePath: 'assets/images/corolla.jpg',
      ),
      Car(
        name: 'Hyundai Elantra',
        matricule: 'ELN-2023',
        dailyPrice: 50.0,
        imagePath: 'assets/images/elantra.png',
      ),
      Car(
        name: 'Honda Civic',
        matricule: 'CIV-2022',
        dailyPrice: 55.0,
        imagePath: 'assets/images/civic.png',
      ),
      Car(
        name: 'Kia Rio',
        matricule: 'RIO-2023',
        dailyPrice: 40.0,
        imagePath: 'assets/images/rio.jpg',
      ),
      Car(
        name: 'Toyota Corolla',
        matricule: 'COR-2023',
        dailyPrice: 45.0,
        imagePath: 'assets/images/corolla.jpg',
      ),
      Car(
        name: 'Hyundai Elantra',
        matricule: 'ELN-2023',
        dailyPrice: 50.0,
        imagePath: 'assets/images/elantra.png',
      ),
      Car(
        name: 'Honda Civic',
        matricule: 'CIV-2022',
        dailyPrice: 55.0,
        imagePath: 'assets/images/civic.png',
      ),
      Car(
        name: 'Kia Rio',
        matricule: 'RIO-2023',
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
          crossAxisCount: calculateCrossAxisCount(context),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.3,
        ),
        itemBuilder: (context, index) {
          final car = cars[index];
          return buildCarCard(context, car);
        },
      ),
    );
  }

  /// Calculate columns based on screen width
  int calculateCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1400) return 4;
    if (width > 1000) return 3;
    return 2;
  }

  Widget buildCarCard(BuildContext context, Car car) {
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
                  "Matricule: ${car.matricule}",
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
                // --- Buttons Row ---
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => RentCarDialog(car: car),
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
                    const SizedBox(width: 8), // Spacer between buttons
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Implement edit functionality
                          print('Edit button pressed for ${car.name}');
                          // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => EditCarScreen(car: car)));
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("Edit"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.deepPurple,
                          side: const BorderSide(
                            color: Colors.deepPurple,
                          ), // Choose an appropriate color
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
