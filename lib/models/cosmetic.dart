class Cosmetic {
  final String id;
  final String name;
  final String image;
  final double price;
  final String description;
  final bool isActive;

  Cosmetic({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.isActive,
  });

  factory Cosmetic.fromJson(Map<String, dynamic> json) {
    return Cosmetic(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      isActive: json['isActive'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'isActive': isActive,
    };
  }
}
