// views/car_form_dialog.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:management_system/models/car.dart';
import 'package:management_system/models/car_brand.dart';
import 'package:management_system/models/car_status.dart';
import 'package:management_system/l10n/app_localizations.dart'; // Import AppLocalizations
import 'package:management_system/utils/enum_localizations.dart'; // Import for CarStatus extension

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
  // bool _isLoading = false; // This variable is not used in the provided snippet, consider removing if not needed.

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

    if (c?.imagePath != null &&
        c!.imagePath!.isNotEmpty &&
        File(c.imagePath!).existsSync()) {
      _pickedImage = File(c.imagePath!);
    } else {
      _pickedImage = null;
    }

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

    final car = Car(
      id: widget.existingCar?.id,
      brand: _selectedBrand!,
      model: _modelController.text.trim(),
      year: int.parse(_yearController.text.trim()),
      plateNumber: _plateController.text.trim(),
      dailyPrice: double.parse(_priceController.text.trim()),
      imagePath:
          _pickedImage?.path ??
          (widget.existingCar?.imagePath?.isNotEmpty == true
              ? widget.existingCar!.imagePath
              : null),
      status: _status!,
    );

    widget.onSave(car);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(
      context,
    )!; // Get localizations
    final isEditing = widget.existingCar != null;

    return AlertDialog(
      title: Text(
        isEditing
            ? localizations.carFormEditDialogTitle
            : localizations.carFormAddDialogTitle,
      ), // Localized Title
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
                          child: Text(
                            b.displayName,
                          ), // Use b.displayName directly (untranslated)
                        ),
                      )
                      .toList(),
                  onChanged: (brand) => setState(() => _selectedBrand = brand),
                  decoration: InputDecoration(
                    labelText: localizations
                        .carFormBrandDropdownLabel, // Localized Label
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) => value == null
                      ? localizations.carFormSelectBrandValidationError
                      : null, // Localized Validation
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _modelController,
                  decoration: InputDecoration(
                    labelText: localizations
                        .carFormModelTextFieldLabel, // Localized Label
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? localizations.carFormEnterModelValidationError
                      : null, // Localized Validation
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: localizations
                        .carFormYearTextFieldLabel, // Localized Label
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return localizations
                          .carFormEnterYearValidationError; // Localized Validation
                    final year = int.tryParse(value);
                    if (year == null ||
                        year < 1900 ||
                        year > DateTime.now().year + 1) {
                      return localizations
                          .carFormEnterValidYearValidationError; // Localized Validation
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _plateController,
                  decoration: InputDecoration(
                    labelText: localizations
                        .carFormPlateNumberTextFieldLabel, // Localized Label
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? localizations.carFormEnterPlateNumberValidationError
                      : null, // Localized Validation
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: localizations
                        .dailyRentalRateLabel, // Re-using existing label
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return localizations
                          .carFormEnterDailyPriceValidationError; // Localized Validation
                    final price = double.tryParse(value);
                    if (price == null || price <= 0)
                      return localizations
                          .carFormEnterValidDailyPriceValidationError; // Localized Validation
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<CarStatus>(
                  value: _status,
                  items: CarStatus.values
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(s.displayLocalized(context)),
                        ), // Localized CarStatus
                      )
                      .toList(),
                  onChanged: (status) => setState(() => _status = status),
                  decoration: InputDecoration(
                    labelText: localizations
                        .carFormStatusDropdownLabel, // Localized Label
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: Text(
                    _pickedImage == null
                        ? localizations.carFormPickImageButtonLabel
                        : localizations
                              .carFormChangeImageButtonLabel, // Localized Label
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
          child: Text(localizations.cancelButton), // Re-used existing label
        ),
        ElevatedButton(
          onPressed: _save,
          child: Text(
            isEditing ? localizations.saveButton : localizations.addCarButton,
          ), // Re-used existing labels
        ),
      ],
    );
  }
}
