class Profile {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String num;
  final String neighborhood;
  final String role;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.num,
    required this.neighborhood,
    required this.role,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      num: json['num'] ?? '',
      neighborhood: json['neighborhood'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'neighborhood': neighborhood,
      'role': role,
    };
  }
}
