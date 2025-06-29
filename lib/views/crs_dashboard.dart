import 'package:ClinicManagementSystem/views/LoginForm.dart';
import 'package:ClinicManagementSystem/views/available_cars.dart';
import 'package:ClinicManagementSystem/views/rent_car.dart';
import 'package:fl_chart/fl_chart.dart';
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
          Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LoginFormWidget(), // Navigate back to the LoginForm
            ),
          );
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
        return const Center(child: AvailableCars());
      case 2:
        return const Center(child: RentCar());
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
             // Expanded(child: _buildIncomeChart()),
              const SizedBox(width: 20),
             // Expanded(child: _buildCustomerChart()),
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

  Widget _buildIncomeChart() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Income (Last 6 Months)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 500,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final months = [
                            'Jan',
                            'Feb',
                            'Mar',
                            'Apr',
                            'May',
                            'Jun',
                          ];
                          return Text(months[value.toInt()]);
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: [
                    for (int i = 0; i < 6; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: [8, 10, 14, 6, 11, 13][i].toDouble(),
                            color: Colors.deepPurple,
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerChart() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer Type Distribution',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 500,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      value: 40,
                      color: Colors.deepPurple,
                      title: 'Regular',
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: Colors.purpleAccent,
                      title: 'New',
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: Colors.deepOrange,
                      title: 'VIP',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
