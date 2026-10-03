enum UserRole { customer, staff, admin }

class UserProfile {
  final String id;
  final String name;
  final String email;
  final UserRole role;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}
