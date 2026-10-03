enum OrderStatus {
  received,
  washing,
  drying,
  readyForPickup,
  completed,
}

extension OrderStatusLabel on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.received:
        return 'Received';
      case OrderStatus.washing:
        return 'Washing';
      case OrderStatus.drying:
        return 'Drying';
      case OrderStatus.readyForPickup:
        return 'Ready for Pickup';
      case OrderStatus.completed:
        return 'Completed';
    }
  }
}

class LaundryOrder {
  final String id;
  final String customerId;
  final String customerName;
  final String serviceType;
  final int quantity;
  final double totalAmount;
  final String paymentStatus;
  OrderStatus status;
  final DateTime pickupDate;
  final String pickupTime;

  LaundryOrder({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.serviceType,
    required this.quantity,
    required this.totalAmount,
    required this.paymentStatus,
    required this.status,
    required this.pickupDate,
    required this.pickupTime,
  });

  LaundryOrder copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? serviceType,
    int? quantity,
    double? totalAmount,
    String? paymentStatus,
    OrderStatus? status,
    DateTime? pickupDate,
    String? pickupTime,
  }) {
    return LaundryOrder(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      serviceType: serviceType ?? this.serviceType,
      quantity: quantity ?? this.quantity,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      status: status ?? this.status,
      pickupDate: pickupDate ?? this.pickupDate,
      pickupTime: pickupTime ?? this.pickupTime,
    );
  }
}
