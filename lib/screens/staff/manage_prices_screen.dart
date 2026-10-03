import 'package:flutter/material.dart';
import '../../models/laundry_service.dart';
import '../../services/demo_store.dart';

class ManagePricesScreen extends StatelessWidget {
  const ManagePricesScreen({super.key});

  void _showEditPriceDialog(BuildContext context, LaundryService service) {
    // In _showEditPriceDialog:
    final controller = TextEditingController(text: service.price.toStringAsFixed(0));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Price: ${service.name}'),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            // In TextField decoration:
            decoration: const InputDecoration(
              labelText: 'Fixed Rate for 8kg (₱)',
              prefixText: '₱ ',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newPrice = double.tryParse(controller.text);
                if (newPrice != null && newPrice > 0) {
                  DemoStore.instance.updateServicePrice(service.id, newPrice);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Service Prices'),
      ),
      body: ListenableBuilder(
        listenable: DemoStore.instance,
        builder: (context, child) {
          final services = DemoStore.instance.services;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: services.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final service = services[index];
              return Card(
                child: ListTile(
                  title: Text(service.name),
                  // In ListTile subtitle:
                  subtitle: Text('₱${service.price.toStringAsFixed(0)} / 8kg load'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditPriceDialog(context, service),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}