import 'package:flutter/material.dart';
import 'package:management_system/controllers/database_helper.dart'; // Ensure this path is correct
import 'package:intl/intl.dart'; // For date formatting

// Make sure you have the intl package in your pubspec.yaml:
// dependencies:
//   flutter:
//     sdk: flutter
//   intl: ^0.19.0 // Or the latest version

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

  // Helper method to format price
  String _formatPrice(dynamic price) {
    if (price == null) return "-";
    try {
      final doublePrice = double.parse(price.toString());
      return NumberFormat.currency(
            locale: 'en_DZ', // Algeria locale for currency
            symbol: 'DZD', // Explicitly set symbol
            decimalDigits: 2,
          ) // Ensure 2 decimal places
          .format(doublePrice);
    } catch (e) {
      return "-";
    }
  }

  // Action for Edit button
  void _onEditRental(int? rentalId) {
    if (rentalId != null) {
      print("Edit rental ID: $rentalId");
      // TODO: Implement navigation to edit page
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Editing rental $rentalId')));
    } else {
      print("Error: Attempted to edit a rental with a null ID.");
    }
  }

  // Action for Delete button
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
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
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
                  await _dbHelper.deleteRental(rentalId);
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
    final screenWidth = MediaQuery.of(context).size.width;
    const double breakpoint = 800; // Define your breakpoint for responsiveness

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Active & Past Rentals",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                    child: screenWidth > breakpoint
                        ? _buildDesktopTableView() // Show DataTable for larger screens
                        : _buildMobileListView(), // Show Card ListView for smaller screens
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement navigation to add new rental page
          print("Add new rental");
          // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => AddRentalPage()));
        },
        icon: const Icon(Icons.add),
        label: const Text("New Rental"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
    );
  }

  // --- Widget for Desktop/Wide Screen Table View ---
  Widget _buildDesktopTableView() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // Corrected syntax here
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        // Clip to make sure the table content respects the borderRadius
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection:
              Axis.vertical, // Allow vertical scrolling for the table
          child: SingleChildScrollView(
            scrollDirection:
                Axis.horizontal, // Allow horizontal scrolling for table columns
            child: DataTable(
              columnSpacing: 20, // Adjust spacing between columns
              dataRowMinHeight: 56,
              dataRowMaxHeight: 56,
              headingRowHeight:
                  60, // Slightly taller heading for better appearance
              headingRowColor: MaterialStateProperty.all(
                Colors.deepPurple.withOpacity(0.1),
              ), // Light purple header
              dividerThickness: 1.5, // Thicker dividers
              // No need for ConstrainedBox here, DataTable will size itself within SingleChildScrollView
              // and allow scrolling if content overflows.
              columns: const [
                DataColumn(label: _TableHeader("ID")),
                DataColumn(label: _TableHeader("Customer")),
                DataColumn(label: _TableHeader("Car Brand")),
                DataColumn(label: _TableHeader("Car Model")),
                DataColumn(label: _TableHeader("Plate Number")),
                DataColumn(label: _TableHeader("Rent Date")),
                DataColumn(label: _TableHeader("Return Date")),
                DataColumn(label: _TableHeader("Total Price")),
                DataColumn(
                  label: _TableHeader("Status"),
                ), // New column for status
                DataColumn(label: _TableHeader("Actions")),
              ],
              rows: rentalsWithCarDetails.map((rental) {
                final bool isOverdue =
                    rental['return_date'] != null &&
                    DateTime.parse(
                      rental['return_date'],
                    ).isBefore(DateTime.now());
                final bool isDueSoon =
                    rental['return_date'] != null &&
                    !isOverdue &&
                    DateTime.parse(
                      rental['return_date'],
                    ).isBefore(DateTime.now().add(const Duration(days: 3)));

                // Use rentalId in DataCell if available, otherwise a placeholder value (e.g., -1)
                final int rentalId = rental['id'] as int? ?? -1;

                return DataRow(
                  cells: [
                    DataCell(Text(rental['id']?.toString() ?? "-")),
                    DataCell(Text(rental['customer_name']?.toString() ?? "-")),
                    DataCell(Text(rental['brand']?.toString() ?? "-")),
                    DataCell(Text(rental['model']?.toString() ?? "-")),
                    DataCell(Text(rental['plate_number']?.toString() ?? "-")),
                    DataCell(Text(_formatDate(rental['rent_date']))),
                    DataCell(Text(_formatDate(rental['return_date']))),
                    DataCell(Text(_formatPrice(rental['total_price']))),
                    DataCell(
                      isOverdue
                          ? const Chip(
                              label: Text(
                                "OVERDUE",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.red,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            )
                          : isDueSoon
                          ? const Chip(
                              label: Text(
                                "DUE SOON",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.orange,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            )
                          : const Text(
                              "Active",
                              style: TextStyle(color: Colors.green),
                            ), // Default status
                    ),
                    DataCell(
                      // Removed explicit SizedBox width, letting Row and IconButton handle it
                      Row(
                        mainAxisSize: MainAxisSize.min, // Essential for fitting
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
                                : null, // Disable if ID is invalid
                          ),
                          // const SizedBox(width: 4), // Reduced spacing slightly
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                            tooltip: "Delete Rental",
                            onPressed: rentalId != -1
                                ? () => _onDeleteRental(rentalId)
                                : null, // Disable if ID is invalid
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget for Mobile/Narrow Screen List View ---
  Widget _buildMobileListView() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: rentalsWithCarDetails.length,
      itemBuilder: (context, index) {
        final rental = rentalsWithCarDetails[index];
        final int rentalId =
            rental['id'] as int? ?? -1; // Get ID, default to -1 if null
        return RentalCard(
          rental: rental,
          // Pass null if rentalId is invalid, so the button is disabled
          onEdit: rentalId != -1 ? () => _onEditRental(rentalId) : () {},
          onDelete: rentalId != -1 ? () => _onDeleteRental(rentalId) : () {},
          formatDate: _formatDate,
          formatPrice: _formatPrice,
        );
      },
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
        fontSize: 14, // Slightly smaller font for table headers
        color: Colors.deepPurple,
      ),
    );
  }
}

// --- REVISED WIDGET FOR INDIVIDUAL RENTAL CARD (Mobile View) ---
class RentalCard extends StatelessWidget {
  final Map<String, dynamic> rental;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(String?) formatDate; // Receive formatter from parent
  final Function(dynamic) formatPrice; // Receive formatter from parent

  const RentalCard({
    super.key,
    required this.rental,
    required this.onEdit,
    required this.onDelete,
    required this.formatDate, // Initialize
    required this.formatPrice, // Initialize
  });

  @override
  Widget build(BuildContext context) {
    final bool isOverdue =
        rental['return_date'] != null &&
        DateTime.parse(rental['return_date']).isBefore(DateTime.now());
    final bool isDueSoon =
        rental['return_date'] != null &&
        !isOverdue &&
        DateTime.parse(
          rental['return_date'],
        ).isBefore(DateTime.now().add(const Duration(days: 3)));

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: isOverdue
            ? const BorderSide(color: Colors.redAccent, width: 2)
            : isDueSoon
            ? const BorderSide(color: Colors.orangeAccent, width: 2)
            : BorderSide.none,
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Rental ID: ${rental['id']?.toString() ?? '-'}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isOverdue)
                  const Chip(
                    label: Text(
                      "OVERDUE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    backgroundColor: Colors.red,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  )
                else if (isDueSoon)
                  const Chip(
                    label: Text(
                      "DUE SOON",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    backgroundColor: Colors.orange,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  )
                else
                  const Chip(
                    label: Text(
                      "ACTIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    backgroundColor: Colors.green,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const Divider(height: 24, thickness: 1),

            _buildInfoRow(
              icon: Icons.person_outline,
              label: "Customer:",
              value: rental['customer_name']?.toString() ?? '-',
            ),
            const SizedBox(height: 8),

            _buildInfoRow(
              icon: Icons.directions_car_outlined,
              label: "Car:",
              value:
                  "${rental['brand']?.toString() ?? '-'} - ${rental['model']?.toString() ?? '-'}",
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.tag,
              label: "Plate No.:",
              value: rental['plate_number']?.toString() ?? '-',
            ),
            const SizedBox(height: 8),

            _buildInfoRow(
              icon: Icons.calendar_today_outlined,
              label: "Rent Date:",
              value: formatDate(rental['rent_date']),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.calendar_month_outlined,
              label: "Return Date:",
              value: formatDate(rental['return_date']),
            ),
            const SizedBox(height: 8),

            _buildInfoRow(
              icon: Icons.price_change_outlined,
              label: "Total Price:",
              value: formatPrice(rental['total_price']),
              valueStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text("Edit"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    side: const BorderSide(color: Colors.deepPurple),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    TextStyle? valueStyle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style:
                    valueStyle ??
                    const TextStyle(
                      fontSize: 15, // Slightly smaller font for mobile details
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
