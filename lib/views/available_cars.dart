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
                        childAspectRatio: calculateAspectRatio(
                          context,
                        ), // Re-evaluated
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
    if (width > 600) return 2;
    return 1;
  }

  /// Calculate aspect ratio based on screen size for better card content fitting
  // Adjusted for the new layout where content area is not Expanded with flex
  double calculateAspectRatio(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // These ratios are an estimation. You'll need to fine-tune them by running
    // and resizing your window/device to find the perfect balance.
    // A HIGHER childAspectRatio makes the card SHORTER relative to its width.
    if (width > 1400) return 1.1; // More columns, need shorter cards
    if (width > 1000) return 1.0; // 3 columns
    if (width > 600) return 0.95; // 2 columns
    return 0.9; // 1 column
  }

  Widget buildCarCard(BuildContext context, Car car) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image takes available space. We expect it to fill the top portion
          // and look good due to BoxFit.cover
          Expanded(child: _buildCarImage(car)),
          // Content area: its height will be determined by its children's intrinsic size
          // and the padding. It's no longer 'Expanded' with a flex.
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min is good here, to prevent it from
              // taking more space than its children need.
              mainAxisSize: MainAxisSize.min,
              children: [
                // Car details grouped
                Text(
                  car.fullName,
                  style: const TextStyle(
                    fontSize: 16, // Slightly larger font
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4), // Consistent small spacing
                Text(
                  "Plate: ${car.plateNumber}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "Year: ${car.year}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "DZD ${car.dailyPrice.toStringAsFixed(2)}/day",
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8), // More space before status
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
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12), // Consistent spacing before buttons
                // Buttons at bottom
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
                        icon: const Icon(
                          Icons.car_rental,
                          size: 18,
                        ), // Slightly larger icon
                        label: const Text(
                          "Rent",
                          style: TextStyle(fontSize: 13),
                        ), // Slightly larger text
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey[300],
                          disabledForegroundColor: Colors.grey[600],
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ), // Increased vertical padding
                          minimumSize: const Size(
                            0,
                            40,
                          ), // Increased minimum height for buttons
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
                        icon: const Icon(
                          Icons.edit,
                          size: 18,
                        ), // Slightly larger icon
                        label: const Text(
                          "Edit",
                          style: TextStyle(fontSize: 13),
                        ), // Slightly larger text
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.deepPurple,
                          side: const BorderSide(color: Colors.deepPurple),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ), // Increased vertical padding
                          minimumSize: const Size(
                            0,
                            40,
                          ), // Increased minimum height for buttons
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
      final file = File(car.imagePath);
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
        );
      } else {
        return Image.asset(
          car.imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
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
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: const Icon(Icons.car_rental, size: 40, color: Colors.grey),
    );
  }
}
