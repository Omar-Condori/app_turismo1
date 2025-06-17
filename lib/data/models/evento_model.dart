class EventoModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String organizerId;
  final String organizerName;
  final String location;
  final double latitude;
  final double longitude;
  final DateTime startDate;
  final DateTime endDate;
  final String? startTime;
  final String? endTime;
  final double? price;
  final String currency;
  final List<String> images;
  final List<String> tags;
  final int capacity;
  final int registeredCount;
  final bool requiresRegistration;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  EventoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.organizerId,
    required this.organizerName,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.startDate,
    required this.endDate,
    this.startTime,
    this.endTime,
    this.price,
    this.currency = 'PEN',
    this.images = const [],
    this.tags = const [],
    this.capacity = 0,
    this.registeredCount = 0,
    this.requiresRegistration = false,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventoModel.fromJson(Map<String, dynamic> json) {
    return EventoModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      organizerId: json['organizerId'],
      organizerName: json['organizerName'],
      location: json['location'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      price: json['price']?.toDouble(),
      currency: json['currency'] ?? 'PEN',
      images: List<String>.from(json['images'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      capacity: json['capacity'] ?? 0,
      registeredCount: json['registeredCount'] ?? 0,
      requiresRegistration: json['requiresRegistration'] ?? false,
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
      'organizerId': organizerId,
      'organizerName': organizerName,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'price': price,
      'currency': currency,
      'images': images,
      'tags': tags,
      'capacity': capacity,
      'registeredCount': registeredCount,
      'requiresRegistration': requiresRegistration,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}