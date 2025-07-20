// lib/views/available_cars.dart
import 'package:flutter/material.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/models/car_status.dart';
import 'package:management_system/views/car_form_dialog.dart';
import 'package:management_system/views/rent_car_dialog.dart';
import 'dart:io';

class AvailableCars extends StatefulWidget {
  final VoidCallback? onCarStatusChanged;

  const AvailableCars({super.key, this.onCarStatusChanged});

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
    setState(() => isLoading = true);
    try {
      // Load all cars and then filter out 'archived' ones locally
      // This allows 'rented' and 'maintenance' to still show here
      final loadedCars = await _dbHelper.getAllCars();
      setState(() {
        cars = loadedCars
            .where((car) => car.status != CarStatus.archived)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
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

  Future<void> _archiveCar(Car car) async {
    try {
      await _dbHelper.archiveCar(car.id!); // Call DB helper's archive method
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Car archived successfully!'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      _loadCars(); // Reload cars to remove the archived one from this list
      widget.onCarStatusChanged?.call(); // Notify dashboard
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error archiving car: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _setCarStatus(Car car, CarStatus status) async {
    try {
      car.status = status; // Update local car object
      await _dbHelper.updateCar(car); // Update in database
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Car status updated to ${status.displayName}!'),
            backgroundColor: Colors.green,
          ),
        );
      }
      _loadCars(); // Reload cars to reflect new status (e.g., rented car disappears)
      widget.onCarStatusChanged?.call(); // Notify dashboard
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating car status: $e'),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Cars',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => CarFormDialog(
                      onSave: (car) async {
                        await _dbHelper.insertCar(car);
                        _loadCars();
                        widget.onCarStatusChanged?.call();
                      },
                    ),
                  ),
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
                        childAspectRatio: calculateAspectRatio(context),
                      ),
                      itemBuilder: (context, index) =>
                          buildCarCard(context, cars[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  int calculateCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1400) return 4;
    if (width > 1000) return 3;
    if (width > 600) return 2;
    return 1;
  }

  double calculateAspectRatio(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1400) return 1.1;
    if (width > 1000) return 1.0;
    if (width > 600) return 0.95;
    return 0.9;
  }

  Widget buildCarCard(BuildContext context, Car car) {
    return Stack(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _buildCarImage(car)),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      car.fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
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
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: car.status == CarStatus.available
                            ? Colors.green.withOpacity(0.1)
                            : car.status == CarStatus.rented
                            ? Colors.orange.withOpacity(0.1)
                            : Colors.blue.withOpacity(0.1), // For maintenance
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        car.status.displayName.toUpperCase(),
                        style: TextStyle(
                          color: car.status == CarStatus.available
                              ? Colors.green
                              : car.status == CarStatus.rented
                              ? Colors.orange
                              : Colors.blue,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: car.status == CarStatus.available
                              ? ElevatedButton.icon(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => RentCarDialog(
                                      car: car,
                                      onRentalConfirmed: () {
                                        _setCarStatus(car, CarStatus.rented);
                                        widget.onCarStatusChanged?.call();
                                      },
                                    ),
                                  ),
                                  icon: const Icon(Icons.car_rental, size: 18),
                                  label: const Text(
                                    "Rent",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                  ),
                                )
                              : ElevatedButton.icon(
                                  onPressed: () => _confirmReturn(car),
                                  icon: const Icon(Icons.undo, size: 18),
                                  label: const Text(
                                    "Return",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => CarFormDialog(
                                existingCar: car,
                                onSave: (updatedCar) async {
                                  await _dbHelper.updateCar(updatedCar);
                                  _loadCars();
                                  widget.onCarStatusChanged?.call();
                                },
                              ),
                            ),
                            icon: const Icon(Icons.edit, size: 18),
                            label: const Text(
                              "Edit",
                              style: TextStyle(fontSize: 13),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.deepPurple,
                              side: const BorderSide(color: Colors.deepPurple),
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
        ),
        Positioned(
          top: 6,
          right: 6,
          child: IconButton(
            icon: const Icon(
              Icons.archive_outlined,
              color: Colors.blueGrey,
            ), // Changed to archive icon
            tooltip: "Archive Car",
            onPressed: () => _confirmArchive(context, car),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmArchive(BuildContext context, Car car) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Archive Car"),
        content: const Text(
          "Are you sure you want to archive this car? It will be moved to the archive page.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirm"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          ),
        ],
      ),
    );
    if (result == true) {
      _archiveCar(car);
    }
  }

  Future<void> _confirmReturn(Car car) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Return Car"),
        content: const Text("Are you sure you want to return this car?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
    if (result == true) {
      _setCarStatus(car, CarStatus.available);
    }
  }

  Widget _buildCarImage(Car car) {
    if (car.imagePath != null &&
        car.imagePath!.isNotEmpty &&
        File(car.imagePath!).existsSync()) {
      return Image.file(
        File(car.imagePath!),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } else {
      return _buildPlaceholder();
    }
  }

  Widget _buildPlaceholder() {
    return Image.asset('assets/images/sample.png', fit: BoxFit.cover);
  }
}
