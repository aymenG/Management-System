import 'package:flutter/material.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:management_system/l10n/app_localizations.dart'; // Import AppLocalizations

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _refresh() {
    setState(() {}); // Rebuild to refresh FutureBuilders
  }

  Future<void> _confirmRestore({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) async {
    // This context is passed from the itemBuilder/onPressed, which should be valid.
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(localizations.archiveRestoreTitle), // Accesses localization
        content: Text(
          localizations.archiveConfirmRestore,
        ), // Accesses localization
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(localizations.cancelButton), // Accesses localization
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              localizations.archiveRestoreTitle,
            ), // Accesses localization
          ),
        ],
      ),
    );
    if (confirmed == true) onConfirm();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This context is the direct context of the ArchivePage widget, which is valid.
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.primary,
          tabs: [
            Tab(text: localizations.archiveCarsTab), // Accesses localization
            Tab(text: localizations.archiveRentalsTab), // Accesses localization
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildArchivedCars(localizations),
              _buildArchivedRentals(localizations),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArchivedCars(AppLocalizations localizations) {
    // localizations object is correctly passed here.
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: dbHelper.getArchivedCars(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              localizations.archiveNoArchivedCars,
            ), // Accesses localization
          );
        }

        final cars = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: cars.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final car = cars[index];
            return ListTile(
              leading: const Icon(Icons.directions_car),
              title: Text('${car['brand']} ${car['model']}'),
              subtitle: Text(
                localizations.plateNumber(
                  car['plate_number'].toString(),
                ), // Accesses localization
              ),
              trailing: IconButton(
                icon: const Icon(Icons.restore),
                tooltip: localizations
                    .archiveRestoreCarTooltip, // Accesses localization
                onPressed: () {
                  _confirmRestore(
                    context:
                        context, // Passes context from itemBuilder, which is valid.
                    onConfirm: () async {
                      await dbHelper.restoreCar(car['id']);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            localizations.carRestoredSuccess,
                          ), // Accesses localization
                        ),
                      );
                      _refresh();
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildArchivedRentals(AppLocalizations localizations) {
    // localizations object is correctly passed here.
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: dbHelper.getArchivedRentals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              localizations.archiveNoArchivedRentals,
            ), // Accesses localization
          );
        }

        final rentals = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: rentals.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final rental = rentals[index];
            return ListTile(
              leading: const Icon(Icons.receipt_long),
              title: Text(
                rental['customer_name'] ??
                    localizations
                        .archiveUnknownCustomer, // Accesses localization
              ),
              subtitle: Text(
                localizations.archiveRentalDetails(
                  // Accesses localization with parameters
                  rental['brand'] ?? '',
                  rental['model'] ?? '',
                  rental['plate_number'] ?? '',
                  rental['rent_date'] ?? '',
                  rental['return_date'] ?? '',
                ),
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.restore),
                tooltip: localizations
                    .archiveRestoreRentalTooltip, // Accesses localization
                onPressed: () {
                  _confirmRestore(
                    context:
                        context, // Passes context from itemBuilder, which is valid.
                    onConfirm: () async {
                      await dbHelper.restoreRental(rental['id']);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            localizations.rentalRestoredSuccess,
                          ), // Accesses localization
                        ),
                      );
                      _refresh();
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
