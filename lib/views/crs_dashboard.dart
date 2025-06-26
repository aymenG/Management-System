import 'package:flutter/material.dart';

class CRSDashboard extends StatefulWidget {
  const CRSDashboard({super.key});

  @override
  State<CRSDashboard> createState() => _CRSDashboardState();
}

class _CRSDashboardState extends State<CRSDashboard> {
  int selectedIndex = 0;

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
            'Welcome,\nAdmin',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 30),
          _buildSidebarItem(Icons.home, 'Home', 0),
          _buildSidebarItem(Icons.directions_car, 'Available Cars', 1),
          _buildSidebarItem(Icons.assignment_returned, 'Rent Car', 2),
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
          print("Sign Out");
        } else {
          setState(() {
            selectedIndex = index;
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
        return const Center(child: Text("Available Cars Page"));
      case 2:
        return const Center(child: Text("Rent Car Page"));
      default:
        return const Center(child: Text("Page Not Found"));
    }
  }

  Widget _buildDashboardContent() {
    return Column(
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
