import 'package:flutter/material.dart';
import '../../models/laundry_order.dart';
import '../../models/user_profile.dart';
import '../../services/demo_store.dart';

class PickupScreen extends StatefulWidget {
  final DemoStore store;
  final UserProfile user;

  const PickupScreen({
    super.key,
    required this.store,
    required this.user,
  });

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  DateTime date = DateTime.now().add(const Duration(days: 1));
  String time = '10:00 AM - 12:00 PM';
  String service = 'Wash, Dry & Fold';
  final quantity = TextEditingController(text: '1');

  final services = const [
    'Wash & Fold',
    'Wash, Dry & Fold',
    'Dry Clean',
  ];

  Future<void> chooseDate() async {
    final result = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      initialDate: date,
    );
    if (result != null) setState(() => date = result);
  }

  void requestPickup() {
    final qty = int.tryParse(quantity.text) ?? 1;
    final prices = {
      'Wash & Fold': 90.0,
      'Wash, Dry & Fold': 90.0,
      'Dry Clean': 100.0,
    };
    final order = LaundryOrder(
      id: 'LL-${1000 + widget.store.orders.length + 1}',
      customerId: widget.user.id,
      customerName: widget.user.name,
      serviceType: service,
      quantity: qty,
      totalAmount: (prices[service] ?? 90) * qty,
      paymentStatus: 'Pending',
      status: OrderStatus.received,
      pickupDate: date,
      pickupTime: time,
    );
    widget.store.addOrder(order);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pickup request ${order.id} created.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Schedule Pickup',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Choose a pickup date and time for your laundry.',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  initialValue: service,
                  decoration: const InputDecoration(
                    labelText: 'Service Type',
                    prefixIcon: Icon(Icons.local_laundry_service),
                  ),
                  items: services
                      .map(
                        (s) => DropdownMenuItem(value: s, child: Text(s)),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => service = value);
                  },
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: quantity,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantity / Bags',
                    prefixIcon: Icon(Icons.shopping_bag_outlined),
                  ),
                ),
                const SizedBox(height: 14),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_month),
                  title: const Text('Pickup Date'),
                  subtitle: Text(
                    '${date.month}/${date.day}/${date.year}',
                  ),
                  trailing: OutlinedButton(
                    onPressed: chooseDate,
                    child: const Text('Change'),
                  ),
                ),
                DropdownButtonFormField<String>(
                  initialValue: time,
                  decoration: const InputDecoration(
                    labelText: 'Pickup Time',
                    prefixIcon: Icon(Icons.schedule),
                  ),
                  items: const [
                    '10:00 AM - 12:00 PM',
                    '1:00 PM - 3:00 PM',
                    '3:00 PM - 5:00 PM',
                    '5:00 PM - 7:00 PM',
                  ]
                      .map(
                        (s) => DropdownMenuItem(value: s, child: Text(s)),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => time = value);
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: requestPickup,
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Request Pickup'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
