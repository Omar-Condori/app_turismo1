class ServicioModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String providerId;
  final String providerName;
  final double price;
  final String currency;
  final String duration;
  final List<String> images;
  final List<String> includes;
  final List<String> requirements;
  final double rating;
  final int reviewCount;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServicioModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.providerId,
    required this.providerName,
    required this.price,
    this.currency = 'PEN',
    required this.duration,
    this.images = const [],
    this.includes = const [],
    this.requirements = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isAvailable = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServicioModel.fromJson(Map<String, dynamic> json) {
    return ServicioModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      providerId: json['providerId'],
      providerName: json['providerName'],
      price: json['price'].toDouble(),
      currency: json['currency'] ?? 'PEN',
      duration: json['duration'],
      images: List<String>.from(json['images'] ?? []),
      includes: List<String>.from(json['includes'] ?? []),
      requirements: List<String>.from(json['requirements'] ?? []),
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      isAvailable: json['isAvailable'] ?? true,
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
      'providerId': providerId,
      'providerName': providerName,
      'price': price,
      'currency': currency,
      'duration': duration,
      'images': images,
      'includes': includes,
      'requirements': requirements,
      'rating': rating,
      'reviewCount': reviewCount,
      'isAvailable': isAvailable,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}