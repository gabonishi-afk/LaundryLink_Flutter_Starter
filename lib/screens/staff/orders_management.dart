import 'package:flutter/material.dart';
import '../../models/laundry_order.dart';
import '../../services/demo_store.dart';
import '../../utils/formatters.dart';
import '../../widgets/status_chip.dart';

class OrdersManagement extends StatefulWidget {
  final DemoStore store;
  const OrdersManagement({super.key, required this.store});

  @override
  State<OrdersManagement> createState() => _OrdersManagementState();
}

class _OrdersManagementState extends State<OrdersManagement> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.store.orders.where((o) {
      final q = search.toLowerCase();
      return o.id.toLowerCase().contains(q) ||
          o.customerName.toLowerCase().contains(q) ||
          o.serviceType.toLowerCase().contains(q);
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Laundry Orders',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 14),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Search order or customer...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) => setState(() => search = value),
        ),
        const SizedBox(height: 16),
        ...filtered.map(
          (order) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(
                '${order.id} • ${order.customerName}',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                '${order.serviceType} • ${peso(order.totalAmount)}\n'
                'Payment: ${order.paymentStatus}',
              ),
              isThreeLine: true,
              trailing: DropdownButton<OrderStatus>(
                value: order.status,
                underline: const SizedBox(),
                items: OrderStatus.values
                    .map(
                      (status) => DropdownMenuItem(
                        value: status,
                        child: StatusChip(status: status),
                      ),
                    )
                    .toList(),
                onChanged: (status) {
                  if (status == null) return;
                  setState(() {
                    widget.store.updateStatus(order.id, status);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${order.id} updated to ${status.label}.'),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
