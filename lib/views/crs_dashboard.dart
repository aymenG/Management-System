import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:management_system/main.dart'; // Import main.dart to access MainApp.setLocale
import 'package:management_system/views/LoginForm.dart';
import 'package:management_system/views/archive_page.dart';
import 'package:management_system/views/available_cars.dart';
import 'package:management_system/views/rentals_page.dart';
import 'package:management_system/views/settings.dart';
import 'package:management_system/l10n/app_localizations.dart';

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

  Future<void> _loadDashboardData() async {
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

  // Helper to get the current locale for the dropdown's 'value'
  // Ensures the dropdown reflects the currently active language.
  Locale _getCurrentLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final localizer = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          _buildSidebar(localizer),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildContent(selectedIndex, localizer),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(AppLocalizations localizer) {
    return Container(
      width: 200,
      color: Colors.deepPurple,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Language selection dropdown (now functional with Stateful MainApp)
          DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              value: _getCurrentLocale(context), // Use the current app locale
              dropdownColor: Colors.deepPurple,
              iconEnabledColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              items: AppLocalizations.supportedLocales.map((locale) {
                String languageName;
                switch (locale.languageCode) {
                  case 'en':
                    languageName = 'English';
                    break;
                  case 'fr':
                    languageName = 'Français';
                    break;
                  case 'ar':
                    languageName = 'العربية';
                    break;
                  default:
                    languageName = 'Unknown';
                }
                return DropdownMenuItem(
                  value: locale,
                  child: Text(
                    languageName,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (Locale? locale) {
                if (locale != null) {
                  // Call the static method on MainApp to change the locale
                  MainApp.setLocale(context, locale);
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          const Icon(Icons.person, size: 50, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            localizer.welcome,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 30),
          _buildSidebarItem(Icons.home, localizer.home, 0),
          _buildSidebarItem(
            Icons.directions_car,
            localizer.availableCarsTitle,
            1,
          ),
          _buildSidebarItem(Icons.list_alt, localizer.rentals, 2),
          _buildSidebarItem(Icons.archive, localizer.archive, 3),
          _buildSidebarItem(Icons.settings, localizer.settings, 4),
          const Spacer(),
          _buildSidebarItem(Icons.logout, localizer.signOut, -1),
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
      onTap: () async {
        if (index == -1) {
          // Logout confirmation dialog
          final shouldLogout = await showDialog<bool>(
            context: context,
            builder: (context) {
              // Ensure AppLocalizations.of(context) is called within the builder's context
              final dialogLocalizer = AppLocalizations.of(context)!;
              return AlertDialog(
                title: Text(dialogLocalizer.confirmExit),
                content: Text(
                  dialogLocalizer.areYouSureToClose,
                ), // Re-using areYouSureToClose for generic exit
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(dialogLocalizer.cancelButton),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      dialogLocalizer.signOut,
                    ), // Use signOut for the confirm button in logout
                  ),
                ],
              );
            },
          );

          if (shouldLogout == true) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Scaffold(body: LoginFormWidget()),
              ),
              (route) => false,
            );
          }
        } else {
          setState(() {
            selectedIndex = index;
            if (index == 0)
              _loadDashboardData(); // Reload data when returning to dashboard
          });
        }
      },
    );
  }

  Widget _buildContent(int index, AppLocalizations localizer) {
    switch (index) {
      case 0:
        return _buildDashboardContent(localizer);
      case 1:
        return AvailableCars(onCarStatusChanged: _loadDashboardData);
      case 2:
        return const RentalsPage();
      case 3:
        return const ArchivePage();
      case 4:
        return const SettingsPage();
      default:
        return Center(
          child: Text(localizer.pageNotFound),
        ); // Localized "Page Not Found"
    }
  }

  Widget _buildDashboardContent(AppLocalizations localizer) {
    // NumberFormatters should adapt to the current locale
    final currentLocaleCode = Localizations.localeOf(context).languageCode;
    final formatter = NumberFormat("#,##0.00", currentLocaleCode);
    final intFormatter = NumberFormat.decimalPattern(currentLocaleCode);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizer.dashboardTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildDashboardCard(
                Icons.monetization_on,
                localizer.dailyIncome,
                "${formatter.format(dailyIncome)} ${localizer.currencySymbol}",
              ),
              _buildDashboardCard(
                Icons.monetization_on_outlined,
                localizer.monthlyIncome,
                "${formatter.format(monthlyIncome)} ${localizer.currencySymbol}",
              ),
              _buildDashboardCard(
                Icons.car_rental,
                localizer.dailyRentals,
                intFormatter.format(dailyRentals),
              ),
              _buildDashboardCard(
                Icons.car_rental_outlined,
                localizer.monthlyRentals,
                intFormatter.format(monthlyRentals),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildTopRentedCarsSection(localizer),
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

  Widget _buildTopRentedCarsSection(AppLocalizations localizer) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizer.topRentedCars,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            topRentedCars.isEmpty
                ? Text(localizer.noRentalsYet)
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: topRentedCars.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final car = topRentedCars[index];
                      final carFullName =
                          car['fullName'] ?? localizer.unknownCar;
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
                          carFullName,
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
                            localizer.numberOfRentals(
                              car['rentalCount'] as int,
                            ),
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
