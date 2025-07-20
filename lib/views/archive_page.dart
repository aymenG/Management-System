import 'package:flutter/material.dart';
import 'package:management_system/controllers/database_helper.dart';

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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Restore"),
        content: const Text("Are you sure you want to restore this item?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Restore"),
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
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.primary,
          tabs: const [
            Tab(text: 'Cars'),
            Tab(text: 'Rentals'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [_buildArchivedCars(), _buildArchivedRentals()],
          ),
        ),
      ],
    );
  }

  Widget _buildArchivedCars() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: dbHelper.getArchivedCars(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.isEmpty)
          return const Center(child: Text('No archived cars.'));

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
              subtitle: Text('Plate: ${car['plate_number']}'),
              trailing: IconButton(
                icon: const Icon(Icons.restore),
                tooltip: 'Restore Car',
                onPressed: () {
                  _confirmRestore(
                    context: context,
                    onConfirm: () async {
                      await dbHelper.restoreCar(car['id']);
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

  Widget _buildArchivedRentals() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: dbHelper.getArchivedRentals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.isEmpty)
          return const Center(child: Text('No archived rentals.'));

        final rentals = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: rentals.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final rental = rentals[index];
            return ListTile(
              leading: const Icon(Icons.receipt_long),
              title: Text(rental['customer_name'] ?? 'Unknown Customer'),
              subtitle: Text(
                'Car: ${rental['brand']} ${rental['model']} - Plate: ${rental['plate_number']}\n'
                'Rent: ${rental['rent_date']} → Return: ${rental['return_date']}',
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.restore),
                tooltip: 'Restore Rental',
                onPressed: () {
                  _confirmRestore(
                    context: context,
                    onConfirm: () async {
                      await dbHelper.restoreRental(rental['id']);
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
