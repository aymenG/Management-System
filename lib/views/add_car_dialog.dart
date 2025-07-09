// views/add_car_dialog.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/models/car_brand.dart';
import 'package:management_system/models/car_status.dart';

class AddCarDialog extends StatefulWidget {
  final VoidCallback? onCarAdded;

  const AddCarDialog({super.key, this.onCarAdded});

  @override
  State<AddCarDialog> createState() => _AddCarDialogState();
}

class _AddCarDialogState extends State<AddCarDialog> {
  final _formKey = GlobalKey<FormState>();
  CarBrand? _selectedBrand;
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _plateController = TextEditingController();
  final _priceController = TextEditingController();
  File? _pickedImage;
  bool _isLoading = false;

  @override
  void dispose() {
    _modelController.dispose();
    _yearController.dispose();
    _plateController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      
      if (result != null && result.files.single.path != null) {
        setState(() {
          _pickedImage = File(result.files.single.path!);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _saveCar() async {
    if (!_formKey.currentState!.validate()) return;

    // Check if image is selected
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an image for the car."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final newCar = Car(
        brand: _selectedBrand!,
        model: _modelController.text.trim(),
        year: int.parse(_yearController.text.trim()),
        plateNumber: _plateController.text.trim(),
        dailyPrice: double.parse(_priceController.text.trim()),
        imagePath: _pickedImage!.path,
        status: CarStatus.available,
      );

      // Save to database
      final dbHelper = DatabaseHelper();
      await dbHelper.insertCar(newCar);

      if (mounted) {
        Navigator.of(context).pop();
        widget.onCarAdded?.call();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${newCar.fullName} added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving car: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Car"),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Brand Dropdown
                DropdownButtonFormField<CarBrand>(
                  value: _selectedBrand,
                  items: CarBrand.values
                      .map((b) => DropdownMenuItem(
                            value: b,
                            child: Text(b.displayName),
                          ))
                      .toList(),
                  onChanged: (brand) => setState(() => _selectedBrand = brand),
                  decoration: const InputDecoration(
                    labelText: "Brand",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a brand';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Model Field
                TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(
                    labelText: "Model",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a model';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Year Field
                TextFormField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Year",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a year';
                    }
                    final year = int.tryParse(value.trim());
                    if (year == null || year < 1900 || year > DateTime.now().year + 1) {
                      return 'Please enter a valid year';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Plate Number Field
                TextFormField(
                  controller: _plateController,
                  decoration: const InputDecoration(
                    labelText: "Plate Number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a plate number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Daily Price Field
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Daily Price (\$)",
                    border: OutlineInputBorder(),
                    prefixText: '\$ ',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a daily price';
                    }
                    final price = double.tryParse(value.trim());
                    if (price == null || price <= 0) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Image Picker
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text("Pick Image"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    if (_pickedImage != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _pickedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _pickedImage!.path.split('/').last,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _pickedImage = null;
                              });
                            },
                            icon: const Icon(Icons.close, color: Colors.red),
                            iconSize: 20,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveCar,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text("Save Car"),
        ),
      ],
    );
  }
}