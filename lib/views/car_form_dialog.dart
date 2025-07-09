// views/car_form_dialog.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/models/car_brand.dart';
import 'package:management_system/models/car_status.dart';

class CarFormDialog extends StatefulWidget {
  final Car? existingCar;
  final Function(Car car) onSave;

  const CarFormDialog({super.key, this.existingCar, required this.onSave});

  @override
  State<CarFormDialog> createState() => _CarFormDialogState();
}

class _CarFormDialogState extends State<CarFormDialog> {
  final _formKey = GlobalKey<FormState>();
  CarBrand? _selectedBrand;
  late TextEditingController _modelController;
  late TextEditingController _yearController;
  late TextEditingController _plateController;
  late TextEditingController _priceController;
  File? _pickedImage;
  CarStatus? _status;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final c = widget.existingCar;
    _selectedBrand = c?.brand;
    _modelController = TextEditingController(text: c?.model ?? '');
    _yearController = TextEditingController(text: c?.year?.toString() ?? '');
    _plateController = TextEditingController(text: c?.plateNumber ?? '');
    _priceController = TextEditingController(
      text: c?.dailyPrice?.toString() ?? '',
    );
    _pickedImage = (c?.imagePath?.isNotEmpty ?? false)
        ? File(c!.imagePath)
        : null;
    _status = c?.status ?? CarStatus.available;
  }

  @override
  void dispose() {
    _modelController.dispose();
    _yearController.dispose();
    _plateController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _pickedImage = File(result.files.single.path!);
      });
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    if (_pickedImage == null && widget.existingCar == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final car = Car(
      id: widget.existingCar?.id,
      brand: _selectedBrand!,
      model: _modelController.text.trim(),
      year: int.parse(_yearController.text.trim()),
      plateNumber: _plateController.text.trim(),
      dailyPrice: double.parse(_priceController.text.trim()),
      imagePath: _pickedImage?.path ?? widget.existingCar?.imagePath ?? '',
      status: _status!,
    );

    widget.onSave(car);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingCar != null;
    return AlertDialog(
      title: Text(isEditing ? 'Edit Car' : 'Add Car'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<CarBrand>(
                  value: _selectedBrand,
                  items: CarBrand.values
                      .map(
                        (b) => DropdownMenuItem(
                          value: b,
                          child: Text(b.displayName),
                        ),
                      )
                      .toList(),
                  onChanged: (brand) => setState(() => _selectedBrand = brand),
                  decoration: const InputDecoration(
                    labelText: "Brand",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null ? 'Please select a brand' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(
                    labelText: "Model",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Enter a model' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Year",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter year';
                    final year = int.tryParse(value);
                    if (year == null ||
                        year < 1900 ||
                        year > DateTime.now().year + 1) {
                      return 'Enter valid year';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _plateController,
                  decoration: const InputDecoration(
                    labelText: "Plate Number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Enter plate' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Daily Price (\$)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter price';
                    final price = double.tryParse(value);
                    if (price == null || price <= 0) return 'Enter valid price';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<CarStatus>(
                  value: _status,
                  items: CarStatus.values
                      .map(
                        (s) => DropdownMenuItem(value: s, child: Text(s.name)),
                      )
                      .toList(),
                  onChanged: (status) => setState(() => _status = status),
                  decoration: const InputDecoration(
                    labelText: "Status",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: Text(
                    _pickedImage == null ? "Pick Image" : "Change Image",
                  ),
                ),
                if (_pickedImage != null) ...[
                  const SizedBox(height: 12),
                  Image.file(_pickedImage!, height: 150, fit: BoxFit.cover),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _save,
          child: Text(isEditing ? "Save Changes" : "Add Car"),
        ),
      ],
    );
  }
}
