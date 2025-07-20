import 'package:flutter/material.dart';
import 'package:management_system/controllers/database_helper.dart'; // Ensure this path is correct
import 'package:intl/intl.dart'; // For date formatting
import 'package:management_system/views/edit_rental_dialog.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading rentals: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Helper method to format dates
  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "-";
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(dateTime); // e.g., Jul 13, 2025
    } catch (e) {
      return "-"; // Handle parsing errors gracefully
    }
  }

  // Helper method to format price - NOW RETURNS ONLY THE NUMBER
  String _formatPrice(dynamic price) {
    if (price == null) return "-";
    try {
      final doublePrice = double.parse(price.toString());
      // Format as currency, but then remove the symbol
      return NumberFormat.currency(
            locale: 'en_DZ', // Algeria locale for currency
            symbol: '', // Set symbol to empty string
            decimalDigits: 2,
          ) // Ensure 2 decimal places
          .format(doublePrice);
    } catch (e) {
      return "-";
    }
  }

  // Action for Edit button - now calls the external dialog
  void _onEditRental(int? rentalId) async {
    if (rentalId != null) {
      // Find the full rental map from the list
      final rentalToEdit = rentalsWithCarDetails.firstWhere(
        (rental) => rental['id'] == rentalId,
        orElse: () => {}, // Return empty map if not found (shouldn't happen)
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
        }
      } else {
        print("Error: Rental with ID $rentalId not found for editing.");
      }
    } else {
      print("Error: Attempted to edit a rental with a null ID.");
    }
  }

  // Action for Delete button - calls the confirmation dialog
  void _onDeleteRental(int? rentalId) {
    if (rentalId != null) {
      _showDeleteConfirmationDialog(rentalId);
    } else {
      print("Error: Attempted to delete a rental with a null ID.");
    }
  }

  Future<void> _showDeleteConfirmationDialog(int rentalId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this rental?'),
                Text('This action cannot be undone.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss dialog
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
              onPressed: () async {
                Navigator.of(dialogContext).pop(); // Dismiss dialog
                try {
                  await _dbHelper.archiveRental(rentalId);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Rental deleted successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  _loadRentals(); // Reload data after deletion
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error deleting rental: $e'),
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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Active & Past Rentals",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
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
                          "No rentals found yet!",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Start by adding a new car rental.",
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
                    child:
                        _buildDesktopTableView(), // Your original table widget
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTableView() {
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
        // Use LayoutBuilder to determine available width
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate minimum width needed for the table content
            // This is an estimation, you might need to fine-tune these values
            // based on the average length of your data.
            // Sum of approximate minimum widths for each column:
            // ID: 40, Customer: 120, Brand: 100, Model: 100, Plate: 100,
            // Rent Date: 120, Return Date: 120, Price: 100, Actions: 100
            const double minTableWidth = 900; // Adjusted based on column counts

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
                  columns: const [
                    DataColumn(label: _TableHeader("ID")),
                    DataColumn(label: _TableHeader("Customer")),
                    DataColumn(label: _TableHeader("Car Brand")),
                    DataColumn(label: _TableHeader("Car Model")),
                    DataColumn(label: _TableHeader("Plate Number")),
                    DataColumn(label: _TableHeader("Rent Date")),
                    DataColumn(label: _TableHeader("Return Date")),
                    DataColumn(label: _TableHeader("Total Price (DZD)")),
                    DataColumn(label: _TableHeader("Actions")),
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
                        DataCell(Text(_formatDate(rental['rent_date']))),
                        DataCell(Text(_formatDate(rental['return_date']))),
                        DataCell(Text(_formatPrice(rental['total_price']))),
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
                                tooltip: "Edit Rental",
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
                                tooltip: "Delete Rental",
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

// --- NEW WIDGET FOR TABLE HEADER TEXT STYLE ---
class _TableHeader extends StatelessWidget {
  final String text;
  const _TableHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14, // Keep font size consistent
        color: Colors.deepPurple,
      ),
    );
  }
}
