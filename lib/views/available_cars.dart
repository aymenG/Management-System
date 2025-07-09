import 'package:flutter/material.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/models/car_status.dart';
import 'package:management_system/views/car_form_dialog.dart';
import 'package:management_system/views/rent_car_dialog.dart';
import 'dart:io';

class AvailableCars extends StatefulWidget {
  const AvailableCars({super.key});

  @override
  State<AvailableCars> createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
  List<Car> cars = [];
  bool isLoading = true;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  Future<void> _loadCars() async {
    try {
      setState(() {
        isLoading = true;
      });

      final loadedCars = await _dbHelper.getAllCars();

      setState(() {
        cars = loadedCars;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading cars: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          // Header with Add Car button
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Cars',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CarFormDialog(
                        onSave: (car) async {
                          await _dbHelper.insertCar(car);
                          _loadCars();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Car'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Cars Grid
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : cars.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.car_rental,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No cars available',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add your first car to get started',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
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
                  ),
          ),
        ],
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
          Expanded(child: _buildCarImage(car)),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Plate: ${car.plateNumber}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  "Year: ${car.year}",
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
                const SizedBox(height: 8),
                // Status indicator
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: car.status == CarStatus.available
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    car.status.name.toUpperCase(),
                    style: TextStyle(
                      color: car.status == CarStatus.available
                          ? Colors.green
                          : Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: car.status == CarStatus.available
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (context) => RentCarDialog(car: car),
                                );
                              }
                            : null,
                        icon: const Icon(Icons.car_rental),
                        label: const Text("Rent Car"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey[300],
                          disabledForegroundColor: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CarFormDialog(
                              existingCar: car,
                              onSave: (updatedCar) async {
                                await _dbHelper.updateCar(updatedCar);
                                _loadCars();
                              },
                            ),
                          );

                         
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("Edit"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.deepPurple,
                          side: const BorderSide(color: Colors.deepPurple),
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

  Widget _buildCarImage(Car car) {
    if (car.imagePath.isNotEmpty) {
      // Try to load as file first (for picked images)
      final file = File(car.imagePath);
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
        );
      } else {
        // Try to load as asset (for asset images)
        return Image.asset(
          car.imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
        );
      }
    } else {
      return _buildPlaceholder();
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: const Icon(Icons.car_rental, size: 50, color: Colors.grey),
    );
  }
}
