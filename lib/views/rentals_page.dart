import 'package:flutter/material.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:management_system/controllers/fileExport.dart';
import 'package:management_system/views/edit_rental_dialog.dart';
import 'package:management_system/l10n/app_localizations.dart'; // Import AppLocalizations

class RentalsPage extends StatefulWidget {
  const RentalsPage({super.key});

  @override
  State<RentalsPage> createState() => _RentalsPageState();
}

class _RentalsPageState extends State<RentalsPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> rentalsWithCarDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRentals();
  }

  Future<void> _loadRentals() async {
    try {
      final rentals = await _dbHelper.getRentalsWithCarDetails();

      setState(() {
        rentalsWithCarDetails = rentals;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        final localizer = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${localizer.errorLoadingRentals}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Helper method to format dates
  String _formatDate(String? dateString, BuildContext context) {
    if (dateString == null || dateString.isEmpty) return "-";
    try {
      final dateTime = DateTime.parse(dateString);
      // Use the current locale for date formatting
      return DateFormat.yMMMd(
        Localizations.localeOf(context).toString(),
      ).format(dateTime);
    } catch (e) {
      return "-"; // Handle parsing errors gracefully
    }
  }

  // Helper method to format price
  String _formatPrice(dynamic price, BuildContext context) {
    if (price == null) return "-";
    try {
      final doublePrice = double.parse(price.toString());
      // Get the current locale from context
      final locale = Localizations.localeOf(context).toString();
      // Use NumberFormat to format the number
      return NumberFormat.currency(
        locale: locale,
        symbol: '',
        decimalDigits: 2,
      ).format(doublePrice);
    } catch (e) {
      return "-";
    }
  }

  // Action for Edit button
  void _onEditRental(int? rentalId) async {
    if (rentalId != null) {
      final localizer = AppLocalizations.of(context)!;
      // Find the full rental map from the list
      final rentalToEdit = rentalsWithCarDetails.firstWhere(
        (rental) => rental['id'] == rentalId,
        orElse: () => {},
      );

      if (rentalToEdit.isNotEmpty) {
        // Call the external dialog function
        final bool? updated = await showEditRentalDialog(
          context: context,
          dbHelper: _dbHelper,
          rentalData: rentalToEdit,
        );
        if (updated == true) {
          _loadRentals(); // Refresh the list if update occurred
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(localizer.rentalUpdatedSuccess),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
      } else {
        print(localizer.errorRentalNotFound(rentalId));
      }
    } else {
      final localizer = AppLocalizations.of(context)!;
      print(localizer.errorEditNullRentalId);
    }
  }

  // Action for Delete button
  void _onDeleteRental(int? rentalId) {
    if (rentalId != null) {
      _showDeleteConfirmationDialog(rentalId);
    } else {
      final localizer = AppLocalizations.of(context)!;
      print(localizer.errorDeleteNullRentalId);
    }
  }

  Future<void> _showDeleteConfirmationDialog(int rentalId) async {
    final localizer = AppLocalizations.of(context)!;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(localizer.confirmDeletionTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(localizer.deleteRentalConfirmation),
                Text(localizer.actionCannotBeUndone),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(localizer.cancelButton),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(localizer.deleteButton),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                try {
                  await _dbHelper.archiveRental(rentalId);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(localizer.rentalDeletedSuccess),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  _loadRentals(); // Reload data after deletion/archiving
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${localizer.errorDeletingRental}: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizer = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              localizer.rentalsPageTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                icon: const Icon(Icons.file_download),
                label: Text(localizer.exportRentalsButton),
                onPressed: rentalsWithCarDetails.isEmpty
                    ? null
                    : () async {
                        final DateTimeRange? pickedRange =
                            await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now().add(
                                const Duration(days: 30),
                              ),
                              helpText: localizer.pickDateRangeTitle,
                              cancelText: localizer.cancelButton,
                              confirmText: localizer.confirmButton,
                            );

                        if (pickedRange != null) {
                          final filtered = rentalsWithCarDetails.where((
                            rental,
                          ) {
                            final rentDate = DateTime.tryParse(
                              rental['rent_date'] ?? '',
                            );
                            return rentDate != null &&
                                rentDate.isAfter(
                                  pickedRange.start.subtract(
                                    const Duration(days: 1),
                                  ),
                                ) &&
                                rentDate.isBefore(
                                  pickedRange.end.add(const Duration(days: 1)),
                                );
                          }).toList();

                          if (filtered.isEmpty) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(localizer.noRentalsInDateRange),
                                ),
                              );
                            }
                          } else {
                            await exportRentalsToExcel(
                              context: context,
                              rentals: filtered,
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(localizer.exportSuccess),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          }
                        }
                      },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.deepPurple),
                  )
                : rentalsWithCarDetails.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_note_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          localizer.noRentalsFound,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          localizer.addRentalHint,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _loadRentals,
                    color: Colors.deepPurple,
                    child: _buildDesktopTableView(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTableView() {
    final localizer = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const double minTableWidth = 900;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth > minTableWidth
                      ? constraints.maxWidth
                      : minTableWidth,
                ),
                child: DataTable(
                  columnSpacing: 20,
                  dataRowMinHeight: 56,
                  dataRowMaxHeight: 56,
                  headingRowHeight: 60,
                  headingRowColor: MaterialStateProperty.all(
                    Colors.deepPurple.withOpacity(0.1),
                  ),
                  dividerThickness: 1.5,
                  columns: [
                    DataColumn(label: _TableHeader(localizer.rentalIdHeader)),
                    DataColumn(label: _TableHeader(localizer.customerHeader)),
                    DataColumn(label: _TableHeader(localizer.carBrandHeader)),
                    DataColumn(label: _TableHeader(localizer.carModelHeader)),
                    DataColumn(
                      label: _TableHeader(localizer.plateNumberHeader),
                    ),
                    DataColumn(label: _TableHeader(localizer.rentDateHeader)),
                    DataColumn(label: _TableHeader(localizer.returnDateHeader)),
                    DataColumn(
                      label: _TableHeader(
                        localizer.totalPriceHeader(localizer.currencySymbol),
                      ),
                    ),
                    DataColumn(label: _TableHeader(localizer.actionsHeader)),
                  ],
                  rows: rentalsWithCarDetails.map((rental) {
                    final int rentalId = rental['id'] as int? ?? -1;

                    return DataRow(
                      cells: [
                        DataCell(Text(rental['id']?.toString() ?? "-")),
                        DataCell(
                          Text(rental['customer_name']?.toString() ?? "-"),
                        ),
                        DataCell(Text(rental['brand']?.toString() ?? "-")),
                        DataCell(Text(rental['model']?.toString() ?? "-")),
                        DataCell(
                          Text(rental['plate_number']?.toString() ?? "-"),
                        ),
                        DataCell(
                          Text(_formatDate(rental['rent_date'], context)),
                        ),
                        DataCell(
                          Text(_formatDate(rental['return_date'], context)),
                        ),
                        DataCell(
                          Text(
                            "${_formatPrice(rental['total_price'], context)} ${localizer.currencySymbol}",
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.deepPurple,
                                  size: 20,
                                ),
                                tooltip: localizer.editRentalTooltip,
                                onPressed: rentalId != -1
                                    ? () => _onEditRental(rentalId)
                                    : null,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                tooltip: localizer.deleteRentalTooltip,
                                onPressed: rentalId != -1
                                    ? () => _onDeleteRental(rentalId)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Widget for table header text style
class _TableHeader extends StatelessWidget {
  final String text;
  const _TableHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.deepPurple,
      ),
    );
  }
}
