import 'package:flutter/material.dart';
import '../../services/demo_store.dart';
import '../../utils/formatters.dart';
import '../../widgets/status_chip.dart';

class PickupManagement extends StatelessWidget {
  final DemoStore store;
  const PickupManagement({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final orders = [...store.orders]
      ..sort((a, b) => a.pickupDate.compareTo(b.pickupDate));

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Pickup Schedule',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Monitor scheduled pickups and order readiness.',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 18),
        ...orders.map(
          (order) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.calendar_month),
              ),
              title: Text(
                '${dateOnly(order.pickupDate)} • ${order.pickupTime}',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text('${order.id} • ${order.customerName}'),
              trailing: StatusChip(status: order.status),
            ),
          ),
        ),
      ],
    );
  }
}
