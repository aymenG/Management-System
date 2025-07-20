import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> exportRentalsToExcel({
  required List<Map<String, dynamic>> rentals,
  required BuildContext context,
}) async {
  if (rentals.isEmpty) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No rentals to export.')));
    }
    return;
  }

  final excel = Excel.createExcel();
  final sheet = excel['Rentals'];

  sheet.appendRow([
    TextCellValue('Customer'),
    TextCellValue('Brand'),
    TextCellValue('Model'),
    TextCellValue('Plate Number'),
    TextCellValue('Rent Date'),
    TextCellValue('Return Date'),
    TextCellValue('Total Price'),
  ]);

  for (var rental in rentals) {
    sheet.appendRow([
      TextCellValue(rental['customer_name'] ?? ''),
      TextCellValue(rental['brand'] ?? ''),
      TextCellValue(rental['model'] ?? ''),
      TextCellValue(rental['plate_number'] ?? ''),
      TextCellValue(rental['rent_date'] ?? ''),
      TextCellValue(rental['return_date'] ?? ''),
      DoubleCellValue((rental['total_price'] ?? 0).toDouble()),
    ]);
  }

  final filePath = await FilePicker.platform.saveFile(
    dialogTitle: 'Save Rentals Excel File',
    fileName:
        'rentals_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.xlsx',
    type: FileType.custom,
    allowedExtensions: ['xlsx'],
  );

  if (filePath != null) {
    final fileBytes = excel.encode();
    final file = File(filePath);
    await file.writeAsBytes(fileBytes!);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Excel file exported successfully.')),
      );
    }
  } else {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Export cancelled.')));
    }
  }
}
