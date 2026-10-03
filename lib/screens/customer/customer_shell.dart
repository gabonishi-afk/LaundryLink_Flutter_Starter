import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../services/demo_store.dart';
import 'customer_dashboard.dart';
import 'customer_orders.dart';
import 'pickup_screen.dart';
import 'profile_screen.dart';

class CustomerShell extends StatefulWidget {
  final DemoStore store;
  final UserProfile user;
  final VoidCallback onLogout;

  const CustomerShell({
    super.key,
    required this.store,
    required this.user,
    required this.onLogout,
  });

  @override
  State<CustomerShell> createState() => _CustomerShellState();
}

class _CustomerShellState extends State<CustomerShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      CustomerDashboard(store: widget.store, user: widget.user),
      CustomerOrders(store: widget.store, user: widget.user),
      PickupScreen(store: widget.store, user: widget.user),
      ProfileScreen(user: widget.user, onLogout: widget.onLogout),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LaundryLink',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Notifications'),
                content: const Text(
                  'Your laundry order LL-1001 is currently drying.\n\n'
                  'You will receive an update when it is ready for pickup.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.notifications_none),
          ),
          const SizedBox(width: 8),
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
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Pickup',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
