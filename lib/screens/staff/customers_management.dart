import 'package:flutter/material.dart';
import '../../services/demo_store.dart';

class CustomersManagement extends StatelessWidget {
  final DemoStore store;
  const CustomersManagement({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<dynamic>>{};
    for (final order in store.orders) {
      grouped.putIfAbsent(order.customerId, () => []).add(order);
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Customer Management',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Customer records derived from active order records in demo mode.',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 18),
        ...grouped.entries.map((entry) {
          final orders = entry.value;
          final name = orders.first.customerName;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text('${orders.length} order(s)'),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        }),
      ],
    );
  }
}
