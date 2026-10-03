import 'package:flutter/material.dart';
import '../../models/laundry_order.dart';
import '../../services/demo_store.dart';
import '../../utils/formatters.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/status_chip.dart';

class StaffDashboard extends StatelessWidget {
  final DemoStore store;
  const StaffDashboard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final active = store.orders.where((o) => o.status != OrderStatus.completed).length;
    final ready = store.orders.where((o) => o.status == OrderStatus.readyForPickup).length;
    final revenue = store.orders.fold<double>(0, (sum, o) => sum + o.totalAmount);
    final customers = store.orders.map((o) => o.customerId).toSet().length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Management Dashboard',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Overview of today’s laundry operations.',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final count = constraints.maxWidth >= 900
                ? 4
                : constraints.maxWidth >= 600
                    ? 2
                    : 1;
            return GridView.count(
              crossAxisCount: count,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                StatCard(label: 'Active Orders', value: '$active', icon: Icons.local_laundry_service),
                StatCard(label: 'Ready', value: '$ready', icon: Icons.check_circle_outline),
                StatCard(label: 'Customers', value: '$customers', icon: Icons.people_outline),
                StatCard(label: 'Sales', value: peso(revenue), icon: Icons.payments_outlined),
              ],
            );
          },
        ),
        const SizedBox(height: 28),
        Text(
          'Recent Orders',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 12),
        ...store.orders.take(5).map(
          (order) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.local_laundry_service),
              ),
              title: Text(
                '${order.id} • ${order.customerName}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(order.serviceType),
              trailing: StatusChip(status: order.status),
            ),
          ),
        ),
      ],
    );
  }
}