import 'package:flutter/material.dart';
import '../../models/user_profile.dart';
import '../../models/laundry_order.dart';
import '../../services/demo_store.dart';
import '../../utils/formatters.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/status_chip.dart';

class CustomerDashboard extends StatelessWidget {
  final DemoStore store;
  final UserProfile user;

  const CustomerDashboard({
    super.key,
    required this.store,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final orders = store.orders.where((order) => order.customerId == user.id).toList();
    final active = orders.where((o) => o.status != OrderStatus.completed).length;
    final ready = orders.where((o) => o.status == OrderStatus.readyForPickup).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${user.name.split(' ').first}!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Here is the latest update on your laundry.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 22),
              LayoutBuilder(
                builder: (context, constraints) {
                  final count = constraints.maxWidth > 700 ? 3 : 1;
                  return GridView.count(
                    crossAxisCount: count,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.8,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      StatCard(
                        label: 'Active Orders',
                        value: '$active',
                        icon: Icons.local_laundry_service,
                      ),
                      StatCard(
                        label: 'Ready for Pickup',
                        value: '$ready',
                        icon: Icons.check_circle_outline,
                      ),
                      StatCard(
                        label: 'Total Orders',
                        value: '${orders.length}',
                        icon: Icons.receipt_long,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 28),
              Text(
                'Current Orders',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              if (orders.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('No orders yet.'),
                  ),
                )
              else
                ...orders.map(
                  (order) => Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: .1),
                            child: Icon(
                              Icons.local_laundry_service,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.id,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(order.serviceType),
                                Text(
                                  '${dateOnly(order.pickupDate)} • ${order.pickupTime}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              StatusChip(status: order.status),
                              const SizedBox(height: 8),
                              Text(
                                peso(order.totalAmount),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
