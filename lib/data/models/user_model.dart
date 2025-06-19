class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final bool? active;
  final String? fotoPerfil;
  final String? country;
  final String? birthDate;
  final String? address;
  final String? gender;
  final String? preferredLanguage;
  final String? lastLogin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? photoUrl;
  final String? verificationHash;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.active,
    this.fotoPerfil,
    this.country,
    this.birthDate,
    this.address,
    this.gender,
    this.preferredLanguage,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
    this.photoUrl,
    this.verificationHash,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? value) {
      if (value == null) return null;
      try {
        return DateTime.parse(value);
      } catch (_) {
        return null;
      }
    }
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone']?.toString(),
      active: json['active'] is bool ? json['active'] : (json['active']?.toString() == '1'),
      fotoPerfil: json['foto_perfil']?.toString(),
      country: json['country']?.toString(),
      birthDate: json['birth_date']?.toString(),
      address: json['address']?.toString(),
      gender: json['gender']?.toString(),
      preferredLanguage: json['preferred_language']?.toString(),
      lastLogin: json['last_login']?.toString(),
      createdAt: parseDate(json['created_at']?.toString()),
      updatedAt: parseDate(json['updated_at']?.toString()),
      photoUrl: json['photoUrl']?.toString() ?? json['foto_perfil']?.toString(),
      verificationHash: json['verificationHash']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'active': active,
      'foto_perfil': fotoPerfil,
      'country': country,
      'birth_date': birthDate,
      'address': address,
      'gender': gender,
      'preferred_language': preferredLanguage,
      'last_login': lastLogin,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'photoUrl': photoUrl,
      'verificationHash': verificationHash,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    bool? active,
    String? fotoPerfil,
    String? country,
    String? birthDate,
    String? address,
    String? gender,
    String? preferredLanguage,
    String? lastLogin,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? photoUrl,
    String? verificationHash,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      active: active ?? this.active,
      fotoPerfil: fotoPerfil ?? this.fotoPerfil,
      country: country ?? this.country,
      birthDate: birthDate ?? this.birthDate,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      lastLogin: lastLogin ?? this.lastLogin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      photoUrl: photoUrl ?? this.photoUrl,
      verificationHash: verificationHash ?? this.verificationHash,
    );
  }
}