import 'package:dona_josy/models/product.dart';

class Cart {
  final String id;
  final Product? product;
  final String? status;
  final String? created_at;
  final String? updated_at;
  final String? userName;
  final String? userEmail;
  final String? userPhone;
  final String? userAddress;
  final String? userNum;
  final String? userNeighborhood;

  Cart({
    required this.id,
    this.product,
    this.status,
    this.created_at,
    this.updated_at,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userAddress,
    this.userNum,
    this.userNeighborhood,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final productJson = json['product'];
    final userJson = json['user'];
    return Cart(
      id: json['id'] ?? '',
      product: productJson is Map<String, dynamic>
          ? Product.fromJson(productJson)
          : null,
      status: json['statusCart'] ?? 'ANDAMENTO',
      created_at: json['createdAt'] ?? '',
      updated_at: json['updatedAt'] ?? '',
      userName: userJson is Map<String, dynamic>
          ? userJson['name'] as String?
          : null,
      userEmail: userJson is Map<String, dynamic>
          ? userJson['email'] as String?
          : null,
      userPhone: userJson is Map<String, dynamic>
          ? userJson['phone'] as String?
          : null,
      userAddress: userJson is Map<String, dynamic>
          ? userJson['address']?.toString()
          : null,
      userNum: userJson is Map<String, dynamic>
          ? userJson['num']?.toString()
          : null,
      userNeighborhood: userJson is Map<String, dynamic>
          ? userJson['neighborhood']?.toString()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': product?.name,
      'image': product?.image,
      'price': product?.price,
      'description': product?.description,
      'status': status,
      'created_at': created_at,
      'updated_at': updated_at,
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'userAddress': userAddress,
      'userNum': userNum,
      'userNeighborhood': userNeighborhood,
    };
  }
}
