class LaundryService {
  final String id;
  final String name;
  final double price; // Fixed rate per 8kg
  final String category;
  final String description;

  const LaundryService({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
  });
}