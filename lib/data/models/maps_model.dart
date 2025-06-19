class MapsModel {
  final bool success;
  final String? message;
  final MapsData? data;

  MapsModel({
    required this.success,
    this.message,
    this.data,
  });

  factory MapsModel.fromJson(Map<String, dynamic> json) {
    return MapsModel(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null ? MapsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class MapsData {
  final String url;

  MapsData({
    required this.url,
  });

  factory MapsData.fromJson(Map<String, dynamic> json) {
    return MapsData(
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
} 