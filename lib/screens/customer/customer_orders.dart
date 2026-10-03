import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../services/demo_store.dart';
import '../../utils/formatters.dart';
import '../../widgets/status_chip.dart';
import '../../models/laundry_order.dart';
class CustomerOrders extends StatelessWidget {
  final DemoStore store;
  final UserProfile user;

  const CustomerOrders({
    super.key,
    required this.store,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final orders = store.ordersFor(user.id);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Track the progress of your laundry orders.',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 20),
        ...orders.map(
          (order) => Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: ExpansionTile(
              title: Text(
                order.id,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(order.serviceType),
              trailing: StatusChip(status: order.status),
              childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              children: [
                const Divider(),
                _row('Quantity', '${order.quantity} bag(s)'),
                _row('Amount', peso(order.totalAmount)),
                _row('Payment', order.paymentStatus),
                _row('Pickup', '${dateOnly(order.pickupDate)} • ${order.pickupTime}'),
                const SizedBox(height: 16),
                _Timeline(status: order.status),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            SizedBox(width: 100, child: Text(label)),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      );
}

class _Timeline extends StatelessWidget {
  final OrderStatus status;

  const _Timeline({required this.status});

  @override
  Widget build(BuildContext context) {
    const statuses = OrderStatus.values;
    return Column(
      children: statuses.map((item) {
        final active = item.index <= status.index;
        return Row(
          children: [
            Icon(
              active ? Icons.check_circle : Icons.radio_button_unchecked,
              size: 20,
              color: active
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade400,
            ),
            const SizedBox(width: 10),
            Text(
              item.label,
              style: TextStyle(
                fontWeight: active ? FontWeight.w700 : FontWeight.normal,
                color: active ? null : Colors.grey,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
