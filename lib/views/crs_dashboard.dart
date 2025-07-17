// lib/views/dashboard.dart (or CRSDashboard.dart)
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:management_system/views/LoginForm.dart';
import 'package:management_system/views/available_cars.dart';
import 'package:management_system/views/rentals_page.dart';
import 'package:management_system/views/settings.dart';

class CRSDashboard extends StatefulWidget {
  const CRSDashboard({super.key});

  @override
  State<CRSDashboard> createState() => _CRSDashboardState();
}

class _CRSDashboardState extends State<CRSDashboard> {
  int selectedIndex = 0;

  double dailyIncome = 0.0;
  double monthlyIncome = 0.0;
  int dailyRentals = 0;
  int monthlyRentals = 0;

  List<Map<String, dynamic>> topRentedCars = [];

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  // This method will be called when car status changes in AvailableCars
  // lib/views/dashboard.dart

  Future<void> _loadDashboardData() async {
    print('CRSDashboard: _loadDashboardData called.');
    final dailyInc = await _dbHelper.getIncome(isMonthly: false);
    final monthlyInc = await _dbHelper.getIncome(isMonthly: true);
    final dailyRent = await _dbHelper.getRentalCount(isMonthly: false);
    final monthlyRent = await _dbHelper.getRentalCount(isMonthly: true);
    final topCars = await _dbHelper.getTopRentedCars();

    if (mounted) {
      setState(() {
        dailyIncome = dailyInc;
        monthlyIncome = monthlyInc;
        dailyRentals = dailyRent;
        monthlyRentals = monthlyRent;
        topRentedCars = topCars;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildContent(selectedIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 200,
      color: Colors.deepPurple,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          const Icon(Icons.person, size: 50, color: Colors.white),
          const SizedBox(height: 10),
          const Text(
            'Welcome',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 30),
          _buildSidebarItem(Icons.home, 'Home', 0),
          _buildSidebarItem(Icons.directions_car, 'Available Cars', 1),
          _buildSidebarItem(Icons.list_alt, 'Rentals', 2),
          _buildSidebarItem(Icons.settings, 'Settings', 3),
          const Spacer(),
          _buildSidebarItem(Icons.logout, 'Sign Out', -1),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      hoverColor: Colors.deepPurpleAccent,
      selected: selectedIndex == index,
      selectedTileColor: Colors.deepPurpleAccent,
      onTap: () {
        if (index == -1) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(body: LoginFormWidget()),
            ),
            (route) => false,
          );
        } else {
          setState(() {
            selectedIndex = index;
            if (index == 0) {
              // Reload dashboard data when returning to home/dashboard
              _loadDashboardData();
            }
          });
        }
      },
    );
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return _buildDashboardContent();
      case 1:
        // Pass the callback to AvailableCars
        return AvailableCars(onCarStatusChanged: _loadDashboardData);
      case 2:
        return const RentalsPage(); // Assuming RentalsPage doesn't need to update dashboard immediately for now
      case 3:
        return const SettingsPage();
      default:
        return const Center(child: Text("Page Not Found"));
    }
  }

  Widget _buildDashboardContent() {
    final formatter = NumberFormat("#,##0.00", "en_US");
    final intFormatter = NumberFormat.decimalPattern();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dashboard Overview",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildDashboardCard(
                Icons.monetization_on,
                'Daily Income',
                "${formatter.format(dailyIncome)} DZD",
              ),
              _buildDashboardCard(
                Icons.monetization_on_outlined,
                'Monthly Income',
                "${formatter.format(monthlyIncome)} DZD",
              ),
              _buildDashboardCard(
                Icons.car_rental,
                'Daily Rentals',
                intFormatter.format(dailyRentals),
              ),
              _buildDashboardCard(
                Icons.car_rental_outlined,
                'Monthly Rentals',
                intFormatter.format(monthlyRentals),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildTopRentedCarsSection(),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(IconData icon, String title, String value) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 160, maxWidth: 250),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 40, color: Colors.deepPurple),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopRentedCarsSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Rented Cars',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            topRentedCars.isEmpty
                ? const Text('No rentals yet.')
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: topRentedCars.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final car = topRentedCars[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.deepPurple.withOpacity(0.8),
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          car['fullName'] ?? 'Unknown Car',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "${car['rentalCount']} rentals",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
