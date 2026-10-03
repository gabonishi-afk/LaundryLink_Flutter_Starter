import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../services/demo_store.dart';
import 'staff_dashboard.dart';
import 'orders_management.dart';
import 'customers_management.dart';
import 'pickup_management.dart';

class StaffShell extends StatefulWidget {
  final DemoStore store;
  final UserProfile user;
  final VoidCallback onLogout;

  const StaffShell({
    super.key,
    required this.store,
    required this.user,
    required this.onLogout,
  });

  @override
  State<StaffShell> createState() => _StaffShellState();
}

class _StaffShellState extends State<StaffShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      StaffDashboard(store: widget.store),
      OrdersManagement(store: widget.store),
      CustomersManagement(store: widget.store),
      PickupManagement(store: widget.store),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LaundryLink Staff',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                widget.user.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onLogout,
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Customers',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Pickups',
          ),
        ],
      ),
    );
  }
}
