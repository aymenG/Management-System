import 'package:flutter/material.dart';

class CRSDashboard extends StatelessWidget {
  const CRSDashboard({super.key});

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopCards(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: _buildIncomeChartPlaceholder()),
                        const SizedBox(width: 20),
                        Expanded(child: _buildCustomerChartPlaceholder()),
                      ],
                    ),
                  ),
                ],
              ),
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
            'Welcome,\nAdmin',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 30),
          _buildSidebarItem(Icons.home, 'Home', () {
            print("Home tapped");
          }),
          _buildSidebarItem(Icons.directions_car, 'Available Cars', () {
            print("Available Cars tapped");
          }),
          _buildSidebarItem(Icons.assignment_returned, 'Rent Car', () {
            print("Rent Car tapped");
          }),
          const Spacer(),
          _buildSidebarItem(Icons.logout, 'Sign Out', () {
            print("Sign Out tapped");
          }),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, Function()? onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      hoverColor: Colors.deepPurple,
      onTap: onTap,
    );
  }

  Widget _buildTopCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDashboardCard(Icons.directions_car, 'Available Cars', '1'),
        _buildDashboardCard(Icons.attach_money, 'Total Income', '\$11,590.0'),
        _buildDashboardCard(Icons.group, 'Total Customers', '9'),
      ],
    );
  }

  Widget _buildDashboardCard(IconData icon, String title, String value) {
    return Card(
      elevation: 4,
      child: Container(
        width: 200,
        height: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.deepPurple),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeChartPlaceholder() {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: const Center(child: Text('Income Data Chart Placeholder')),
      ),
    );
  }

  Widget _buildCustomerChartPlaceholder() {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: const Center(child: Text('Customers Data Chart Placeholder')),
      ),
    );
  }
}
