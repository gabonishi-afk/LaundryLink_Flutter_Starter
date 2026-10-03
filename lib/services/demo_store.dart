import 'package:flutter/material.dart';
import '../models/laundry_order.dart';
import '../models/laundry_service.dart';
import '../models/user_profile.dart';

class DemoStore extends ChangeNotifier {
  static final DemoStore instance = DemoStore._internal();

  DemoStore._internal();

  final List<UserProfile> users = const [
    UserProfile(
      id: 'customer-1',
      name: 'Juan Dela Cruz',
      email: 'customer@demo.com',
      role: UserRole.customer,
    ),
    UserProfile(
      id: 'staff-1',
      name: 'Laundry Staff',
      email: 'staff@demo.com',
      role: UserRole.staff,
    ),
  ];

  final List<LaundryOrder> _orders = [
    LaundryOrder(
      id: 'LL-1001',
      customerId: 'customer-1',
      customerName: 'Juan Dela Cruz',
      serviceType: 'Wash, Dry & Fold',
      quantity: 2,
      totalAmount: 180,
      paymentStatus: 'Paid',
      status: OrderStatus.drying,
      pickupDate: DateTime.now().add(const Duration(days: 1)),
      pickupTime: '10:00 AM - 12:00 PM',
    ),
    LaundryOrder(
      id: 'LL-1002',
      customerId: 'customer-1',
      customerName: 'Juan Dela Cruz',
      serviceType: 'Wash & Fold',
      quantity: 1,
      totalAmount: 90,
      paymentStatus: 'Pending',
      status: OrderStatus.received,
      pickupDate: DateTime.now().add(const Duration(days: 2)),
      pickupTime: '1:00 PM - 3:00 PM',
    ),
    LaundryOrder(
      id: 'LL-1003',
      customerId: 'customer-1',
      customerName: 'Juan Dela Cruz',
      serviceType: 'Dry Clean',
      quantity: 3,
      totalAmount: 300,
      paymentStatus: 'Paid',
      status: OrderStatus.readyForPickup,
      pickupDate: DateTime.now(),
      pickupTime: '3:00 PM - 5:00 PM',
    ),
  ];

  final List<LaundryService> _services = const [
    LaundryService(
      id: 's1',
      name: 'Wash & Fold',
      price: 170.0,
      category: 'Regular',
      description: 'Standard washing, drying, and neat folding (up to 8kg).',
    ),
    LaundryService(
      id: 's2',
      name: 'Wash & Iron',
      price: 210.0,
      category: 'Regular',
      description: 'Full laundry service with steam pressing (up to 8kg).',
    ),
    LaundryService(
      id: 's3',
      name: 'Dry Cleaning',
      price: 240.0,
      category: 'Specialty',
      description: 'Gentle cleaning for formal wear and delicate items (up to 8kg).',
    ),
  ];

  List<LaundryOrder> get orders => List.unmodifiable(_orders);
  List<LaundryService> get services => List.unmodifiable(_services);

  UserProfile? login(String email, String password) {
    if (password != 'password') return null;
    for (final user in users) {
      if (user.email.toLowerCase() == email.trim().toLowerCase()) {
        return user;
      }
    }
    return null;
  }

  List<LaundryOrder> ordersFor(String userId) =>
      _orders.where((o) => o.customerId == userId).toList();

  void addOrder(LaundryOrder order) {
    _orders.insert(0, order);
    notifyListeners();
  }

  void updateStatus(String id, OrderStatus status) {
    final index = _orders.indexWhere((o) => o.id == id);
    if (index != -1) {
      _orders[index] = _orders[index].copyWith(status: status);
      notifyListeners();
    }
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    updateStatus(orderId, newStatus);
  }

  void updateServicePrice(String serviceId, double newPrice) {
    final index = _services.indexWhere((s) => s.id == serviceId);
    if (index != -1) {
      final current = _services[index];
      _services[index] = LaundryService(
        id: current.id,
        name: current.name,
        price: newPrice,
        category: current.category,
        description: current.description,
      );
      notifyListeners();
    }
  }
}