import 'package:management_system/models/car.dart';
import 'package:flutter/material.dart';

// available_cars_page.dart
import 'package:flutter/material.dart';

class AvailableCars extends StatelessWidget {
  const AvailableCars({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Car> cars = [
      Car(
        name: 'Toyota Corolla',
        model: '2021',
        imagePath: 'assets/images/corolla.jpg',
      ),
      Car(
        name: 'Hyundai Elantra',
        model: '2020',
        imagePath: 'assets/images/elantra.png',
      ),
      Car(
        name: 'Honda Civic',
        model: '2022',
        imagePath: 'assets/images/civic.png',
      ),
      Car(name: 'Kia Rio', model: '2019', imagePath: 'assets/images/rio.jpg'),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: cars.length,
      itemBuilder: (context, index) {
        final car = cars[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    car.imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Model: ${car.model}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
