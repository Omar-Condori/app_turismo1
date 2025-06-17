class EmprendimientoModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String ownerId;
  final String ownerName;
  final String address;
  final double latitude;
  final double longitude;
  final String? phoneNumber;
  final String? email;
  final String? website;
  final List<String> images;
  final List<String> services;
  final double rating;
  final int reviewCount;
  final Map<String, String> schedule;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmprendimientoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.ownerId,
    required this.ownerName,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.phoneNumber,
    this.email,
    this.website,
    this.images = const [],
    this.services = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.schedule = const {},
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmprendimientoModel.fromJson(Map<String, dynamic> json) {
    return EmprendimientoModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      ownerId: json['ownerId'],
      ownerName: json['ownerName'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      website: json['website'],
      images: List<String>.from(json['images'] ?? []),
      services: List<String>.from(json['services'] ?? []),
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      schedule: Map<String, String>.from(json['schedule'] ?? {}),
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phoneNumber': phoneNumber,
      'email': email,
      'website': website,
      'images': images,
      'services': services,
      'rating': rating,
      'reviewCount': reviewCount,
      'schedule': schedule,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}