class AdminService {
  Future<List<User>> fetchUsers() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));
    return [
      User(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        status: 'Active',
        address: '123 Main St, Springfield',
        phoneNumber: '555-1234',
      ),
      User(
        id: '2',
        name: 'Jane Smith',
        email: 'jane@example.com',
        status: 'Inactive',
        address: '456 Elm St, Springfield',
        phoneNumber: '555-5678',
      ),
      // Add more users as needed
    ];
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String status;
  final String address;
  final String phoneNumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.address,
    required this.phoneNumber,
  });
}